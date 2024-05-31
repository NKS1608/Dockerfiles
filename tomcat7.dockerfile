FROM adoptopenjdk/openjdk8:ubi

LABEL name=Tomcat 7 \
      authors=nks1608 \
      version=v0.02

ENV TOMCAT_MAJOR=7
ENV TOMCAT_VERSION=7.0.109

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

RUN mkdir -p "$CATALINA_HOME"

RUN curl -LfsSo /tmp/tomcat.tgz https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz; \
    mkdir -p "$CATALINA_HOME"; \
    cd $CATALINA_HOME; \
    tar -xzvf /tmp/tomcat.tgz --strip-components=1; \
    rm -rf /tmp/tomcat.tgz

WORKDIR $CATALINA_HOME
EXPOSE 8080
CMD ["catalina.sh", "run"]