FROM oraclelinux
MAINTAINER Alexey Filanovskiy <alexey.filanovskiy@oracle.com>

RUN yum install -y wget
# Download RPMs
RUN wget https://download3.rstudio.org/centos6.3/x86_64/shiny-server-1.5.13.944-x86_64.rpm
RUN wget https://download2.rstudio.org/server/centos6/x86_64/rstudio-server-rhel-1.3.959-x86_64.rpm

# Install yum packages
RUN yum install -y oracle-epel-release-el7 oracle-release-el7
RUN yum-config-manager --enable ol7_optional_latest ol7_addons
RUN yum -y update && \ 
    yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel && \ 
    yum install -y sudo vim iputils-ping ack-grep net-tools curl grep sed dpkg unzip rsync && \
    yum install -y bzip2 ca-certificates && \
    yum install -y python3-devel && \
    yum install -y gcc-gfortran && \
    yum install -y blas-devel atlas-devel lapack-devel && \
    yum install -y freetype-devel.x86_64 libXft-devel.x86_64 libpng-devel.x86_64  && \
    yum install -y libxml2-devel.x86_64 libxslt-devel.x86_64 zlib-devel.x86_64 python3.x86_64 && \
    yum install -y gcc-c++ libglib2.0-0 libxext6 libsm6 libxrender1 && \
    yum install -y  java-1.8.0 libcurl-devel openssl-devel python-pip  && \
    yum install -y R-3.6.1 R-devel && \
    yum group install -y "Development Tools" && \
    yum install -y krb5-workstation krb5-libs && \
    yum install -y --nogpgcheck shiny-server-1.5.13.944-x86_64.rpm && \
    yum install -y rstudio-server-rhel-1.3.959-x86_64.rpm

# Clean cache
RUN  rm -rf /var/cache/yum/* \
    && yum clean all
RUN rm rstudio-server-rhel-1.3.959-x86_64.rpm
RUN rm shiny-server-1.5.13.944-x86_64.rpm

# Environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre/ \
    PATH=$PATH:$JAVA_HOME/bin \
    USER_NAME=bds \
    USER_ID=15000 \
    GROUP_NAME=bds \
    GROUP_ID=15000 \
    ZEPPELIN_PORT=8080 \
    HOME=/u01 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \    
    SPARK_HOME=/opt/cloudera/parcels/CDH/lib/spark \
    HADOOP_CONF_DIR=/etc/hadoop/conf \    
    ZEPPELIN_ADDR="0.0.0.0" \    
    ZEPPELIN_VERSION=0.9.0-preview1-bin-all 

RUN groupadd -g $GROUP_ID $GROUP_NAME \
    && useradd -g $GROUP_NAME -u $USER_ID $USER_NAME \
    && mkdir -p $HOME

WORKDIR $HOME
ENV ZEPPELIN_HOME=$HOME/zeppelin-$ZEPPELIN_VERSION
# Copy and untar the Zeppelin sources
RUN wget https://downloads.apache.org/zeppelin/zeppelin-0.9.0-preview1/zeppelin-0.9.0-preview1-bin-all.tgz -O zeppelin-0.9.0-preview1-bin-all.tgz 
RUN tar -zxf zeppelin-0.9.0-preview1-bin-all.tgz
RUN rm -rf zeppelin-0.9.0-preview1-bin-all.tgz

# Change ownership of the Zeppelin home to oml:oml
# Grant RWX privileges to the OML group
RUN chown -R $USER_NAME:$GROUP_NAME $ZEPPELIN_HOME \
    && ln -s $ZEPPELIN_HOME $HOME/zeppelin && chmod -R 770 $ZEPPELIN_HOME

##################################################################
RUN mkdir /usr/share/doc/R-3.6.1/html && chmod -R 777  /usr/share/doc/R-3.6.1 &&  touch /usr/share/doc/R-3.6.1/html/R.css
RUN R -e "install.packages(c('devtools','data.table','googleVis','ggplot2','IRkernel','reticulate','knitr'), repos = 'http://cran.us.r-project.org');"
RUN R -e "devtools::install_github('apache/spark@v2.4.0', subdir='R/pkg');"
RUN R -e "install.packages('shiny', repos = 'http://cran.us.r-project.org');"
RUN pip2 install --upgrade pip
RUN python2 -m pip install jupyter-client grpcio protobuf
RUN R -e "IRkernel::installspec(user = FALSE);"
RUN R CMD javareconf

# Install Python stuff
RUN python3 -m pip install --upgrade pip setuptools
RUN python3 -m pip install "py4j<=0.10.7" "holoviews[recommended]" numpy tensorflow pandas scikit-learn jupyter grpcio protobuf matplotlib altair bokeh bkzep ggplot hvplot keras plotnine seaborn utils vega_datasets
RUN python3 -m pip install pyspark

RUN sudo ln -s $ZEPPELIN_HOME/interpreter/python/python/mpl_config.py /usr/local/lib/python3.6/site-packages/mpl_config.py
RUN sudo ln -s $ZEPPELIN_HOME/interpreter/python/python/mpl_config.py /usr/local/lib/python3.6/site-packages/pyspark/mpl_config.py
RUN echo "backend : Agg" >> /usr/local/lib64/python3.6/site-packages/matplotlib/mpl-data/matplotlibrc
RUN python3 -m pip install intake intake-parquet
RUN python3 -m pip install "holoviews[recommended]"
RUN python3 -m pip install "bokeh==2.0.0" bkzep "holoviews[recommended]" "py4j<=0.10.7"
RUN python3 -m pip install jupyter grpcio protobuf

# Configure Install RStudio
RUN echo "rsession-ld-library-path=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre/lib/amd64/server:/usr/lib64/R/lib:/opt/cloudera/parcels/CDH/lib/hadoop/lib/native" >> /etc/rstudio/rserver.conf

COPY jars/* $ZEPPELIN_HOME/interpreter/jdbc/
COPY files/SparkSQL.sh $ZEPPELIN_HOME/notebook/OracleDemo/SparkSQL.sh
COPY files/interpreter.json $ZEPPELIN_HOME/conf/interpreter.json
COPY files/zeppelin-env.sh  $ZEPPELIN_HOME/conf/zeppelin-env.sh
COPY files/startup.sh $ZEPPELIN_HOME/startup.sh
COPY files/Renviron.site /usr/lib64/R/etc/Renviron.site
COPY files/shiro.ini $ZEPPELIN_HOME/conf/shiro.ini

RUN  chmod +x $ZEPPELIN_HOME/startup.sh

# Switch user to bds user
RUN echo welcome1 | passwd bds --stdin

WORKDIR $ZEPPELIN_HOME
EXPOSE $ZEPPELIN_PORT
ENTRYPOINT ["./startup.sh"]