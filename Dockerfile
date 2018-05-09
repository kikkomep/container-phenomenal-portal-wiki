FROM nimmis/apache-php5:latest
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>

LABEL Description="Wiki for the PhenoMeNal Portal"
LABEL software="PhenoMeNal Portal"
LABEL software.version="0.4.1"
LABEL version="1.2"

# Web server root path
ENV WWW_ROOT "/var/www/html/"

# App name as ENV variable
ENV APP_NAME "php-phenomenal-portal-wiki"

# Software revision
ENV REVISION="96ab599c2793f0a61831142f5aa0b880314048b4"

# Install required software
WORKDIR ${WWW_ROOT}
RUN apt-get update && apt-get install -y --no-install-recommends git python python-dev build-essential python-pip && \
    git clone https://github.com/phnmnl/${APP_NAME}.git && \
    git -C ${APP_NAME} checkout $REVISION && \
    cd ${APP_NAME}/bin/markdown2html && git submodule init && git submodule update && \
    pip install markdown2 && \
    apt-get purge -y python-dev build-essential python-pip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update working dir and CRON configuration
WORKDIR ${WWW_ROOT}/${APP_NAME}
RUN chmod 755 * && chmod 644 bin && chmod 644 conf && chmod +x ./bin/run.sh \
    && echo "export BRANCH=master" > conf/branch.config \
    && (crontab -l 2>/dev/null; \
    { echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"; \
      echo "*/60 * * * * /var/www/html/${APP_NAME}/bin/run.sh > /var/log/refresh.log 2> /var/log/refresh.error"; }) | crontab -

# web server port
EXPOSE 80