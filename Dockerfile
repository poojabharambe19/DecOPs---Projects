FROM centos
MAINTAINER poojabharambe2006@gmail.com

# Configure CentOS repository to avoid mirrorlist issues
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \ 
    && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install required packages
RUN yum -y install java httpd zip unzip

# Download the photogenic.zip template into /var/www/html/
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

# Set the working directory
WORKDIR /var/www/html/

# Unzip the downloaded zip file and clean up
RUN unzip -q photogenic.zip \ 
    && cp -rvf photogenic/* . \ 
    && rm -rf photogenic photogenic.zip

# Set the default command to run Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose necessary ports
EXPOSE 80 22 81
