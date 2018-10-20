FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

#### ---- Build Specification ----
# Metadata params
ARG BUILD_DATE=${BUILD_DATE:-}
ARG VERSION=${BUILD_DATE:-}
ARG VCS_REF=${BUILD_DATE:-}

#### ---- Product Specifications ----
ARG PRODUCT=${PRODUCT:-denodo-express}
ARG PRODUCT_VERSION=${PRODUCT_VERSION:-7_0}
ARG PRODUCT_DIR=${PRODUCT_DIR:-}
ARG PRODUCT_EXE=${PRODUCT_EXE:-}
ENV PRODUCT=${PRODUCT}
ENV PRODUCT_VERSION=${PRODUCT_VERSION}
ENV PRODUCT_DIR=${PRODUCT_DIR}
ENV PRODUCT_EXE=${PRODUCT_EXE}
ENV PRODUCT_LICENSE=${PRODUCT_LICENSE:-denodo-express-lic-7_0-201808.lic}

# Metadata
LABEL org.label-schema.url="https://imagelayers.io" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url="https://github.com/microscaling/imagelayers-graph.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="This utility provides Denodo Docker." \
      org.label-schema.schema-version="1.0"
      
RUN echo PRODUCT=${PRODUCT} && echo HOME=$HOME

## -------------------------------------------------------------------------------
## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
## -------------------------------------------------------------------------------
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
ENV WORKSPACE=${HOME}/workspace

## -- 1.) Product version: oxygen, photon, etc.: -- ##
ARG PRODUCT_VERSION=${PRODUCT_VERSION:-7_0}
ENV PRODUCT_VERSION=${PRODUCT_VERSION}

ARG PRODUCT_HOME=${PRODUCT_HOME:-${HOME}/denodo-platform-7.0}
ENV PRODUCT_HOME=${PRODUCT_HOME}

ARG PRODUCT_EXE=${PRODUCT_EXE:-${PRODUCT_HOME}/bin/denodo_platform.sh}
ENV PRODUCT_EXE=${PRODUCT_EXE}

## -- 2.) Product Type: -- ##
ARG PRODUCT_TYPE=${PRODUCT_TYPE:-install}

## -- 3.) Product Release: -- ##
ARG PRODUCT_RELEASE=${PRODUCT_RELEASE:-}

## -- 4.) Product Build: -- ##
ARG PRODUCT_OS_BUILD=${PRODUCT_OS_BUILD:-linux64}

## ----------------------------------------------------------------------------------- ##
## ----------------------------------------------------------------------------------- ##
## ----------- Don't change below unless Product download system change -------------- ##
## ----------------------------------------------------------------------------------- ##
## ----------------------------------------------------------------------------------- ##
## -- Product TAR/GZ filename: -- ##
# denodo-express-install-7_0-linux64.zip
ARG PRODUCT_TAR=${PRODUCT_TAR:-${PRODUCT}-${PRODUCT_TYPE}-${PRODUCT_VERSION}.zip}

ARG PRODUCT_TGZ=${PRODUCT_TGZ:-denodo-platform-7.0.tgz}

## -- Product Download route: -- ##
# https://community.denodo.com/express/download-installer-7.0/generic
ARG PRODUCT_DOWNLOAD_ROUTE=${PRODUCT_DOWNLOAD_ROUTE:-https://community.denodo.com/express/download-installer-7.0/generic}

## -- Product Download full URL: -- ##
ARG PRODUCT_DOWNLOAD_URL=${PRODUCT_DOWNLOAD_URL:-https://community.denodo.com/express/download-installer-7.0/generic}

WORKDIR ${HOME}

#### ---- Use local copy since Denodo requiring login to download ---- ####
COPY ./${PRODUCT_TGZ} ./

RUN sudo chown $USER:$USER ./${PRODUCT_TGZ} && \
    tar xvf ./${PRODUCT_TGZ}

## -- installation ---
#COPY ./denodo-express-install-7_0.zip ./
#COPY ./denodo-express-lic-7_0-201808.lic ./
#RUN unzip ./denodo-express-install-7_0.zip && \
#    sudo chmod +x /opt/denodo-install-7.0/*.sh && \
#     sudo -Eu developer bash -c '/opt/denodo-install-7.0/install.sh'

#CMD "/bin/bash", "-c", "${PRODUCT_EXE}"
CMD ["/bin/bash", "-c", "${PRODUCT_EXE}"]

#CMD ["/usr/bin/firefox"]
