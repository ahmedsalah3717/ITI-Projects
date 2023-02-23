pipeline {
    agent { label 'jenkins-agent' }
    parameters {
        choice(name: 'ENV', choices: ['dev', 'test', 'prod',"release"])
    } 
    stages {
        stage('build') {
            steps {
                script {
                   if (params.ENV == "release") {
                       withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            sh """
                                docker login -u $USERNAME -p $PASSWORD
                                docker build -t ahmedsalah3717/finalproject:${BUILD_NUMBER} .
                                docker push ahmedsalah3717/finalproject:${BUILD_NUMBER}
                            """
                            }
                    }
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    if (params.ENV == "dev" || params.ENV == "test" || params.ENV == "prod") {
                            withCredentials([file(credentialsId: 'kubernetes_kubeconfig', variable: 'KUBECONFIG')]) {
               sh """
                     kubectl apply -f deployment --kubeconfig=${KUBECONFIG}
                  """
                        }
                    }
                }
            }
        }
    }
}
