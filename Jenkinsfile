node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        sh 'docker build -t the1andonlydavepublic/hellonode .'
    }

    stage('Test image') {
           sh 'docker stop myjob'
	       sh 'docker rm -f myjob && echo "container myjob removed" || echo "container myjob does not exist"'
            sh 'hostname'
            sh 'docker run -d --rm -p 8000:8000 --name myjob the1andonlydavepublic/hellonode'
            sh 'sleep 5'
            /* If we don't find "Hello" in the curl-result we break the pipeline here. */
            sh 'curl -s http://172.17.0.1:8000/ | grep "Hello"'
    }
    
    stage('Test image with docker-compose') {
           sh 'docker stop myjob'
           sh 'docker rm -f myjob && echo "container myjob removed" || echo "container myjob does not exist"'
            sh 'hostname'
            sh 'docker-compose -f docker-compose.yml up --build -d'
            /*something missing*/
            sh 'docker-compose run test'
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
	sh 'docker login -u the1andonlydavepublic -p the1andonlydavepublic'
	sh 'docker push the1andonlydavepublic/hellonode'
	/*" statt ' zur Variablensubstition*/
	sh "docker tag the1andonlydavepublic/hellonode:latest the1andonlydavepublic/hellonode:${env.BUILD_NUMBER}"
	sh "docker push the1andonlydavepublic/hellonode:${env.BUILD_NUMBER}"
    }
    
    post {
        always {
            sh 'docker stop myjob'
            sh "docker-compose -f docker-compose.yml down"
        }
    }

}