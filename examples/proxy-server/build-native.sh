#!/bin/bash
# Requires installed graalvm and gradle

cd ../..
gradle clean build test installDist distZip

cd examples/proxy-server
JARS_DIR=build/install/proxy-server/lib/
CLASS_PATH=""

for JAR in $(ls -1 $JARS_DIR); do
  CLASS_PATH=${JARS_DIR}${JAR}:${CLASS_PATH}
done

echo "CLASS PATH: ${CLASS_PATH}"

native-image --no-fallback -cp ${CLASS_PATH} one.microproject.proxyserver.Main

rm one.microproject.proxyserver.main.build_artifacts.txt
mv one.microproject.proxyserver.main build/distributions/

# run binary proxy-server
# build/distributions/one.microproject.proxyserver.main src/main/resources/proxy-server-config.json