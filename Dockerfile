FROM amazonlinux:latest

ARG VERSION
ENV DOWNLOAD_DIR "/tmp"
ENV INSTALL_DIR "/usr/local/lib/${VERSION}"

RUN yum update -y
RUN yum install -y \
  wget \
  tar.x86_64 \
  zlib-devel \
  openssl-devel \
  make \
  xz \
  xz-devel \
  gcc*

RUN echo $DOWNLOAD_DIR
WORKDIR $DOWNLOAD_DIR
RUN curl -O https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz
RUN tar -Jxf Python-$VERSION.tar.xz
WORKDIR $DOWNLOAD_DIR/Python-$VERSION
RUN ./configure --prefix=$INSTALL_DIR --with-ensurepip
RUN make
RUN make install
ENV PATH $INSTALL_DIR/bin:$PATH
RUN pip3 install --upgrade pip
