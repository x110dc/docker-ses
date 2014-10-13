FROM x110dc/base
MAINTAINER tech@texastribune.org

RUN apt-get update
RUN apt-get install -y postfix supervisor libsasl2-modules syslog-ng-core

ENV SES_USERNAME SES_USERNAME
ENV SES_API_KEY SES_API_KEY

# postfix
ADD sasl_passwd /etc/postfix/
ADD main.cf /etc/postfix/
ADD postfix-supervisord.conf /etc/supervisor/conf.d/postfix.conf

# syslog-ng
ADD syslog-ng-supervisor.conf /etc/supervisor/conf.d/syslog-ng.conf
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
#RUN touch /var/log/mail.log

ADD supervisord.conf /etc/supervisor/

ADD run.sh /
CMD /run.sh

VOLUME /var/log

EXPOSE 25
