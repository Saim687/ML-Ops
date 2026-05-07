pipeline {
    agent any
    
    environment {
        GITHUB_REPO = 'https://github.com/Saim687/ML-Ops.git'
        DOCKER_IMAGE = 'mlops-app'
        DOCKER_PORT = '8000'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '=== Fetching data from GitHub ==='
                git branch: 'main', url: "${GITHUB_REPO}"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo '=== Building Docker image ==='
                sh 'docker build -t ${DOCKER_IMAGE}:latest .'
            }
        }
        
        stage('Run Docker Container') {
            steps {
                echo '=== Running Docker container ==='
                sh '''
                    # Stop existing container if running
                    docker stop ${DOCKER_IMAGE} || true
                    docker rm ${DOCKER_IMAGE} || true
                    
                    # Run new container
                    docker run -d \
                        --name ${DOCKER_IMAGE} \
                        -p ${DOCKER_PORT}:8000 \
                        ${DOCKER_IMAGE}:latest
                '''
            }
        }
        
        stage('Verify API') {
            steps {
                echo '=== Verifying API accessibility ==='
                sh '''
                    sleep 5
                    curl -X GET http://localhost:${DOCKER_PORT}/metrics
                '''
            }
        }
    }
    
    post {
        success {
            echo '✓ Pipeline completed successfully!'
            echo '✓ API accessible at http://localhost:8000/metrics'
        }
        failure {
            echo '✗ Pipeline failed!'
        }
    }
}
