pipeline {
    agent any
    
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
    def scannerHome = tool 'SonarScanner';
    withSonarQubeEnv() {
      sh "${scannerHome}/bin/sonar-scanner"
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
