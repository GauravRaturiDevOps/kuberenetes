pipeline {
    agent any
    environment {
        username = "seasiainfotechdocker"
        password = "Minddocker@123"
        IMAGE_REPO_NAME = "nodekube12"
        IMAGE_TAG = "node-v1"
    }
   
    stages {
        stage('Building image') {
          steps{
            script {
                docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}", "-f node/Dockerfile .")
            }
          }
        }
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh """docker login --username ${username} --password-stdin ${password}"""
                }
                 
            }
        }
  
    // Building Docker images
    
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${username}/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
                sh """docker push ${username}/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
         }
        }
      }
    }
}
