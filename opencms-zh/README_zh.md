Other Language：[English](https://github.com/shijh/opencms/blob/master/opencms-zh/README.md)

opencms-zh使用指南
==================================

##目的
本项目用于构建OpenCms中文版，包括了源代码修改、属性文件翻译和安装程序翻译。


##支持的最新OpenCms版本
OpenCms 9.5.2


##使用
1. 从github.com下载本项目源代码。

2. 从https://github.com/alkacon/opencms-core下载opencms-core源代码。

3. 把cryptix-jce-provider安装到你本地maven库

  3.1 从http://www.java2s.com/Code/JarDownload/cryptix/cryptix-jce-provider-2.1.jar.zip下载 cryptix-jce-provider-2.1.jar.zip

  3.2 解压缩cryptix-jce-provider-2.1.jar.zip得到cryptix-jce-provider-2.1.jar。

  3.3 把cryptix-jce-provider-2.1.jar安装到你本地的maven库中：
    ```
	mvn install:install-file -Dfile=cryptix-jce-provider-2.1.jar -DgroupId=cryptix -DartifactId=cryptix-jce-provder -Dversion=2.1 -Dpackaging=jar
    ```

4. 配置pom.xml:

  4.1 把"opencms-core-basedir"指向你本地的opencms-core目录:
    ```
	<opencms-core-basedir>${user.home}/git/opencms-core</opencms-core-basedir>
    ```
  4.2 把"opencms.war"指向Alkacon OpenCms的发布版本地war文件:
    ```
	<opencms.war>/opt/opencms-${project.version}/opencms.war</opencms.war>
    ```
  4.3 当你要使用最新OpenCms源文件覆盖本项目的源文件时，把"overwrite.sourcecode"设置为**true**:
    ```
	<overwrite.sourcecode>false</overwrite.sourcecode>
    ```

5. 设置maven环境:
  ```
   MAVEN_OPTS = -Dfile.encoding=UTF-8
  ```
6. 运行**maven clean**：

   所需的源代码会从opencms-core复制到本项目中。你可以通过Eclipse等工具中的版本比较功能，来决定这些文件是否需要修改。

7. 运行**maven package**：

   这个命令会在target文件夹下构建一个opencms-zh-${project.version}.war文件，比如opencms-zh-9.5.2.war。

8. 把Tomcat的文件编码设置为UTF-8:
  ```
   -Dfile.encoding=UTF-8
  ```
9. 部署opencms-zh war文件，安装方法同opencms war文件。


##常见问题
1. 我怎么知道你修改了哪些代码？

   答：你可以搜索代码中的Shi Jinghai，查看修改了哪些内容。我对每处代码修改都做了注释，样式如下：
  ```
       // modyfied by Shi Jinghai, huaruhai@hotmail.com  2011-12-14
       result.append(" style=\"width: " + (curTab.length() * 12 + addDelta) + "px;\"");
       // result.append(" style=\"width: " + (curTab.length() * 8 + addDelta) + "px;\"");
  ```

##反馈
欢迎反馈！你可以使用github.com来评论代码，或者给我发送邮件：huaruhai@hotmail.com。
