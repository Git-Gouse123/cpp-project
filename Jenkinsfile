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
            tool: warningsNg(), // Use the Warnings Next Generation plugin
            aggregatingResults: true,
            name: 'Warnings', // Specify a name for the tool (e.g., 'Warnings')
            sourceCodeEncoding: '', // Set the source code encoding
            filters: [excludePattern: '', includePattern: '**/*.cpp'], // Adjust the exclude and include patterns
            healthy: 0, // Set a value for the healthy threshold (e.g., 0 for no warnings)
            unHealthy: 0, // Set a value for the unhealthy threshold (e.g., 0 for no warnings)
            canResolveRelativePaths: false,
            ignoreQualityGate: false
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
