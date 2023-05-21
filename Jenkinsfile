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
                cppcheck(pattern: '**/*.cpp'), // Use the Cppcheck tool to analyze C++ code
                clangScanBuild(pattern: '**/*.cpp') // Use the Clang Scan-Build tool for static code analysis
            ],
            aggregatingResults: true,
            filters: [
                excludePattern('.*\\.h$'), // Exclude header files from analysis
                excludeFile('**/*.cpp') // Exclude specific files from analysis
            ],
            healthy: 1, // Set a value for the healthy threshold (e.g., 1 warning)
            unhealthy: 20, // Set a value for the unhealthy threshold (e.g., 20 warnings)
            sourceCodeEncoding: 'UTF-8' // Specify the encoding of the source code files
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
