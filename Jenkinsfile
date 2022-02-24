pipeline {
    agent any

    stages {

        stage ('Checkout') {
            steps {
                    checkout([$class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    extensions: [], 
                    userRemoteConfigs: [[credentialsId: 'githubpassword', 
                    url: 'https://github.com/valyakem/terraform-aws.git']]]);

                    sh 'echo terraform --version'
                    sh 'terraform --version'
                    sh 'terraform init'
                }

        } 
        stage('TF Plan') {
            steps {
               sh 'terraform plan'     
            }    
         }
        stage ('Send Aproval Email') {
            steps {
                mail(
                body: "Hi ${currentBuild.fullDisplayName}, please kindly login and approve the pipeline build stage. Link to pipeline  ${env.BUILD_URL} has result ${currentBuild.result}", 
                cc: "", 
                from: "nexbits@zohomail.com", 
                replyTo: "valentine.akem@nexgbits.com", 
                subject: "Test email using mailer", 
                to: "valentine.akem@nexgbits.com"
                )
            }
        }
        stage('TF Destroy') {
            options{
                timeout(time: 10, unit: 'MINUTES')
                } 
            input{
                    message "Should we continue?"
                    ok "Yes"
                }
            
            steps {
                sh 'terraform destroy -auto-approve'
                }    
         }
    }
}