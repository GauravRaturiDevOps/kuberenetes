pipeline {
    agent any
    environment {
        username = "seasiainfotechdocker"
        password = "Minddocker@123"
        IMAGE_REPO_NAME = "nodekube12"
        IMAGE_TAG = $BUILD_NUMBER
        DOCKERHUB_CREDENTIALS= credentials('dockerhubcredentials') 
    }
   
    stages {
        stage('Building image') {
          steps{
            script {
                docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}", "-f node/Dockerfile .")
            }
          }
        }
        stage('Login to Docker Hub') {      	
            steps{                       	
        	sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                		
        	echo 'Login Completed'      
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
