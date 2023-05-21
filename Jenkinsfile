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
                git branch: 'feature/cpp-project-test', credentialsId: 'Git', url: 'https://github.com/Git-Gouse123/cpp-project.git'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    sh "mkdir -p ${params.BuildPath}"
                    dir("${params.BuildPath}") {
                        sh "cmake .. -DCMAKE_BUILD_TYPE=coverage"
                        sh "make"
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    dir("${params.BuildPath}") {
                        sh "make test"
                    }
                }
            }
        }
        
        stage('Coverage') {
            steps {
                script {
                    dir("${params.BuildPath}") {
                        sh "make coverage"
                    }
                }
            }
        }
	stage('Compiler Warnings') {
    steps {
        recordIssues(
            tools: [
                pmdParser(pattern: '**/*.cpp'),
                checkStyle(pattern: '**/*.cpp')
            ],
            enabledForFailure: true,
            healthy: 1,
            unhealthy: 20,
            ignoreQualityGate: true,
            ignoreFailedBuilds: false,
            publishAllIssues: true,
            quiet: true,
            skipBlames: true,
            sourceCodeEncoding: 'UTF-8',
            trendChartType: 'TOOLS_AGGREGATION'
        )
    }
}


		
        stage('SonarQube Analysis') {
            steps {
                script {
                    dir("${workspace}") {
                        sh "/var/lib/jenkins/workspace/cpp-project_master/sonar-scanner-4.6.2.2472-linux/bin/sonar-scanner"
                    }
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
