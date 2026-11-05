FROM php:8.2-apache

RUN apt-get update && apt-get install -y libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite \
    && rm -rf /var/lib/apt/lists/*

# Copia os arquivos do site para a pasta principal do Apache
COPY ["loja da dani/loja da dani/", "/var/www/html/"]

# Define o arquivo inicial e protege a pasta do banco
RUN echo 'DirectoryIndex forninhodalili.html index.html' \
    > /etc/apache2/conf-available/forninho.conf \
    && echo '<Directory /var/www/html/banco>' \
    >> /etc/apache2/conf-available/forninho.conf \
    && echo 'Require all denied' \
    >> /etc/apache2/conf-available/forninho.conf \
    && echo '</Directory>' \
    >> /etc/apache2/conf-available/forninho.conf \
    && a2enconf forninho \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
