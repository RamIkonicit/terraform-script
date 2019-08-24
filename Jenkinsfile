pipeline {
    agent {
        node {
            label 'master'
        }
    }

    stages {

        stage('terraform started') {
            steps {
                sh 'echo "Started...!" '
            }
        }
        stage('terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps {
                sh 'terraform apply'
            }
        }
        stage('terraform ended') {
            steps {
                sh 'echo "Ended....!!"'
            }
        }


    }
}
