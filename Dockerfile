FROM httpd:2.4

# Copy all web-content into container
COPY web-content/ /usr/local/apache2/htdocs/
