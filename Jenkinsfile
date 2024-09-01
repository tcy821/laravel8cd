pipeline {
    agent any
    stages {
        stage("Build") {
            environment {
                DB_HOST = "mysql"
                DB_DATABASE = "laravel"
                DB_USERNAME = "root"
                DB_PASSWORD = ""
            }
            steps {
                sh 'php --version'
                sh 'composer install'
                sh 'composer --version'
                sh 'cp .env.example .env'
                sh 'echo DB_HOST=${DB_HOST} >> .env'
                sh 'echo DB_USERNAME=${DB_USERNAME} >> .env'
                sh 'echo DB_DATABASE=${DB_DATABASE} >> .env'
                sh 'echo DB_PASSWORD=${DB_PASSWORD} >> .env'
                sh 'php artisan key:generate'
                sh 'cp .env .env.example'
                sh 'php artisan migrate'
            }
        }
        stage("Unit test") {
            steps {
                sh 'php artisan test --log-junit tests/report.xml'
                sh 'xsltproc phpunit-to-html.xsl tests/report.xml > tests/report.html'
            }
        }
        stage("Code coverage") {
            steps {
                sh "vendor/bin/phpunit --coverage-html 'reports/coverage'"
            }
        }
        stage("Static code analysis larastan") {
            steps {
                sh "vendor/bin/phpstan analyse --memory-limit=2G"
            }
        }
        stage("Static code analysis phpcs") {
            steps {
                sh "vendor/bin/phpcs"
            }
        }
        stage("Docker build") {
            steps {
                sh "docker build -t scc11/laravel8cd ."
            }
        }
        stage("Docker push") {
            environment {
                DOCKER_USERNAME = "scc11"
                DOCKER_PASSWORD = "@SCCassign2"
            }
            steps {
                sh "docker login --username ${DOCKER_USERNAME} --password ${DOCKER_PASSWORD}"
                sh "docker push scc11/laravel8cd"
            }
        }
        stage("Deploy to staging") {
            steps {
                sh "docker run -d --rm -p 9000:80 --name laravel8cd scc11/laravel8cd"
            }
            post {
                always {
                    sh "docker stop laravel8cd"
                }
            }
        }
    }
}
