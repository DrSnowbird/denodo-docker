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
ENV WORK_DIR=${HOME}

## -- 1.) Product version, etc.: -- ##
ARG PRODUCT_NAME=${PRODUCT_NAME:-denodo-express}
ARG PRODUCT_VERSION=${PRODUCT_VERSION:-7.0}
ARG PRODUCT_LICENSE=${PRODUCT_LICENSE:-denodo-express-lic-${PRODUCT_VERSION}.lic}
ARG PRODUCT_INSTALLER_DIR=${PRODUCT_INSTALLER_DIR:-"${WORK_DIR}/denodo-install-${PRODUCT_VERSION}"}
ARG PRODUCT_INSTALLER_RESPONSE_FILE=${PRODUCT_INSTALLER_RESPONSE_FILE:-response-file-${PRODUCT_VERSION}.xml}
ARG PRODUCT_INSTALLER_ZIP=${PRODUCT_INSTALLER_ZIP:-denodo-express-install-${PRODUCT_VERSION}.zip}
ARG PRODUCT_HOME=${PRODUCT_HOME:-"${HOME}/denodo-platform-${PRODUCT_VERSION}"}
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
# Generic with no JVM file: denodo-express-install-7.0.zip
ARG PRODUCT_TAR=${PRODUCT_TAR:-${PRODUCT_NAME}-${PRODUCT_TYPE}-${PRODUCT_VERSION}.zip}

## -- Product Download full URL: -- ##
ARG PRODUCT_DOWNLOAD_URL=${PRODUCT_DOWNLOAD_URL:-https://community.denodo.com/express/download-installer-7.0/generic}

WORKDIR ${WORK_DIR}

#### ---- Installer Zip file ---- ####
RUN mkdir -p ${PRODUCT_HOME}

#### ---- Use local copy since Denodo requiring login to download ---- ####
COPY ./${PRODUCT_INSTALLER_ZIP} ./
RUN unzip ./${PRODUCT_INSTALLER_ZIP} && \
    sudo chmod +x ${PRODUCT_INSTALLER_DIR}/*.sh

#### ---- Installer Config file ---- ####
COPY ./${PRODUCT_INSTALLER_RESPONSE_FILE} ${PRODUCT_INSTALLER_DIR}/

#### ---- License file ---- ####
COPY ./${PRODUCT_LICENSE} ${PRODUCT_INSTALLER_DIR}/

## -- Use the following command to generate response_file_7.0.xml first --
## ${HOME}/denodo-install-7.0/installer_cli.sh generate ${HOME}/denodo-install-7.0/response-file-7.0.xml
## -- Then, use autoinstaller option with the above reponse file to install Denodo Platfrom silently --
## ~/denodo-install-7.0/installer_cli.sh install --autoinstaller ~/denodo-install-7.0/response-file-7.0.xml
RUN ls -al ${PRODUCT_INSTALLER_DIR} && \
    cp ${PRODUCT_INSTALLER_DIR}/${PRODUCT_LICENSE} ${PRODUCT_HOME}/
RUN ${PRODUCT_INSTALLER_DIR}/installer_cli.sh install --autoinstaller ${PRODUCT_INSTALLER_DIR}/${PRODUCT_INSTALLER_RESPONSE_FILE}

RUN \
    sudo chown ${USER_NAME}:${USER_NAME} ${PRODUCT_HOME}/${PRODUCT_LICENSE} && \
    sudo rm -rf ${PRODUCT_INSTALLER_ZIP}  

## -- Need denodo-install-7.0 to run correctly (don't delete it!) -- ##
## sudo rm -rf denodo-express-install-7.0.zip denodo-install-7.0  

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
