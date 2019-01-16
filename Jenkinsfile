node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        /*app = docker.build("the1andonlydave/hellonode")*/
	sh 'docker build -t the1andonlydavepublic/hellonode .'
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */
            sh 'docker stop myjob'
	    sh 'docker rm -f myjob && echo "container myjob removed" || echo "container myjob does not exist"'
            
            sh 'hostname'
            sh 'docker run -d -p 8000:8000 --name myjob the1andonlydavepublic/hellonode'
            sh 'sleep 5'
/* If we don't find "Hello" in the curl-result we break the pipeline here. */
            sh 'curl -s http://172.17.0.1:8000/ | grep "Hello"'
            
            sh 'docker stop myjob'

/*        app.inside {
            sh 'echo "Tests beginning"'
            sh 'hostname'
            sh 'curl -v http://127.0.0.1:8000/'

        }*/
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
/*        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        } */
	sh 'docker login -u the1andonlydavepublic -p the1andonlydavepublic https://registry.hub.docker.com'
	sh 'docker push the1andonlydavepublic/hellonode'
        }
    }
}
