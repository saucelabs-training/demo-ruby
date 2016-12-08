node('docker') {
  stage('Checkout') {
    checkout scm
  }

  stage('Test') {
    sauce('saucelabs') {
      sauceconnect(useGeneratedTunnelIdentifier: true, verboseLogging: true) {
        withEnv(['HOME=$WORKSPACE']) {
          docker.image('ruby:2.2').inside {
            sh 'gem install bundler'
            sh 'bundle install'
            sh 'bundle exec rake test_sauce'
          }
        }
      }
    }
  }
  stage('Collect Results') {
    step([$class: 'SauceOnDemandTestPublisher'])
  }
}
