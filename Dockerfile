FROM tomcat:10.1-jdk17-temurin 
RUN rm -rf /usr/local/tomcat/webapps/ROOT/* 
COPY webapp/ /usr/local/tomcat/webapps/ROOT/ 
EXPOSE 8080 
CMD ["catalina.sh", "run"] 