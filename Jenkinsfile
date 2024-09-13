pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="779846825510"
        AWS_DEFAULT_REGION="us-east-1" // Make sure this is correct
        IMAGE_REPO_NAME="jenkins"
        IMAGE_TAG="v4"
        REPOSITORY_URI = "public.ecr.aws/g8u2o4h7/jenkins"
    }


    stages {
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh """
                    aws ecr-public get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}
                    """
                }
            }
        }


        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_REPO_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Pushing to ECR') {
            steps {
                script {
                    sh """
                    docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}
                    docker push ${REPOSITORY_URI}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
