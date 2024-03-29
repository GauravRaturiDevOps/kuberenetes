pipeline {
    agent any
    
    environment {
        IMAGE_REPO_NAME = "nodekube12"
        DOCKERHUB_CREDENTIALS= credentials('DOCKER_CRED') 
    }
   
    stages {
        stage('Building image') {
          steps{
            script {
                docker.build("${IMAGE_REPO_NAME}:$BUILD_NUMBER", "-f node/Dockerfile .")
            }
          }
        }
        

        stage('Check Changes in node Folder') {
            steps {
                script {
                    def changes = changeset([$class: 'Changeset'])
                    def nodeChanges = changes.getFiles('./node/')
                    if (nodeChanges) {
                        echo 'Changes detected in the node folder. Starting pipeline.'
                    } else {
                        echo 'No changes detected in the node folder. Skipping pipeline execution.'
                        currentBuild.result = 'ABORTED'
                        return
                    }
                }
            }
        }
        
        stage('Login to Docker Hub') {      	
            steps{                       	
        	sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                		
        	echo 'Login Completed'      
            }           
        } 
  
    // Building Docker images
    
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh """docker tag ${IMAGE_REPO_NAME}:$BUILD_NUMBER ${DOCKERHUB_CREDENTIALS_USR}/${IMAGE_REPO_NAME}:$BUILD_NUMBER"""
                sh """docker push ${DOCKERHUB_CREDENTIALS_USR}/${IMAGE_REPO_NAME}:$BUILD_NUMBER"""
         }
        }
      }
    }
}
