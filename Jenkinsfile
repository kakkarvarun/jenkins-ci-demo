pipeline {
  agent any
  options { skipDefaultCheckout(true); timestamps() }  // nice timestamps in logs

  // Poll every 5 minutes (H spreads load randomly within the minute)
  triggers { pollSCM('H/5 * * * *') }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh '''
          echo "🔧 Simulating build..."
          sleep 2
          echo "✅ Build step complete"
        '''
      }
    }
    stage('Test') {
      steps {
        sh '''
          chmod +x scripts/run_tests.sh app/app.sh
          bash scripts/run_tests.sh
        '''
      }
    }
  }

  post {
  success {
    echo "🎉 SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
    mail to: 'kakkar.varun67@gmail.com',
         subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
         body: "Build URL: ${env.BUILD_URL}\nCommit: ${env.GIT_COMMIT}"
  }
  failure {
    echo "❌ FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
    mail to: 'kakkar.varun67@gmail.com',
         subject: "FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
         body: "Build URL: ${env.BUILD_URL}\nCheck console output."
  }
}

