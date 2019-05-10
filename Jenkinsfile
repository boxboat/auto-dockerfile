properties([
  pipelineTriggers([cron('H 8 * * *')]),
  [$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', numToKeepStr: '100']],
])

throttle(['docker']) {
  node(label: 'docker') {
    stage('Initialize') {
        sh '''
          ./cicd/build-pre.sh
        '''
    }
    stage ('Build') {
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
