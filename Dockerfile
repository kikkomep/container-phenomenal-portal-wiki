FROM nimmis/apache-php5:latest
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>

LABEL Description="Wiki for the PhenoMeNal Portal"
LABEL software="PhenoMeNal Portal"
LABEL software.version="0.3.1"
LABEL version="1.1.0"

WORKDIR /var/www/html
# Web server root path
ENV WWW_ROOT "/var/www/html/"

# App name as ENV variable
ENV APP_NAME "php-phenomenal-portal-wiki"
# Install required software
WORKDIR ${WWW_ROOT}
RUN apt-get update && apt-get install -y --no-install-recommends git python python-dev build-essential python-pip && \
    git clone https://github.com/phnmnl/${APP_NAME}.git && \
    git -C ${APP_NAME} checkout $REVISION && \
    cd ${APP_NAME}/bin/markdown2html && git submodule init && git submodule update && \
    pip install markdown2 && \
    apt-get purge -y python-dev build-essential python-pip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV REVISION="257855833a12fdaf68db90b904244744d5f25d4b"

WORKDIR /var/www/html/php-phenomenal-portal-wiki
RUN chmod 755 *
RUN chmod 644 bin
RUN chmod 644 conf
RUN chmod +x ./bin/run.sh
RUN (crontab -l 2>/dev/null; echo "* */1 * * * /var/www/html/php-phenomenal-portal-wiki/bin/run.sh > /var/log/refresh.log 2> /var/log/refresh.error") | crontab -

EXPOSE 80
