FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

#### ---- Build Specification ----
# Metadata params
ARG BUILD_DATE=${BUILD_DATE:-}
ARG VERSION=${BUILD_DATE:-}
ARG VCS_REF=${BUILD_DATE:-}

# Metadata
LABEL org.label-schema.url="https://imagelayers.io" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url="https://github.com/microscaling/imagelayers-graph.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="This utility provides Denodo Docker." \
      org.label-schema.schema-version="1.0"
      
## -------------------------------------------------------------------------------
## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
## -------------------------------------------------------------------------------
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
ENV WORKSPACE=${HOME}/workspace

## -- 1.) Product version, etc.: -- ##
ARG PRODUCT_NAME=${PRODUCT_NAME:-denodo-express}
ARG PRODUCT_VERSION=${PRODUCT_VERSION:-7_0}
ARG PRODUCT_INSTALLER_DIR=${PRODUCT_INSTALLER_DIR:-${HOME}/denodo-install-7.0}
ARG PRODUCT_HOME=${PRODUCT_HOME:-${HOME}/denodo-platform-7.0}
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
# Login and download from: https://community.denodo.com/express/download-installer-7.0/generic
# Generic with no JVM file: denodo-express-install-7_0.zip
ARG PRODUCT_TAR=${PRODUCT_TAR:-${PRODUCT_NAME}-${PRODUCT_TYPE}-${PRODUCT_VERSION}.zip}

## -- Product Download full URL: -- ##
ARG PRODUCT_DOWNLOAD_URL=${PRODUCT_DOWNLOAD_URL:-https://community.denodo.com/express/download-installer-7.0/generic}

WORKDIR ${HOME}

#### -- installation --- ####
#### ---- Use local copy since Denodo requiring login to download ---- ####
COPY ./denodo-express-install-7_0.zip ./

RUN unzip ./denodo-express-install-7_0.zip && \
    sudo chmod +x ./denodo-install-7.0/*.sh

COPY ./response_file_7_0.xml ./denodo-install-7.0/

RUN mkdir -p ${PRODUCT_HOME}
COPY ./denodo-express-lic-7_0.lic ${PRODUCT_HOME}/

## -- Use the following command to generate response_file_7_0.xml first --
## ${HOME}/denodo-install-7.0/installer_cli.sh generate ${HOME}/denodo-install-7.0/response_file_7_0.xml
## -- Then, use autoinstaller option with the above reponse file to install Denodo Platfrom silently --
## ~/denodo-install-7.0/installer_cli.sh install --autoinstaller ~/denodo-install-7.0/response_file_7_0.xml
RUN ${HOME}/denodo-install-7.0/installer_cli.sh install --autoinstaller ${HOME}/denodo-install-7.0/response_file_7_0.xml

RUN sudo chown ${USER_NAME}:${USER_NAME} ${PRODUCT_HOME}/denodo-express-lic-7_0.lic && \
    sudo rm -rf denodo-express-install-7_0.zip  
## -- Need denodo-install-7.0 to run correctly (can't delete it!) -- ##
## sudo rm -rf denodo-express-install-7_0.zip denodo-install-7.0  

RUN \
    echo "PRODUCT_TAR=${PRODUCT_TAR}" && \
    echo "PRODUCT_HOME=${PRODUCT_HOME}" && \
    echo "PRODUCT_VERSION=${PRODUCT_VERSION}" 
    
#### --- Working Directory ---- ####
WORKDIR ${HOME}
USER ${USER_NAME}

#### --- Copy Entrypoint script in the container ---- ####
COPY ./docker-entrypoint.sh /

#### --- Enterpoint for container ---- ####
ENTRYPOINT ["/docker-entrypoint.sh"]

#### --- For debug only ---- ####
#CMD ["/usr/bin/firefox"]
