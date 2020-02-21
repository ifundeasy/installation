# Bash History
##############################################################################
export HISTFILESIZE=
export HISTSIZE=

# Terminal Text
##############################################################################
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export PS1="\A \[\e[36m\]\u\[\e[m\]@\[\e[33m\]\W\[\e[m\] \\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

# Node Version Manager
##############################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PHP Extension, PHP-INTL (INSTALLED USING FROM BREW: `brew install icu4c`)
##############################################################################
# export PATH="/usr/local/opt/icu4c/bin:$PATH"	
# export PATH="/usr/local/opt/icu4c/sbin:$PATH"
# export LDFLAGS="-L/usr/local/opt/icu4c/lib"
# export CPPFLAGS="-I/usr/local/opt/icu4c/include"
# export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

# Rails
##############################################################################
# export PATH="$PATH:$HOME/.rvm/bin"
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# MacPorts
##############################################################################
# export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Java (Useless when use JENV)
##############################################################################
# export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH=${JAVA_HOME}/bin:$PATH

# Java && Java Version Manager (JENV)
##############################################################################
# if which jenv > /dev/null; then eval "$(jenv init -)"; fi
# export PATH="$HOME/.jenv/bin:$PATH"
# export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
# alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'
# export PATH=${JAVA_HOME}/bin:$PATH

# Scala
##############################################################################
export PATH="/usr/local/opt/scala@2.11/bin:$PATH"

# Maven
##############################################################################
export M2_HOME="$HOME/Maven"
export PATH=${M2_HOME}/bin:$PATH

# Hadoop
##############################################################################
# export HADOOP_HOME=$HOME/Hadoop
# export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin 
## some convenient aliases and functions for running Hadoop-related commands
# unalias fs &> /dev/null
# alias fs="hadoop fs"
# unalias hls &> /dev/null
# alias hls="fs -ls"

# HBase
##############################################################################
# export HBASE_HOME=$HOME/HBase
# export PATH=$PATH:$HBASE_HOME/bin

# ArangoDB
##############################################################################
# export ARANGODB_HOME=/usr/local/opt/arangodb
# export PATH=$PATH:$ARANGODB_HOME/sbin

# Kafka
##############################################################################
export KAFKA_HOME=$HOME/Kafka
export PATH=$PATH:$KAFKA_HOME/bin

# Spark
##############################################################################
# export SPARK_HOME=$HOME/Spark
# export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
# export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
# export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native:$LD_LIBRARY_PATH
# export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
# export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
# export PATH=$PATH:$SPARK_HOME/sbin:$SPARK_HOME/bin

# Solr
##############################################################################
export SOLR_HOME=$HOME/Solr
export PATH=$PATH:$SOLR_HOME/bin

# Hadoop
#############################################################################
# export HADOOP_INSTALL=$HADOOP_HOME
# export HADOOP_MAPRED_HOME=$HADOOP_HOME
# export HADOOP_COMMON_HOME=$HADOOP_HOME
# export HADOOP_HDFS_HOME=$HADOOP_HOME
# export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
# export YARN_HOME=$HADOOP_HOME
# export CLASSPATH=$CLASSPATH:$SOLR_HOME/lib/*

# Other
##############################################################################
# ntfs-3g - gettext
# export PATH="/usr/local/opt/gettext/bin:$PATH"
