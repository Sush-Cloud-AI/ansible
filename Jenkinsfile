

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
        stage('Lint check'){  // will run only against any feature branch 
            when { branch pattern: "feature-.*", comparator: "REGEXP"}  // use . befor *  for regex missing in official doc of jenkins
            steps{
                sh "env"
                sh " echo style check and running in feature branch"
            }
        }



        stage('dry-run'){ // will run against only hen PR is rasied 
            when { branch pattern: "PR-.*", comparator: "REGEXP"}  // use . befor *  for regex missing in official doc of jenkins
            steps {
                sh "env" // to see the env variables for ssh credential keys to use it in ansible user and passowrd in the command to run ansible 
                sh "ansible-playbook robo-ec2.yml -e ansible_user=${SSH_CRED_USR} -e ansible_password=${SSH_CRED_PSW} -e COMPONENT=${params.COMPONENT} -e ENV=${params.ENV}"  // commansd to run the dry run ec2 and destroy 
            }
        }
        
        stage('promote to prod'){
            when{ branch 'main'} // will run only when the branch is main 
            steps{    
                sh " echo runs when you push a git tag"
            }
        }
        
    }
}