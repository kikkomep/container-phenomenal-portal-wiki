FROM nimmis/apache-php5:latest
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>

# container version
ENV version="1.3"

# software version
ENV software_version="1.1.0"

# App name as ENV variable
ENV APP_NAME "php-phenomenal-portal-wiki"

# Metadata
LABEL Description="Wiki for the PhenoMeNal Portal"
LABEL software="PhenoMeNal Portal"
LABEL version="${version}"
LABEL software.version="${software_version}"

# Optional arguments to choose the Git repo & branch to use at build time
ARG git_repo="phnmnl/${APP_NAME}"
ARG git_branch="v${software_version}"

# Web server root path
ENV WWW_ROOT "/var/www/html/"

# Install required software
WORKDIR ${WWW_ROOT}
RUN apt-get update && apt-get install -y --no-install-recommends git python python-dev build-essential python-pip && \
		echo "Cloning branch '${git_branch}' of the Git repository '${git_repo}'" >&2 && \
    git clone --depth 1 --single-branch -b ${git_branch} https://github.com/${git_repo}.git && \
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