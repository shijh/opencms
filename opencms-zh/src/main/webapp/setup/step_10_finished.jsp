<%@ page session="true" %><%--
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
Alkacon OpenCms Setup Wizard
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
Alkacon OpenCms Setup Wizard - Finished
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized()) { %>

<table border="0" cellpadding="5" cellspacing="0" style="width: 100%; height: 100%;">
<tr>
	<td style="vertical-align: bottom;">
	
		<%= Bean.getHtmlPart("C_BLOCK_START", "Alkacon OpenCms setup finished") %>
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr>
				<td><img src="resources/ok.png" border="0"></td>
				<td>&nbsp;&nbsp;</td>
				<td style="width: 100%;">					
				    The OpenCms welcome page should display in a newly opened browser window now.<br>
					If it does not display, press <a target="OpenCms" href="<%= openLink %>">here</a> to open it.
				</td>
			</tr>
		</table>
		<%= Bean.getHtmlPart("C_BLOCK_END") %>
		<div class="dialogspacer" unselectable="on">&nbsp;</div>
	</td>	
</tr>
<tr>
	<td style="vertical-align: top;">
		<%= Bean.getHtmlPart("C_BLOCK_START", "Wizard locked") %>
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr>
				<td><img src="resources/warning.png" border="0"></td>
				<td>&nbsp;&nbsp;</td>
				<td>
					This setup wizard has now been locked.<br>
					To use the wizard again reset the flag in the "opencms.properties".
					For security reasons, you should remove the "/setup" folder later when
					you have your Alkacon OpenCms installation running.
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
<input name="back" type="button" value="&#060;&#060; Back" class="dialogbutton" disabled="disabled">
<input name="submit" type="button" value="Continue &#062;&#062;" class="dialogbutton" disabled="disabled">
<input name="cancel" type="button" value="Cancel" class="dialogbutton" style="margin-left: 50px;" disabled="disabled">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<% } else	{ %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>