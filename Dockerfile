FROM centos:6.7
MAINTAINER chenyufeng "yufengcode@gmail.com"

# 设置当前的工作目录为/home,也就是当前目录为/home;
WORKDIR /home

# 在当前目录下新建目录tomcat目录;
RUN mkdir tomcat

# 安装tar进行解压缩文件夹，有可能原生的centos中没有带tar;
RUN yum install -y tar

# 把当前构建目录下的jdk压缩包拷贝到镜像/home/目录下；
COPY jdk-8u131-linux-x64.tar /home/

# 注意tar文件的解压方式，解压jdk压缩包；
RUN tar -xvf /home/jdk-8u131-linux-x64.tar

# 如果源路径是目录，则要以/斜杠结尾；把源路径下面的文件复制到目的路径下面；
# 镜像的目标目录如果不存在，则会自动创建；
ADD tomcat/ /home/tomcat

# 添加环境变量
ENV JAVA_HOME /home/jdk1.8.0_131
ENV CATALINA_HOME /home/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin

# 暴露镜像的8080端口；
EXPOSE 8080

ENTRYPOINT /home/tomcat/bin/startup.sh && tail -f /home/tomcat/logs/catalina.out 

# 在容器启动成功后执行以下命令，也就是开启tomcat；
CMD ["/home/tomcat/bin/startup.sh","run"]
