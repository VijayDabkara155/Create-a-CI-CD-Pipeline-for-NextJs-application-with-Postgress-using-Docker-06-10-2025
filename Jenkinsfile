pipeline {
    agent any

    environment {
        DOCKER_COMPOSE = "/usr/local/bin/docker-compose"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_GITHUB_REPO.git'
            }
        }

        stage('Clean Up') {
            steps {
                sh 'docker compose down -v --remove-orphans || true'
                sh 'docker rm -f postgres_db || true'
            }
        }

        stage('Build Images') {
            steps {
                sh 'docker compose build --no-cache'
            }
        }

        stage('Deploy Containers') {
            steps {
                sh 'docker compose up -d'
            }
        }
    }

    post {
        always {
            sh 'docker system prune -af || true'
        }
        success {
            echo "Deployment successful 🎉"
        }
        failure {
            echo "Deployment failed ❌"
        }
    }
}

