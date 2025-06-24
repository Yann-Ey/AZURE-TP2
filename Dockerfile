# Utilise l'image officielle WordPress
FROM wordpress:latest

# Installe WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Installe et active le thème Astra
RUN wp theme install astra --activate --allow-root
