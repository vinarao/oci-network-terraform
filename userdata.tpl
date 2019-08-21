# Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
#!/bin/bash -x
echo '################### webserver userdata begins #####################'
sudo touch ~opc/userdata.`date +%s`.start
# echo '########## yum update all ###############'
# yum update -y
echo '########## basic webserver ##############'
sudo yum install -y tomcat
sudo yum install -y tomcat-webapps tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc
echo "<br>Host:" >> /usr/share/tomcat/webapps/sample/hello.jsp
sudo sed -i -e "s/8080/${port}/g" /usr/share/tomcat/conf/server.xml
hostname >> /usr/share/tomcat/webapps/sample/hello.jsp
sudo firewall-offline-cmd --add-port=${port}/tcp
sudo systemctl enable  firewalld
sudo systemctl restart  firewalld
sudo systemctl start tomcat
sudo systemctl enable tomcat

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'

