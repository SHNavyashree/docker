pipeline {
    agent any

    environment { 

        

        IMAGE_NAME = "amazon:1.0"
    }
    stages{

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
    


