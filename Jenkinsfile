ipipeline {
    agent any

    environment {
        IMAGE_NAME = "youracr.azurecr.io/yourapp:${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your/repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Azure Container Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure-acr-creds', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
                    sh 'echo $ACR_PASS | docker login youracr.azurecr.io -u $ACR_USER --password-stdin'
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        stage('Provision Azure Infrastructure') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy App using Ansible') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i hosts deploy.yml --extra-vars "image=$IMAGE_NAME"'
                }
            }
        }

        stage('Test Application') {
            steps {
                sh 'curl -f http://<your-vm-ip>/ || exit 1'
            }
        }
    }
}

