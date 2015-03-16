FROM ubuntu
MAINTAINER adrian_black@idg.co.uk
RUN sudo apt-get update
RUN sudo apt-get install -qy curl wget  default-jdk supervisor
RUN wget http://www.getrailo.org/railo/remote/download42/4.2.1.008/tomcat/linux/railo-4.2.1.008-pl0-linux-x64-installer.run
RUN chmod +x railo-4.2.1.008-pl0-linux-x64-installer.run
RUN sudo ./railo-4.2.1.008-pl0-linux-x64-installer.run --mode unattended --railopass "password" --installconn false --startatboot true
RUN rm -f railo-4.2.1.008-pl0-linux-x64-installer.run
RUN mv /opt/railo/tomcat/webapps/ROOT/WEB-INF /tmp/
RUN rm -r /opt/railo/tomcat/webapps/ROOT/*
RUN mv /tmp/WEB-INF /opt/railo/tomcat/webapps/ROOT/
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8888
CMD ["/usr/bin/supervisord"]
