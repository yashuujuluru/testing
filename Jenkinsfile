pipeline {
    agent any

    environment {
        // Set your environment variables here
        AWS_REGION = 'us-east-1'  // E.g., us-east-1
        ECR_REPO = '025066245756.dkr.ecr.us-east-1.amazonaws.com/yashu'  // E.g., 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-repo
        IMAGE_TAG = "v1"  // Tagging image with Jenkins build number
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your GitHub repository
                git branch: 'master', url: 'https://github.com/yashuujuluru/testing.git'
            }
        }

        stage('AWS ECR Login') {
            steps {
                // AWS CLI Login to ECR
                script {
                    sh '''
                    # Login to ECR
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image
                script {
                    sh '''
                    docker build -t $ECR_REPO:$IMAGE_TAG .
                    '''
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                // Push the Docker image to ECR
                script {
                    sh '''
                    docker push $ECR_REPO:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Clean Up') {
            steps {
                // Clean up local Docker images
                script {
                    sh '''
                    docker rmi $ECR_REPO:$IMAGE_TAG || true
                    '''
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace after build
            cleanWs()
        }

        success {
            echo "Docker image successfully built and pushed to ECR: $ECR_REPO:$IMAGE_TAG"
        }

        failure {
            echo "Build failed. Check the Jenkins logs for more information."
        }
    }
}
