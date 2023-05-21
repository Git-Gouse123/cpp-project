pipeline {
    agent any
    
    parameters {
        string(name: 'ProjectName', defaultValue: 'cpp-project', description: 'Name of the project')
        string(name: 'BuildPath', defaultValue: 'build/', description: 'Build path')
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
                sh "mkdir -p $BuildPath"
                dir("$BuildPath") {
                    sh "cmake .. -DCMAKE_BUILD_TYPE=coverage"
                    sh "make"
                }
            }
        }
        
        stage('Test') {
            steps {
                dir("$BuildPath") {
                    sh "make test"
                }
            }
        }
        
        stage('Coverage') {
            steps {
                dir("$BuildPath") {
                    sh "make coverage"
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                dir("$workspace") {
                    sh "/var/lib/jenkins/workspace/cpp-project_master/sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner"
                }
            }
        }
    }
    
    post {
        success {
            echo 'Build succeeded!'
        }
        
        failure {
            echo 'Build failed!'
        }
    }
}
