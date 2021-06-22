# AWS
alias tf='terraform'
alias tfsandpit='export TARGET_ACCOUNT=009938142092 && export TARGET_ACCOUNT_NAME=sandpit'
alias cca='corectl centrify aws'
alias ccapit='corectl centrify aws --app Sandpit'
alias ccad='corectl centrify aws --app Identity --account dev --role ReadOnly'
alias ccada='corectl centrify aws --app Identity --account dev --role DevAdmin'
alias ccas='corectl centrify aws --app Identity --account stg --role ReadOnly'
alias ccap='corectl centrify aws --app Identity --account prd --role ReadOnly'

# Making common commands for humans to use
alias ackg='ack --no-group'
alias grep='grep --color=auto'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -1'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias vi='vim'

# Ansible
alias ap='ansible-playbook'
alias aps='ansible-playbook --ask-become-pass'
alias chaos-soe='/bin/bash -c "$(curl -fsSL https://stash.oz.moneyswitch.net/users/jleskovar/repos/chaos-soe/browse/setup.sh?raw)"'

# Mac
alias syspref='sudo /Applications/System\ Preferences.app/Contents/MacOS/System\ Preferences'
# Directory navigation
alias cc='cd ~/code/codecommit'
alias soe='cd ~/code/soe'
alias tl='cd ~/code/tools'

# Builder: Maven
alias mjr='mvn jetty:run'
alias mjrr='register_cwd_artefact && mjr'

alias mbr='mvn spring-boot:run'
alias mbrr='register_cwd_artefact && mbr'

alias mbrd='mvn spring-boot:run -Drun.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8787 -Dserver.port=9090 -Dpath.to.config.dir=/var/data/my/config/dir"'
#mvn spring-boot:run -Drun.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8787 -Dserver.port=9090 -Dpath.to.config.dir=/var/data/my/config/dir
#mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"
#mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
#mvn spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
#mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xnoagent -Djava.compiler=NONE -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
#mvn spring-boot:run -Drun.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
#mvn spring-boot:run -Drun.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"

alias mci='mvn clean install'
alias mcis='mvn clean install -DskipTests -Djetty.skip=true -Dclm.skip=true'

alias mcisq='mvn clean install -T7 -Dmaven.test.skip.exec=true -Djetty.skip=true -Dmaven.javadoc.skip=true -Dfindbugs.skip=true -Dfindbugs.skipEmptyReport=true -Dmdep.analyze.skip=true -Djar.skipIfEmpty=true -Dsource.skip=true -Denforcer.skip=true -Dcheckstyle.skip=true -Dclm.skip=true -DskipTests=true'

# Builder: Gradle
alias gb='gradle build'
alias gci='gradle preCommitBuild'
alias gr='gradle run'
alias gsc='gradle stop clean'

# Rabbit
alias drmqr='register_cwd_artefact && drmq'
alias drpact='docker rm -f tyro-pact-broker-sqlite; docker run --name tyro-pact-broker-sqlite -p 9292:80 -d soe-repository.cd.tyrocorp.net/pact-broker'
alias drmysql='docker rm -f tyro-mysql-5.6; docker run --name tyro-mysql-5.6 -p 3306:3306 -d soe-repository.cd.tyrocorp.net/tyro-mysql-5.6'

# Typing less for common conventions
alias load-latest-db='mvn setup-database:load-latest-db'
alias jr='cd *jar*'
alias jmx-run.sh='jmx-run'

# Docker-compose
alias dcp=docker-compose

# Misc
alias clm='if `grep -q "secure-dependencies-plugin" pom.xml`; then mvn com.tyro:secure-dependencies-plugin:evaluate ; else echo "secure-dependencies-plugin not found in pom."; fi'
alias clmx='if `grep -q "secure-dependencies-plugin" pom.xml`; then mvn com.tyro:secure-dependencies-plugin:extend-waiver ; else echo "secure-dependencies-plugin not found in pom."; fi'
alias spring-lens='source spring-lens'

alias k=kubectl
alias kcl=kubectl
alias kctx=kubectx
alias kns=kubens

alias vpn-connect-corp='globalprotect connect --portal vpn.corp.tyro.com'
alias vpn-connect-hq='globalprotect connect --portal vpn.hq.tyro.com'
alias vpn-disconnect='globalprotect disconnect'
alias vpn-status='globalprotect show --status'
alias vpn-up='vpn-connect-hq'
alias vpn-down='vpn-disconnect'
alias vpn-refresh-cert='/usr/bin/install_globalprotect_cert.py'


#Kubernetes
alias k8s-describe='~/MyApps/bashUtils/kubernetes/k8s-describe.sh'
alias k8s-log='~/MyApps/bashUtils/kubernetes/k8s-log.sh'
alias k8s-switch='~/MyApps/bashUtils/kubernetes/k8s-switch.sh'
alias k8s-update-context='~/MyApps/bashUtils/kubernetes/k8s-update-context.sh'
alias k8s-applog='~/MyApps/bashUtils/kubernetes/k8s-applog.sh'


#Jmeter
alias jmeter='~/MyApps/apache-jmeter-5.3/bin/jmeter.sh'

#github switch
alias gitswitch='~/MyGit/bashUtils/git/gitswitch.sh' 

#Logs Tool
alias logs="java -jar ~/TyroCode/tools/log-tools-3.89-jar-with-dependencies.jar"
