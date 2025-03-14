pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-2'  // Change to your preferred region
        TERRAFORM_DIR = 'terraform/'      // Directory containing Terraform files
        DOCKER_IMAGE_NAME = 'e-commerce-app'  // Name of your Docker image
        ECR_REPOSITORY = 'my-ecr-repo'  // Name of your ECR repository
        EKS_CLUSTER_NAME = 'my-eks-cluster'  // Name of your EKS cluster
        AWS_ACCOUNT_ID = 'your-aws-account-id'  // Your AWS account ID
        MANIFEST_DIR = 'manifests/'  // Directory containing Kubernetes YAML files
    }

    triggers {
        pollSCM '*/* * * *'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/your-terraform-code.git' // Replace with your repo
            }
        }

        stage('Terraform Init') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Retrieve EKS cluster name from Terraform output
                    env.EKS_CLUSTER_NAME = sh(script: "terraform output -raw eks_cluster_name", returnStdout: true).trim()
                    def dockerImage = docker.build(env.DOCKER_IMAGE_NAME, '.')
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${env.AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_DEFAULT_REGION}.amazonaws.com"
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Tag and push the Docker image to ECR
                    def ecrRepoUri = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_DEFAULT_REGION}.amazonaws.com/${env.ECR_REPOSITORY}"
                    sh "docker tag ${env.DOCKER_IMAGE_NAME}:latest ${ecrRepoUri}:latest"
                    sh "docker push ${ecrRepoUri}:latest"
                }
            }
        }

        stage('Update Kubernetes Deployment with New Image') {
            steps {
                script {
                    // Modify the deployment.yaml file to use the new ECR image URI
                    sh """
                    sed -i 's|image: .*|image: ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_DEFAULT_REGION}.amazonaws.com/${env.ECR_REPOSITORY}:latest|' ${env.MANIFEST_DIR}/deployment.yaml
                    """
                    
                    // Apply the Kubernetes manifests (deployment and service)
                    sh """
                    kubectl apply -f ${env.MANIFEST_DIR}/deployment.yaml --kubeconfig=kubeconfig.yaml
                    kubectl apply -f ${env.MANIFEST_DIR}/service.yaml --kubeconfig=kubeconfig.yaml
                    """
                }
            }
        }

        stage('Destroy Resources') {
            when {
                expression { return params.DESTROY_RESOURCES }  // Only execute if "DESTROY_RESOURCES" is true
            }
            steps {
                dir(env.TERRAFORM_DIR) {
                    sh 'terraform destroy -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }

    parameters {
        booleanParam(
            name: 'DESTROY_RESOURCES',
            defaultValue: false,
            description: 'Set this to true if you want to destroy all EKS resources'
        )
    }
}
