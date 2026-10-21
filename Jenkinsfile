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
                sh 'docker build -t spotify-clone:latest .'
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Deploying application container with port mapping 3000:80...'
                sh '''
                    docker stop spotify-app || true
                    docker rm spotify-app || true
                    docker run -d -p 3000:80 --name spotify-app spotify-clone:latest
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Checking running container status...'
                sh 'docker ps --filter "name=spotify-app"'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Spotify Clone is live.'
        }
        failure {
            echo 'Pipeline failed. Check build logs.'
        }
    }
}
