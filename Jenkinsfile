pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker container image for Spotify Clone...'
                bat 'docker build -t spotify-clone:latest .'
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Deploying application container with port mapping 3000:80...'
                bat '''
                    docker stop spotify-app 2>nul || ver >nul
                    docker rm spotify-app 2>nul || ver >nul
                    docker run -d -p 3000:80 --name spotify-app spotify-clone:latest
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Checking running container status...'
                bat 'docker ps --filter "name=spotify-app"'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Spotify Clone is live at http://localhost:3000'
        }
        failure {
            echo 'Pipeline failed. Check build logs.'
        }
    }
}
