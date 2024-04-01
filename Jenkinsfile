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
    stage ('Updating the Deployment File') {
            environment {
                GIT_REPO_NAME = "kubernetesdeployments"
                GIT_USER_NAME = "GauravRaturiDevOps"
            }
            steps {
                withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]){
                    sh '''
                    
                        git pull https://github.com/GauravRaturiDevOps/kubernetesdeployments.git
                        git config  user.email "raturigaurav.seaisainfotech.com"
                        git config  user.name "GauravRaturiDevOps"
                        echo "i am here in username"
                        git checkout master
                        BUILD_NUMBER=${BUILD_NUMBER}
                        echo "i am here in build number"
                        sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" dev/deployments.yml
                        git add dev/deployments.yml
                        git commit -m "updated the image ${BUILD_NUMBER}"
                        git push @github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME">https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                        
                       
                    '''
                }
            }
        
    }
}
}
