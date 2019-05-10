properties([
  pipelineTriggers([cron('H 8 * * *')]),
  [$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', numToKeepStr: '100']],
])

throttle(['docker']) {
  node(label: 'docker') {
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
}
