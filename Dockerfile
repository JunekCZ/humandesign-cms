# Base image with PHP 8.2 and Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install necessary PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy application files to the container
COPY . /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Set the entrypoint for the container
CMD ["apache2-foreground"]
