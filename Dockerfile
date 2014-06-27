FROM x110dc/dev-base
#FROM phusion/baseimage
MAINTAINER tech@texastribune.org

RUN apt-get update
ENV HOME /root
RUN apt-get install -y postfix supervisor libsasl2-modules syslog-ng-core

# http://help.mandrill.com/entries/23060367-Can-I-configure-Postfix-to-send-through-Mandrill-

ENV MANDRILL_USERNAME MANDRILL_USERNAME
ENV MANDRILL_API_KEY MANDRILL_KEY

#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

ADD sasl_passwd /etc/postfix/
ADD main.cf /etc/postfix/
ADD run.sh /
ADD postfix-supervisord.conf /etc/supervisor/conf.d/postfix.conf
# I don't know enough about postfix. The config doesn't do a chroot, so I
# don't know why this is necessary but I had to do it to get it to work:
RUN cp /etc/resolv.conf /var/spool/postfix/etc/
RUN cp /etc/services /var/spool/postfix/etc/

ADD syslog-ng-supervisor.conf /etc/supervisor/conf.d/syslog-ng.conf
#RUN sed '/system()/ s/^/#/' -i /etc/syslog-ng/syslog-ng.conf
#RUN sed '/^#.*d_mail/ s/^# *//g' -i /etc/syslog-ng/syslog-ng.conf
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
#ADD syslog-ng /etc/default/
RUN touch /var/log/mail.log
RUN touch /var/log/mail.info

ADD supervisord.conf /etc/supervisor/
#ADD runit-thing.sh /etc/my_init.d/thing.sh

VOLUME /var/log

CMD /run.sh
#RUN /usr/sbin/enable_insecure_key

#CMD /usr/bin/supervisord
#CMD /sbin/my_init

EXPOSE 25
