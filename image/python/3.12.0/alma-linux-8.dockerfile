# Docker image to use.
FROM sloopstash/base-alma-linux-8:v1.1.1

#Install dependencies packages of Python
RUN set -x \
  && dnf -y install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel

# Download source code of Python 3.12.0 and extract
WORKDIR /tmp
RUN set -x \
  && wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tar.xz \
  && tar xvf Python-3.12.0.tar.xz

# Build and Install Python packages.
WORKDIR Python-3.12.0
RUN set -x \
  && ./configure --enable-optimizations \
  && make altinstall \
  && rm -rf /tmp/Python-3.12.0*

# Install Python dependent packages to start app.
RUN set -x \
  && pip3 install flask==0.12.4 \
  && pip3 install redis==2.10.6 \
  && pip3 install elastic-apm[flask]==3.0.5

# Create App directories.
RUN set -x \
  && mkdir /opt/app \
  && mkdir /opt/app/source \
  && mkdir /opt/app/log \
  && history -c

# Set default work directory.
WORKDIR /opt/app
