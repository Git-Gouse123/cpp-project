pipeline {
    agent {
        docker {
            image 'gousedocker1/cpp-project:demo'
            args '-v $BUILD_PATH:/build'
        }
    }
    parameters {
        string(name: 'ProjectName', description: 'Name of the project')
        string(name: 'BuildPath', description: 'Build path')
        string(name: 'BuildCommand', description: 'Build command')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', credentialsId: 'Git', url: 'https://github.com/Git-Gouse123/cpp-project.git'
            }
        }
        stage('Build') {
            steps {
                sh "mkdir -p $BUILD_PATH"
                dir("$BUILD_PATH") {
                    sh "cmake .. -DCMAKE_BUILD_TYPE=coverage"
                    sh "make"
                }
            }
        }
        stage('Test') {
            steps {
                dir("$BUILD_PATH") {
                    sh "make test"
                }
            }
        }
        stage('Coverage') {
            steps {
                dir("$BUILD_PATH") {
                    sh "make coverage"
                }
            }
        }
    }
    
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    
}
