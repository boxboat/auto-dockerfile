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
  stage ('Checksum') {
    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
      parallel (
        "helm": {
          sh '''
            ./helm/build-checksum.sh
          '''
        },
        "istioctl": {
          sh '''
            ./istioctl/build-checksum.sh
          '''
        },
        "kubectl": {
          sh '''
            ./kubectl/build-checksum.sh
          '''
        },
        "lego": {
          sh '''
            ./lego/build-checksum.sh
          '''
        },
      )
    }
    sh 'docker logout'
  }
  stage ('Build') {
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
  stage ('Push') {
    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
      parallel (
        "helm": {
          sh '''
            ./helm/push.sh
          '''
        },
        "istioctl": {
          sh '''
            ./istioctl/push.sh
          '''
        },
        "kubectl": {
          sh '''
            ./kubectl/push.sh
          '''
        },
        "lego": {
          sh '''
            ./lego/push.sh
          '''
        },
      )
    }
  }
}
