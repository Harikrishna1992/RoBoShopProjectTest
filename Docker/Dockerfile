FROM    centos:7
RUN     yum epel-release  -y
RUN     yum install nginx -y
EXPOSE  80
CMD     ["nginx", "-g", "daemon off;"]