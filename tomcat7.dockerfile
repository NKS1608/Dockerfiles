FROM adoptopenjdk/openjdk8:ubi

# Update
RUN dnf upgrade -y

# Install utils 
RUN dnf install -y wget tar

ENV TOMCAT_MAJOR=7
ENV TOMCAT_VERSION=7.0.109

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=/usr/local/tomcat/bin:/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

#Download tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -O /tmp/tomcat.tgz
RUN tar -xzvf /tmp/tomcat.tgz -C /tmp
RUN mv /tmp/apache-tomcat-$TOMCAT_VERSION/* $CATALINA_HOME

# Cleanup
RUN dnf remove -y wget tar
RUN rm -rf /tmp/*

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]