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
                // Checkout your source code from version control (e.g., Git)
                // Replace the repository URL and credentials with your own
                git branch: 'master', credentialsId: 'Git', url: 'https://github.com/Git-Gouse123/cpp-project.git'
            }
        }
        stage('Build') {
            steps {
                sh "mkdir -p $BUILD_PATH"
                dir("$BUILD_PATH") {
                    sh "cmake .. -DCMAKE_BUILD_TYPE=coverage" // Modify the path to your CMakeLists.txt
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
    post {
        always {
            // Release the Docker container
            docker.image('gousedocker1/cpp-project:demo').remove()
        }
        success {
            // Perform additional actions on successful build
            echo 'Build succeeded!'
        }
        failure {
            // Perform additional actions on build failure
            echo 'Build failed!'
        }
    }
}
