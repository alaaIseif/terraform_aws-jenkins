tfVars_filename = ""
pipeline {
    agent any
    
    parameters {
        choice(
            choices: 'dev\nprod',
            description: 'Select environment',
            name: 'ENVIRONMENT'
        )
    }
     environment {
        AWS_ACCESS_KEY_ID=credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY=credentials('aws_secret_access_key')
    }
    
    stages {

        stage("Clone Git Repository") {
            steps {
                git(
                    url: "https://github.com/alaaIseif/terraform_aws-jenkins.git",
                    branch: "main"
                )
            }
        }
        //Initializing
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Selecting workspace') {
            steps {
                script {
                    tfVars_filename = "${params.ENVIRONMENT}.tfvars"
                    sh "terraform workspace new ${environment} || terraform workspace select ${environment}"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                     // Run Terraform plan command for the selected environment
                    sh "terraform plan --var-file=${tfVars_filename}"
                }
            }
        }

       stage('Terraform Apply') {
            steps {
                // Run Terraform apply with approval prompt
                script {
                        sh "terraform apply -auto-approve --var-file ${tfVars_filename}"
                }
            }
        }
    }
}