pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="590184127016"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="kuberenetesacr"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "590184127016.dkr.ecr.us-east-1.amazonaws.com/kuberenetesacr"
    }
   
    stages {
        stage('Building image') {
          steps{
            script {
                docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}", "-f ${DOCKERFILE_PATH} .")
            }
          }
        }
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
                }
                 
            }
        }
  
    // Building Docker images
    
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"""
                sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
         }
        }
      }
    }
}
