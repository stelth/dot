#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

WORK_DIR=$(mktemp -d)

pushd $WORK_DIR

mkdir jdtls
pushd jdtls

curl -L -o - http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz | tar xvz
curl -L -o lombok.jar https://projectlombok.org/downloads/lombok.jar

popd

cat <<EOF >jdtls.sh
#!/usr/bin/env bash
WORKSPACE="\$1"
die () {
  echo
  echo "$*"
  echo
  exit 1
}
case $(uname) in
  Linux)
    CONFIG="\$(pwd)/jdtls/config_linux"
    ;;
  Darwin)
    CONFIG="\$(pwd)/jdtls/config_mac"
    ;;
esac
JAR="\$(pwd)/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
# Determine the Java command to use to start the JVM.
if [ -n "\$JAVA_HOME" ] ; then
    if [ -x "\$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="\$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="\$JAVA_HOME/bin/java"
    fi
    if [ ! -x "\$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: \$JAVA_HOME
Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi
"\$JAVACMD" \\
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \\
  -Dosgi.bundles.defaultStartLevel=4 \\
  -Declipse.product=org.eclipse.jdt.ls.core.product \\
  -Dlog.protocol=true \\
  -Dlog.level=ALL \\
  -Xms1g \\
  -Xmx2G \\
  -javaagent:\$(pwd)/jdtls/lombok.jar \\
  -Xbootclasspath/a:\$(pwd)/jdtls/lombok.jar \\
  -jar \$(echo "\$JAR") \\
  -configuration "\$CONFIG" \\
  -data "\$WORKSPACE" \\
  --add-modules=ALL-SYSTEM \\
  --add-opens java.base/java.util=ALL-UNNAMED \\
  --add-opens java.base/java.lang=ALL-UNNAMED
EOF
chmod +x jdtls.sh

if [ -d ~/.local/bin/jdtls ]; then
	rm -rf ~/.local/bin/jdtls
fi

if [ -e ~/.local/bin/jdtls.sh ]; then
	rm -rf ~/.local/bin/jdtls.sh
fi

mv jdtls ~/.local/bin/jdtls
mv jdtls.sh ~/.local/bin/jdtls.sh

popd

rm -rf ${WORK_DIR}
