Other Language：[English](https://github.com/shijh/opencms/blob/master/opencms-zh/README.md)

opencms-zh使用指南
==================================

##目的
本项目用于构建OpenCms中文版，包括了源代码修改、属性文件翻译和安装程序翻译。


##支持的最新OpenCms版本
OpenCms 9.5.2


##使用
1。 从github.com下载本项目源代码。

2。 从https://github.com/alkacon/opencms-core下载opencms-core源代码。

3。 把cryptix-jce-provider安装到你本地maven库
  1. 从http://www.java2s.com/Code/JarDownload/cryptix/cryptix-jce-provider-2.1.jar.zip下载 cryptix-jce-provider-2.1.jar.zip

  2. Unzip cryptix-jce-provider-2.1.jar.zip and get cryptix-jce-provider-2.1.jar.

  3. Install cryptix-jce-provider-2.1.jar to your local maven repository:
	mvn install:install-file -Dfile=cryptix-jce-provider-2.1.jar -DgroupId=cryptix -DartifactId=cryptix-jce-provder -Dversion=2.1 -Dpackaging=jar


4. Config pom.xml:
  1. Set "opencms-core-basedir" point to your local opencms-core directory:
	<opencms-core-basedir>${user.home}/git/opencms-core</opencms-core-basedir>

  2. Set "opencms.war" point to Alkacon OpenCms release:
	<opencms.war>/opt/opencms-${project.version}/opencms.war</opencms.war>

  3. Set "overwrite.sourcecode" to true when you want to override the source files:
	<overwrite.sourcecode>false</overwrite.sourcecode>


5. Set maven environment:
   MAVEN_OPTS = -Dfile.encoding=UTF-8

6. Run maven clean.
   The necessary source code will be copied from opencms-core to this project. You can compare files with old version to decide whether they should be modified.

7. Run maven package.
   This will build a opencms-zh-${project.version}.war under target folder.

8. Set tomcat's file encoding to UTF-8:
   -Dfile.encoding=UTF-8

9. Deploy the opencms-zh war and install it as a normal opencms war.


##Trouble Shooting
1.  How could I know what you changed in the source code?
   You can search Shi Jinghai in the source code to see what changes. I commented every changes in java with a format like this:
       // modyfied by Shi Jinghai, huaruhai@hotmail.com  2011-12-14
       result.append(" style=\"width: " + (curTab.length() * 12 + addDelta) + "px;\"");
       // result.append(" style=\"width: " + (curTab.length() * 8 + addDelta) + "px;\"");


##Feedback
Welcome any feedback on this project! You can use github.com to comment the source code or send email to me: huaruhai@hotmail.com.
