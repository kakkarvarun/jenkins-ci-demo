pipeline {
  agent any
  options { skipDefaultCheckout(true); timestamps() }

  // Poll every ~5 minutes
  triggers { pollSCM('H/5 * * * *') }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        // keep these as single-line sh steps to avoid quoting issues
        sh 'echo "🔧 Simulating build..."'
        sh 'sleep 2'
        sh 'echo "✅ Build step complete"'
      }
    }

    stage('Test') {
      steps {
        // convert Windows CRLF to LF so bash won’t choke
        sh 'sed -i "s/\\r$//" scripts/run_tests.sh app/app.sh'
        sh 'chmod +x scripts/run_tests.sh app/app.sh'
        sh 'bash scripts/run_tests.sh'
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
}
