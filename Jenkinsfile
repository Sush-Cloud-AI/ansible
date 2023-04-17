pipeline {
    agent any
    parameters{

            string(name: 'COMPONENT', defaultValue: 'mongodb', description: 'Enter the name of component.') // supplying value for ENV and COMPONENT in the cammand to parmetrise it.
            choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Choose the environment')
    }

    environment {                   // declaring env variables

        SSH_CRED = credentials('ssh-centos7') // masking the credentials using jenins secret manager .
    }

    stages {
        stage('dry-run'){
            steps {
                sh "env" // to see the env variables for ssh credential keys to use it in ansible user and passowrd in the command to run ansible 
                sh "ansible-playbook robo-ec2.yml -e ansible_user=${SSH_CRED_USR} -e ansible_password=${SSH_CRED_PSW} -e COMPONENT=${params.COMPONENT} -e ENV=${params.ENV}"  // commansd to run the dry run ec2 and destroy 
            }
        }
    }
}