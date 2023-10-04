pipeline {
    agent any
    
    parameters {
        choice(
            choices: 'dev\nstaging\nproduction',
            description: 'Select environment',
            name: 'ENVIRONMENT'
        )
    }
    environment {
        AWS_ACCESS_KEY_ID=credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY=credentials('aws_secret_access_key')
    }
    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    def environment = params.ENVIRONMENT
                    
                    // Configure AWS credentials
                    withAWS(credentials: 'aws-credentials-id') {
                        // Clone the Terraform code from the GitHub repository
                        git branch: 'main', credentialsId: 'github-credentials-id', url: 'https://github.com/alaaIseif/terraformAWS-handson/tree/4e50c078c224c46bcdd01f998065b84641950a7c/Day2'
                        
                        // Change to the cloned repository directory
                        dir('repo') {
                            // Install Terraform (assuming it's not pre-installed)
                            sh 'curl -O https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip'
                            sh 'unzip terraform_0.15.4_linux_amd64.zip'
                            sh 'mv terraform /usr/local/bin/'
                        }
                    }
                }
            }
        }
        
        stage('Apply Terraform') {
            steps {
                script {
                    def environment = params.ENVIRONMENT
                    
                    // Change to the Terraform code directory
                    dir('repo') {
                        // Perform any pre-Terraform steps if needed
                        
                        // Run Terraform apply command for the selected environment
                        sh "terraform init"
                        sh "terraform apply -var-file=${environment}.tfvars"
                        
                        // Perform any post-Terraform steps if needed
                    }
                }
            }
        }
    }
}