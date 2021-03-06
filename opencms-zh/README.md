Other Language：[中文](https://github.com/shijh/opencms/blob/master/opencms-zh/README_zh.md)

Usage Guide for opencms-zh Project
==================================

##Purpose
This project is on building OpenCms Chinese distribution, including source code modifications, properties translation and setup wizard translation.


##Lastest OpenCms Version Supported
OpenCms 9.5.2


##Usage
1. Download source code of this project from github.com.

2. Download source code of opencms-core from https://github.com/alkacon/opencms-core.

3. Install cryptix-jce-provider to your local maven repository

  3.1 Download cryptix-jce-provider-2.1.jar.zip from http://www.java2s.com/Code/JarDownload/cryptix/cryptix-jce-provider-2.1.jar.zip

  3.2 Unzip cryptix-jce-provider-2.1.jar.zip and get cryptix-jce-provider-2.1.jar.

  3.3 Install cryptix-jce-provider-2.1.jar to your local maven repository:
    ```
	mvn install:install-file -Dfile=cryptix-jce-provider-2.1.jar -DgroupId=cryptix -DartifactId=cryptix-jce-provder -Dversion=2.1 -Dpackaging=jar
    ```

4. Config pom.xml:

  4.1 Set "opencms-core-basedir" point to your local opencms-core directory:
    ```
	<opencms-core-basedir>${user.home}/git/opencms-core</opencms-core-basedir>
    ```

  4.2 Set "opencms.war" point to Alkacon OpenCms release:
    ```
	<opencms.war>/opt/opencms-${project.version}/opencms.war</opencms.war>
    ```

  4.3 Set "overwrite.sourcecode" to **true** when you want to override the source files:
    ```
	<overwrite.sourcecode>false</overwrite.sourcecode>
    ```

5. Set maven environment:
  ```
   MAVEN_OPTS = -Dfile.encoding=UTF-8
  ```

6. Run **maven clean**.

   The necessary source code will be copied from opencms-core to this project. You can compare files with old version to decide whether they should be modified.


7. Run **maven install**.

   This will build a opencms-zh-${project.version}.war under target folder.


8. Set tomcat's file encoding to UTF-8:
  ```
   -Dfile.encoding=UTF-8
  ```

9. Deploy the opencms-zh war and install it as a normal opencms war.


##Trouble Shooting
1. How could I know what you changed in the source code?

   A: You can search Shi Jinghai in the source code to see what changes. I commented every changes in java with a format like this:
```
       // modyfied by Shi Jinghai, huaruhai@hotmail.com  2011-12-14
       result.append(" style=\"width: " + (curTab.length() * 12 + addDelta) + "px;\"");
       // result.append(" style=\"width: " + (curTab.length() * 8 + addDelta) + "px;\"");
```

##Feedback
Welcome any feedback on this project! You can use github.com to comment the source code or send email to me: huaruhai@hotmail.com.
