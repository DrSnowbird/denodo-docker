# Denodo-Docker 
[![](https://images.microbadger.com/badges/image/openkbs/denodo-docker.svg)](https://microbadger.com/images/openkbs/denodo-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/denodo-docker.svg)](https://microbadger.com/images/openkbs/denodo-docker "Get your own version badge on microbadger.com")

* Denodo Docker + Java 8 JDK + Maven 3.5 + Python 3.5 + Gradle + X11 (display GUI)

# License Agreement
By using this image, you agree the [Oracle Java JDK License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).
This image contains [Oracle JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html). You must accept the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) to use this image.

# Components
* Denodo Docker
* java version "1.8.0_191"
  Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
  Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
* Apache Maven 3.5.3
* Python 3.5.2
* X11 display desktop
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

# Pre-requisites
You need two files to build and, after successful build, then you can launch Denodo Desktop.
* "Denodo Express Installer (generic) zip" file by downloading from https://community.denodo.com/express/download/
```
./denodo-express-install-7.0.zip
(be careful 7.0 not 7_0 for filename)
```
* "Denodo Express Free License" file from your free Denodo's account by [sign in onto you free Denodo account](https://community.denodo.com/login?destination=https%3A%2F%2Fcommunity.denodo.com%2Fdocs%2Fhtml%2Fbrowse%2F7.0%2Fplatform%2Finstallation%2Fpreinstallation_tasks%2Fdownload_an_installer%2Fdownload_an_installer) and save your license as the file name below:
```
./denodo-express-lic-7.0.lic
(be careful 7.0 not 7_0 for filename)
```

# Build
* (Note: this image will be 5.1 GB - huge!)
* Once you have the above two files, you can build the image. 
* During the build, it will install Denodo Express -- this might take about 15 ~ 20 minutes
```
./build.sh
```

# Run (recommended for easy-start)
* Once the above build is done, you can run Denodo now using the command below.
```
./run.sh
```

# Configurations (Optional)
If you run "./run.sh" instead of "docker-compose up", you don't have to do anything as below.

* The container uses a default "/workspace" folder. 
* The script "./run.sh" will re-use or create the local folder in your $HOME directory with the path below to map into the docker's internal "/workspace" folder.
```
$HOME/data_docker/denodo-docker/workspace
```
The above configuration will ensure all your projects created in the container's "/workspace" being "persistent" in your local folder, "$HOME/data_docker/denodo-docker/workspace", for your repetitive restart docker container.

# See Also - Other docker-based IDE
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/netbeans9-docker](https://hub.docker.com/r/openkbs/netbeans9-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)

# Resources - JBoss
* [JBoss Tools Integration Stacks 4.6.0.Final](https://tools.jboss.org/downloads/jbosstools_is/photon/4.6.0.Final.html#update_site)
* [Containerize Teiid linked with MariaDB](https://developer.jboss.org/wiki/QuickstartExampleWithDockerizedTeiid)
* [Teiid Downloads](http://teiid.jboss.org/downloads/)
* [Teiid Designer 11.1 with Eclipse Oxygen](http://teiiddesigner.jboss.org/designer_summary/downloads.html)
* [Teiid Cloud - Data Virtualization Services](http://teiid.io/teiid_cloud/)
* [Deploying Teiid VDB](http://teiid.github.io/teiid-documents/master/content/admin/Deploying_VDBs.html)
* [JBoss Tools Integration Stack 4.6.0.Final](https://tools.jboss.org/downloads/jbosstools_is/photon/4.6.0.Final.html)

# Display X11 Issue

More resource in X11 display of Eclipse on your host machine's OS, please see
* [X11 Display problem](https://askubuntu.com/questions/871092/failed-to-connect-to-mir-failed-to-connect-to-server-socket-no-such-file-or-di)
* [X11 Display with Xhost](http://www.ethicalhackx.com/fix-gtk-warning-cannot-open-display/)

# Other possible Issues
You might see the warning message or something similar in the launching xterm console like below, you can just ignore it. I googled around and some blogs just suggested to ignore since the IDE is still functional ok.
```
** (eclipse:1): WARNING **: Couldn't connect to accessibility bus: Failed to connect to socket /tmp/dbus-wrKH8o5rny: Connection refused

** (java:7): WARNING **: Couldn't connect to accessibility bus: Failed to connect to socket /tmp/dbus-wrKH8o5rny: Connection refused

```
