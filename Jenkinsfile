pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "830389645667.dkr.ecr.us-east-1.amazonaws.com/swayatt"
        IMAGE_NAME = "devops-task"
    }

    triggers {
        githubPush()   // triggers pipeline when code is pushed to GitHub
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/SwayattDrishtigochar/devops-task.git',
                    credentialsId: 'github-token'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    echo "Logging into AWS ECR..."
                    aws ecr get-login-password --region $AWS_REGION \
                        | docker login --username AWS --password-stdin $ECR_REPO

                    echo "Building Docker image..."
                    docker build -t $IMAGE_NAME:latest .

                    echo "Tagging Docker image..."
                    docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                    '''
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh '''
                    echo "Pushing Docker image to ECR..."
                    docker push $ECR_REPO:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh '''
                    echo "Deploy step placeholder - options:
                    1. Run on ECS (Fargate or EC2).
                    2. Run on EKS (Kubernetes).
                    3. Or simple Docker run on EC2."
                    '''
                }
            }
        }
    }
}
