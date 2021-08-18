@Library('boxboat-dockhand@master') _

properties([
  pipelineTriggers([cron('H 8 * * *')]),
  buildDiscarder(logRotator(numToKeepStr: '100'))
])

kubeRunner.build {
  stage('Initialize') {
      checkout scm
      sh '''
        ./cicd/build-pre.sh
      '''
  }
  stage ('Build') {
    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
      parallel (
        "helm": {
          sh '''
            ./helm/build.sh
          '''
        },
        "istioctl": {
          sh '''
            ./istioctl/build.sh
          '''
        },
        "kubectl": {
          sh '''
            ./kubectl/build.sh
          '''
        },
        "lego": {
          sh '''
            ./lego/build.sh
          '''
        },
      )
    }
  }
}
