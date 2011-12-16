<%@ page session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%--
--%><%

Bean.prepareStep8b();

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
<head>
<title>内容管理系统安装程序 - 导入模块</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="JavaScript">
<!--

var output = new Array();
<%

Bean.prepareStep8bOutput(out);

%>

function send()	{
	top.window.display.start(output);
}

//-->
</script>

</head>
<body onload="initThread()"></body>
</html>
