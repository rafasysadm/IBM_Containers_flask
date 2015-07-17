# First Dockerfile to build Flask web app container
#

# Set the base image to Ubuntu
FROM ubuntu:15.04

#File Author / Maintainer
MAINTAINER Rafael

# Update the sources list
RUN apt-get update

# Install basic Apps
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils net-tools; DEBIAN_FRONTEND=noninteractive apt-get install -y  -o APT::Install-Suggests="false" \
                                                                  python2.7-Dev tar vim git wget python-setuptools iputils-ping

#Install pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

# Updates pip
RUN pip install -U pip

# Install Virtualenv
RUN pip install virtualenv

# Create a new directory where the virtual environment will be created and add the requirements file.
RUN mkdir virtualenv
ADD requirements.txt /virtualenv/requirements.txt

#Finally we will create our isolated environment. Here we are running virtualenv and the -p python2.7 says we want the environment created with Python2.7. 
# Create virtualenv and install requirements
RUN cd virtualenv ; virtualenv -p python2.7 flask-dev
RUN . /virtualenv/flask-dev/bin/activate; pip install -r /virtualenv/requirements.txt
ADD appdir/ /virtualenv/flask-dev/appdir

EXPOSE 9080

ENTRYPOINT  . /virtualenv/flask-dev/bin/activate; \
             python /virtualenv/flask-dev/appdir/app.py
