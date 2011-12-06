<%@ page session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "step_9_browser_configuration_notes.jsp";	
	// previous page 
	String prevPage = "index.jsp";
	
	boolean importWp = Bean.prepareStep8();	

%>
<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序 - 导入模块
<%= Bean.getHtmlPart("C_HEAD_START") %>

<% if (importWp) { 
    // import the workplace
%>
</head>
<frameset rows="100%,*">
	<frame src="step_8a_display_import.jsp" name="display">
	<frame src="about:blank" name="data">
</frameset>
</html>
<%} else { %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 导入模块
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized()) { %>
<form action="<%= nextPage %>" method="post" class="nomargin">
<table border="0" cellpadding="5" cellspacing="0" style="width: 100%; height: 100%;">
<tr>
	<td style="vertical-align: middle;">
		<%= Bean.getHtmlPart("C_BLOCK_START", "Import modules") %>
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
			
			<tr>
				<td><img src="resources/warning.png" border="0"></td>
				<td>&nbsp;&nbsp;</td>
				<td style="width: 100%;">
					没有导入模块。<br>
					没有虚拟文件系统内容管理系统不会工作!
				</td>
			</tr>
		</table>
		<%= Bean.getHtmlPart("C_BLOCK_END") %>
	</td>
</tr>
</table>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="location.href='<%= prevPage %>';">
<input name="submit" type="submit" value="继续 &#062;&#062;" class="dialogbutton">
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="top.document.location.href='index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<% } else { %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>
<% } %>
