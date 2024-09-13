pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="779846825510"
        AWS_DEFAULT_REGION="us-east-1" // Make sure this is correct
        IMAGE_REPO_NAME="jenkins"
        IMAGE_TAG="v6"
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

           stage('K8S Deploy') {
            steps {
                script {
                    withAWS(credentials: '779846825510', region: '${AWS_DEFAULT_REGION}') {
                        sh 'aws eks update-kubeconfig --name jenkins-eks --region ${AWS_DEFAULT_REGION}'
                        sh 'kubectl apply -f deployment.yaml'
                    }
                }
            }
        }

        stage('Get Service URL') {
            steps {
                script {
                    def serviceUrl = ""
                    // Wait for the LoadBalancer IP to be assigned
                    timeout(time: 5, unit: 'MINUTES') {
                        while(serviceUrl == "") {
                            serviceUrl = sh(script: "kubectl get svc html -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
                            if(serviceUrl == "") {
                                echo "Waiting for the LoadBalancer IP..."
                                sleep 10
                            }
                        }
                    }
                    echo "Service URL: http://${serviceUrl}"
                }
            }
        }
    }
}
