pipeline {
    agent any
    
    environment {
        IMAGE_REPO_NAME = "nodekube12"
    }
   
    stages {
        stage('Building image') {
            steps {
                script {
                    docker.build("${IMAGE_REPO_NAME}:$BUILD_NUMBER", "-f node/Dockerfile .")
                }
            }
        }
        
        stage('Login to Docker Hub') {      	
            steps {                       	
                withCredentials([usernamePassword(credentialsId: 'DOCKER_CRED', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR')]) {
                    sh "echo \${DOCKERHUB_CREDENTIALS_PSW} | docker login -u \${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    echo 'Login Completed'      
                }           
            } 
        } 
  
        stage('Pushing to Docker Hub') {
            steps {
                script {
                    docker.withRegistry("https://index.docker.io/v1/", "${DOCKERHUB_CREDENTIALS_USR}", "${DOCKERHUB_CREDENTIALS_PSW}") {
                        docker.image("${IMAGE_REPO_NAME}:$BUILD_NUMBER").push()
                    }
                }
            }
        }
        
        stage('Updating the Deployment File') {
            environment {
                GIT_REPO_NAME = "kubernetesdeployments"
                GIT_USER_NAME = "GauravRaturiDevOps"
            }
            steps {
                withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                        git clone https://github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git
                        git config user.email "raturigaurav@seasiainfotech.com"
                        git config user.name "GauravRaturiDevOps"
                        sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" ${GIT_REPO_NAME}/dev/deployments.yml
                        cd ${GIT_REPO_NAME}
                        git add .
                        git commit -m "Updated the image ${BUILD_NUMBER}"
                        git push origin main
                    '''
                }
            }
        }
    }
}
