<%@ page session="true" pageEncoding="UTF-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

// next page 
String nextPage = "step_2_check_components.jsp";

boolean isInitialized = false;
boolean wizardEnabled = false;
boolean showButtons = false;

try {
	if (Bean.isInitialized()) {
		session.invalidate();
		response.sendRedirect("index.jsp");
	}
	
	// Initialize the Bean 
	Bean.init(pageContext);

	// check wizards accessability 
	wizardEnabled = Bean.getWizardEnabled();
	
	if (!wizardEnabled) {
		request.getSession().invalidate();
	}	

	isInitialized = true;
} catch (Exception e) {
	// the servlet container did not unpack the war, so lets display an error message
}
%>


<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<script type="text/javascript">
	function toggleButton(theFlag) {
		document.getElementById("continue").disabled = theFlag;
	}	
</script>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 版权协议
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<form action="<%= nextPage %>" method="post" class="nomargin">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%; padding-right: 3px;">
	<% if (wizardEnabled && isInitialized)	{ 
		showButtons = true; %>
		<tr>
			<td style="vertical-align: top;">
				<div class="dialoginnerboxborder"><div class="dialoginnerbox">	
				<iframe src="license.html" name="license" style="width: 100%; height: 310px; margin: 0; padding: 0; border-style: none;" frameborder="0"></iframe>
				</div></div>
			</td>
		</tr>
		<tr>
			<td style="vertical-align: bottom;padding-top: 12px;">
				<table border="0" cellpadding="0" cellspacing="0" style="vertical-align: bottom; height: 20px;">
				<tr>
					<td>你接受本版权协议的全部条款吗？</td>
					<td>&nbsp;&nbsp;</td>
					<td style="width: 25px;"><input type="radio" name="agree" value="yes" onclick="toggleButton(false);"></td>
					<td> 是</td>
					<td>&nbsp;&nbsp;</td>
					<td style="width: 25px;"><input type="radio" name="agree" value="no" onclick="toggleButton(true);" checked="checked"></td>
					<td> 否</td>
				</tr>
		
				</table>
			</td>
		</tr>
	<% } else if (! isInitialized) { %>
		<tr>
			<td style="vertical-align: middle;">
				<%= Bean.getHtmlPart("C_BLOCK_START", "启动安装程序时出错") %>
				<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr>
						<td><img src="resources/error.png" border="0"></td>
						<td>&nbsp;&nbsp;</td>
						<td>
							启动内容管理系统安装程序时出错。<br>
							可能是你的servlet服务器没有解开内容管理系统WAR文件包。<br>
							内容管理系统所需的WAR文件没有解开。
							<br><br>
							<b>请解开内容管理系统的WAR文件然后重试。</b>
							<br><br>
							请查阅你的Servlet服务器的文档，了解如何解开WAR文件包，
							或者手工用解压缩工具解开。
							<br><br>
							对Tomcat用户的提示：<br>
							编辑文件<code>{tomcat-home}/conf/server.xml</code>，找到
							<code>unpackWARs="false"</code>。用<code>unpackWARs="true"</code>替换。
							然后重新启动Tomcat。
						</td>
					</tr>
				</table>
				<%= Bean.getHtmlPart("C_BLOCK_END") %>
			</td>
		</tr>
	<% } else { %>
		<tr>
			<td style="vertical-align: middle; height: 100%;">
				<%= Bean.getHtmlPart("C_BLOCK_START", "安装程序已经上锁") %>
				<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr>
						<td><img src="resources/error.png" border="0"></td>
						<td>&nbsp;&nbsp;</td>
						<td style="width: 100%;">
							内容管理系统安装程序不可用！<br>
							要使用安装程序，在"opencms.properties"中把锁打开。
						</td>
					</tr>
				</table>
				<%= Bean.getHtmlPart("C_BLOCK_END") %>
			</td>
		</tr>
	<% } %>

</table>

<%= Bean.getHtmlPart("C_CONTENT_END") %>

<% if (showButtons) { %>
<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 返回" class="dialogbutton" style="visibility: hidden;" disabled="disabled">
<input name="continue" id="continue" type="submit" value="继续 &#062;&#062;" class="dialogbutton">
<input name="cancel" type="button" value="取消" class="dialogbutton" style="margin-left: 50px; visibility: hidden;" disabled="disabled">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<script type="text/javascript">
	toggleButton(true);
</script>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>