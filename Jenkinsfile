pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'vite-chat-app'
        CONTAINER_PORT = '3000'
    }

    stages {
        stage('Clone Repo') {
            steps {
                // Uses credentials configured in Jenkins if needed
                git branch: 'main', url: 'https://github.com/ArunSadalgekar07/devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔧 Building Docker Image...'
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run Tests with Selenium') {
            steps {
                echo '🧪 Running Selenium Tests...'
                sh 'npm install'
                sh 'npm run test' // Ensure this exists in your package.json
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running Docker Container...'
                sh '''
                    docker stop vite-chat || true
                    docker rm vite-chat || true
                    docker run -d --name vite-chat -p $CONTAINER_PORT:$CONTAINER_PORT $DOCKER_IMAGE
                '''
            }
        }
    }
}
