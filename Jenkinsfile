pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        KUBECONFIG = credentials('kubeconfig-credential-id') // Replace with the Jenkins credential ID for kubeconfig
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Run Terraform') {
            steps {
                withAWS(role: 'jenkins_role', region: "${AWS_REGION}") {
                    sh '''
                    terraform init
                    terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    docker.build('your-image-name:latest').push('your-dockerhub-username/your-image-name:latest')
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                kubectl apply -f deployment.yaml
                kubectl rollout status deployment/your-deployment-name
                '''
            }
        }
    }
}
