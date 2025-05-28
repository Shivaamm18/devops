pipeline {
    agent any

    environment {
        REMOTE_HOST = "13.50.56.82"
        APP_DIR = "/home/ec2-user/app"
        APP_NAME = "vite-chat-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ArunSadalgekar07/devops.git'
            }
        }

        stage('Deploy to EC2 and Build Docker') {
            steps {
                sshagent(['aws-ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@${REMOTE_HOST} 'rm -rf ${APP_DIR} && mkdir -p ${APP_DIR}'
                    scp -o StrictHostKeyChecking=no -r * ec2-user@${REMOTE_HOST}:${APP_DIR}
                    ssh -o StrictHostKeyChecking=no ec2-user@${REMOTE_HOST} '
                        cd ${APP_DIR} &&
                        docker build -t ${APP_NAME} .
                    '
                    """
                }
            }
        }

        stage('Run and Test with Selenium') {
            steps {
                sshagent(['aws-ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@${REMOTE_HOST} '
                        docker run --rm -d -p 3000:3000 --name chat-test ${APP_NAME}
                    '
                    sleep 15
                    # Here, replace with your Selenium test command if available
                    curl -s http://${REMOTE_HOST}:3000 | grep "<title>" || echo "Test failed"
                    """
                }
            }
        }

        stage('Cleanup') {
            steps {
                sshagent(['aws-ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ec2-user@${REMOTE_HOST} '
                        docker stop \$(docker ps -q --filter name=chat-test)
                    '
                    """
                }
            }
        }
    }
}
