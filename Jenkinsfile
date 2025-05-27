pipeline {
    agent any

    environment {
        REMOTE_HOST = "13.50.56.82"
        APP_DIR = "/home/ec2-user/app"
        APP_NAME = "vite-chat-app"
        SSH_KEY = "C:\\Users\\aruns\\Downloads\\DOCKER.pem"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ArunSadalgekar07/devops.git'
            }
        }

        stage('Deploy to EC2 and Build Docker') {
            steps {
                powershell """
                ssh -i "$env:SSH_KEY" -o StrictHostKeyChecking=no ec2-user@$env:REMOTE_HOST "rm -rf $env:APP_DIR && mkdir -p $env:APP_DIR"
                scp -i "$env:SSH_KEY" -o StrictHostKeyChecking=no -r * ec2-user@$env:REMOTE_HOST:$env:APP_DIR
                ssh -i "$env:SSH_KEY" -o StrictHostKeyChecking=no ec2-user@$env:REMOTE_HOST "cd $env:APP_DIR && docker build -t $env:APP_NAME ."
                """
            }
        }

        stage('Run and Test with Selenium') {
            steps {
                powershell """
                ssh -i "$env:SSH_KEY" -o StrictHostKeyCheckin_
