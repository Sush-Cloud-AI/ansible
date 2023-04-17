pipeline {
    agent any

    stages {
        stage('dry-run'){
            steps {

                sh "ansible-playbook robo-ec2.yml -e ansible_user=centos -e ansible_password=DevOps321 -e COMPONENT=mongodb -e ENV=dev"
            }
        }
    }
}