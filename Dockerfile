FROM php:7.4-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql sockets
RUN curl -sS https://getcomposer.org/installer​ | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY .env.example .env
WORKDIR /app
COPY . /app
RUN composer install
CMD php artisan key:generate
CMD php artisan serve --host=0.0.0.0 --port=8000
EXPOSE 8000

