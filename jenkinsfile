pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-credentials-id',
                    url: 'https://github.com/amira-abbas/guest_book.git'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t amira-abbas/guest_book:latest .'
            }
        }
        stage('Push') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push amira-abbas/guest_book:latest'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
