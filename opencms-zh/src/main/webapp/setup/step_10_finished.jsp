<%@ page session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	String servletMapping = Bean.getServletMapping();
	if (!servletMapping.startsWith("/")) {
	    servletMapping = "/" + servletMapping;
	}
	if (servletMapping.endsWith("/*")) {
	    // usually a mapping must be in the form "/opencms/*", cut off all slashes
	    servletMapping = servletMapping.substring(0, servletMapping.length() - 2);
	}
	String openLink = request.getContextPath() + servletMapping + "/index.html";
	if (Bean.isInitialized()) {
		Bean.prepareStep10();
		session.invalidate();
	}
%>
<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<script type="text/javascript">
function openWin() {
	var theWindow = window.open("<%= openLink %>", "OpenCms", "top=10,left=10,width=980,height=550,location=yes,menubar=yes,resizable=yes,scrollbars=yes,status=yes,toolbar=yes");
	theWindow.focus();
}
<% if (Bean.isInitialized()) { 
// open window
%>
openWin();
<% } %>
</script>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 已完成
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized()) { %>

<table border="0" cellpadding="5" cellspacing="0" style="width: 100%; height: 100%;">
<tr>
	<td style="vertical-align: bottom;">
	
		<%= Bean.getHtmlPart("C_BLOCK_START", "完成内容管理系统的安装") %>
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr>
				<td><img src="resources/ok.png" border="0"></td>
				<td>&nbsp;&nbsp;</td>
				<td style="width: 100%;">					
				   内容管理系统的欢迎页面应该显示在一个新打开的浏览器窗口中。<br>
				    如果没有显示出来，点击<a target="OpenCms" href="<%= openLink %>">这里</a>来打开它。<br><br>
				    如果出现错误页面，请重新启动你的Servlet服务器（如Apache Tomcat），然后重试。
				</td>
			</tr>
		</table>
		<%= Bean.getHtmlPart("C_BLOCK_END") %>
		<div class="dialogspacer" unselectable="on">&nbsp;</div>
	</td>	
</tr>
<tr>
	<td style="vertical-align: top;">
		<%= Bean.getHtmlPart("C_BLOCK_START", "已锁住安装程序") %>
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr>
				<td><img src="resources/warning.png" border="0"></td>
				<td>&nbsp;&nbsp;</td>
				<td>
					安装程序已经被锁住了。<br>
					如果想再次使用本程序，重新设置"opencms.properties"中的相关标志。
					出于安全考虑，当安装的内容管理系统安装并开始运行时，你应该删除"/setup"目录。
				</td>
			</tr>
		</table>
		<%= Bean.getHtmlPart("C_BLOCK_END") %>
	</td>
</tr>
</table>


<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<form action="" method="post" class="nomargin">
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" disabled="disabled">
<input name="submit" type="button" value="继续 &#062;&#062;" class="dialogbutton" disabled="disabled">
<input name="cancel" type="button" value="取消" class="dialogbutton" style="margin-left: 50px;" disabled="disabled">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<% } else	{ %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>