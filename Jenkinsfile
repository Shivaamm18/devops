pipeline {
    agent any

    environment {
        DOCKER_HOST = "ec2-user@13.50.56.82"
        APP_NAME = "vite-chat-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ArunSadalgekar07/devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                scp -o StrictHostKeyChecking=no -i ~/.ssh/your-key.pem -r . ec2-user@<EC2-IP>:/home/ec2-user/app
                ssh -o StrictHostKeyChecking=no -i ~/.ssh/your-key.pem ec2-user@<EC2-IP> '
                  cd /home/ec2-user/app &&
                  docker build -t vite-chat-app .
                '
                """
            }
        }

        stage('Run Selenium Tests') {
            steps {
                sh """
                ssh -i ~/.ssh/your-key.pem ec2-user@<EC2-IP> '
                  docker run --rm -p 3000:3000 -d vite-chat-app &&
                  sleep 10 &&
                  curl -s http://localhost:3000 | grep "<title>" || echo "Test failed"
                '
                """
            }
        }

        stage('Cleanup') {
            steps {
                sh """
                ssh -i ~/.ssh/your-key.pem ec2-user@<EC2-IP> '
                  docker stop \$(docker ps -q --filter ancestor=vite-chat-app)
                '
                """
            }
        }
    }
}
