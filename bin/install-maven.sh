#/usr/bin/env bash

# Controls what version is installed and where
# Usage:
# ./install-maven.sh <version> <install-folder> <link-target>
# Where <version> is the desired Maven version
# <install-folder> is a directory under which the Maven version will be installed
# as a version specific folder
# <link-target> is the path for a symbolic link that will be linked to the installed
# version, if this <link-target> is in your PATH then running this script will cause
# the requested version to become the default version of Maven
MAVEN_VERSION=${1:-3.8.3}
INSTALL_TARGET=${2:-/Users/${USER}/Documents/Apps}
LINK_TARGET=${3:-/Users/${USER}/Documents/Apps/apache-maven}
echo "INFO: Attempting to install Maven ${MAVEN_VERSION}"

function download() {
  set -e
  TAR_FILE=apache-maven-${MAVEN_VERSION}.tar.gz
  curl https://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz > ${TAR_FILE}
  tar -xvf ${TAR_FILE} --directory ${INSTALL_TARGET}/
  rm ${TAR_FILE}
  set +e
}

function link() {
  rm -f ${LINK_TARGET}
  ln -s ${INSTALL_TARGET}/apache-maven-${MAVEN_VERSION} ${LINK_TARGET}
}

if [ -d "${INSTALL_TARGET}/apache-maven-${MAVEN_VERSION}" ]; then
  echo "INFO: Maven ${MAVEN_VERSION} already appears to be installed"
else
  download
fi

LINK_STATUS=$(ls -l ${LINK_TARGET})
LINK_STATUS=$(echo ${LINK_STATUS} | grep "${MAVEN_VERSION}")
if [ $? -ne 0 ]; then
  echo "INFO: Apache Maven currently linked to a different version, relinking..."
  link
else
  echo "INFO: Maven ${MAVEN_VERSION} already linked correctly"
fi

# Show configuration
echo ""
ls -l ${LINK_TARGET}
which mvn
mvn --version
