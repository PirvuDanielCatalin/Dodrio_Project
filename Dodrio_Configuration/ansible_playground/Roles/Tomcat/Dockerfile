FROM tomcat:latest

MAINTAINER Pirvu Daniel Catalin

RUN sed -i -e "s/.*Valve.*//" -e "s/.*allow.*//" webapps/host-manager/META-INF/context.xml

RUN echo "<?xml version='1.0' encoding='cp1252'?>" > conf/tomcat-users.xml
RUN echo "<tomcat-users xmlns='http://tomcat.apache.org/xml'" >> conf/tomcat-users.xml
RUN echo "              xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'" >> conf/tomcat-users.xml
RUN echo "              xsi:schemaLocation='http://tomcat.apache.org/xml tomcat-users.xsd'" >> conf/tomcat-users.xml
RUN echo "              version='1.0'>" >> conf/tomcat-users.xml
RUN echo " <role rolename='admin-gui'/>" >> conf/tomcat-users.xml
RUN echo " <role rolename='admin-script'/>" >> conf/tomcat-users.xml
RUN echo " <role rolename='manager-gui'/>" >> conf/tomcat-users.xml
RUN echo " <role rolename='manager-status'/>" >> conf/tomcat-users.xml
RUN echo " <role rolename='manager-script'/>" >> conf/tomcat-users.xml
RUN echo " <role rolename='manager-jmx'/>" >> conf/tomcat-users.xml
RUN echo " <user name='admin' password='admin123' roles='admin-gui,admin-script,manager-gui,manager-status,manager-script,manager-jmx'/>" >> conf/tomcat-users.xml
RUN echo "</tomcat-users>" >> conf/tomcat-users.xml

RUN mkdir conf/Catalina
RUN mkdir conf/Catalina/localhost
RUN touch conf/Catalina/localhost/manager.xml

RUN echo "<Context privileged='true' antiResourceLocking='false' docBase='/opt/tomcat/webapps/manager'>" > conf/Catalina/localhost/manager.xml
RUN echo "  <Valve className='org.apache.catalina.valves.RemoteAddrValve' allow='^.*$' />" >> conf/Catalina/localhost/manager.xml
RUN echo "</Context>" >> conf/Catalina/localhost/manager.xml

RUN cat webapps/host-manager/META-INF/context.xml
RUN cat conf/tomcat-users.xml
RUN cat conf/Catalina/localhost/manager.xml

COPY Java-Simple-Web-Page-Particles-Latest.war /usr/local/tomcat/webapps/
