# Use an official PHP image with Apache
FROM php:8.2-apache

# Install necessary PHP extensions including mysqli
RUN docker-php-ext-install mysqli

# Enable mod_rewrite
RUN a2enmod rewrite

# Copy all files into the container
COPY . /var/www/html/

# Set the correct working directory
WORKDIR /var/www/html/

# Open port 80
EXPOSE 80