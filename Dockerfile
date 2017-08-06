FROM resin/rpi-raspbian:jessie-20160831

RUN apt-get update;

#Install wget (useful for debugging)
RUN apt-get install -y wget

#Install Mp3 Player (useful for audio testing)
RUN apt-get install -y mpg321

#Install python stuff
RUN apt-get install -y python python-pip python-dev python-virtualenv --no-install-recommends

#install python gpio
RUN apt-get install python-rpi.gpio

#Install apache
RUN apt-get install -y apache2
RUN a2dismod status
RUN service apache2 restart

#Install PHP for apache
RUN apt-get install -y php5
RUN apt-get install -y libapache2-mod-php5

#Install espeak
RUN apt-get install -y espeak

#Enable the spi for gpio
#RUN echo dtparam=spi=on > /boot/config.txt

#Install Alsa audio utilitys (needed for amixer command)
#RUN apt-get install -y alsa-utils

#Enable Audio jack (Audio jack seems to be enabled by default)
#RUN echo amixer cset numid=3 1 > /etc/rc.local

#copy files to image
COPY src/ var/www/html/

#Set Apache Env
#VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

#Add wwwdata to sudoers and allow scripts
RUN echo "www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
