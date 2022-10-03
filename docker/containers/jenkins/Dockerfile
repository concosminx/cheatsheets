FROM jenkins/jenkins:lts

LABEL maintainer="concosminx@something.com"

ENV JENKINS_USER admin
ENV JENKINS_PASS admin1

# Skip initial setup
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

COPY --chown=jenkins:jenkins executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
