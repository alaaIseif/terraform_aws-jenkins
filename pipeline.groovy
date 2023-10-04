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
                    branch: "master",
                    poll: true
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
                    def environment = params.server
                    if (environment == 'dev') {
                        tfVars_filename = "dev.tfvars"
                        sh 'terraform workspace new dev || true' 
                        sh 'terraform workspace select dev '
                    } else if (environment == 'prod') {
                        tfVars_filename = "prod.tfvars"
                        sh 'terraform workspace new prod || true' 
                        sh 'terraform workspace select prod '
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                     if (environment == 'dev') {
                        tfVars_filename = "dev.tfvars"
                        sh 'terraform workspace select dev '
                    } else if (environment == 'prod') {
                        tfVars_filename = "prod.tfvars"
                        sh 'terraform workspace select prod '
                    }
                     // Run Terraform plan command for the selected environment
                    sh "terraform plan -var-file=${tfVars_filename}"
                }
            }
        }

       stage('Terraform Apply') {
            steps {
                // Run Terraform apply with approval prompt
                script {
                    def approval = input(
                        id: 'terraform-apply-approval',
                        message: 'Do you want to perform these actions? Enter "yes" to approve.',
                        parameters: [
                            [$class: 'TextParameterDefinition', defaultValue: '', description: '', name: 'approval']
                        ]
                    )

                    if (approval.trim() == 'yes') {
                        withCredentials([string(credentialsId: 'tfVars_filename', variable: 'tfVars_filename')]) {
                            sh "terraform apply -var-file=${tfVars_filename}"
                        }
                    } else {
                        error('Approval not granted. Aborting Terraform apply.')
                    }
                }
            }
        }
    }
}