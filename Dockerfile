FROM centos
MAINTAINER poojabharambe2006@gmail.com

# Configure CentOS repository to avoid mirrorlist issues
RUN cd /etc/yum.repos.d/ \
    && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
    && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install Java, httpd (Apache), zip, and unzip packages
RUN yum -y install java \
    && yum install -y httpd \
    && yum install -y zip \
    && yum install -y unzip

# Download the photogenic.zip template into /var/www/html/
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

# Set the working directory to /var/www/html
WORKDIR /var/www/html/

# Unzip the downloaded zip file
RUN unzip -q photogenic.zip

# Copy the extracted files to the current directory and clean up
RUN cp -rvf photogenic/* . \
    && rm -rf photogenic photogenic.zip

# Set the default command to run Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose ports 80, 22, and 81
EXPOSE 80 22 81
