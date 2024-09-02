#!/bin/bash

# Generate application key
php artisan key:generate --no-interaction

# Run PHPUnit and generate HTML code coverage report
vendor/bin/phpunit --coverage-html /var/www/html/reports/coverage

# Run Laravel tests and generate test report in JUnit XML format
php artisan test --log-junit /var/www/html/tests/report.xml

# Convert PHPUnit XML report to HTML using XSLT
xsltproc /var/www/html/phpunit-to-html.xsl /var/www/html/tests/report.xml > /var/www/html/tests/report.html

# Start PHP-FPM
php-fpm
