<%@ page session="true" pageEncoding="utf-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "step_10_finished.jsp";
	// previous page
	String prevPage = "step_7_save_properties.jsp";

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
内容管理系统安装程序 - 浏览器设置
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if(Bean.isInitialized())	{ %>
<form action="<%= nextPage %>" method="post" class="nomargin">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; padding-right: 3px;">
	<tr>
		<td style="vertical-align: top;">
			<div class="dialoginnerboxborder"><div class="dialoginnerbox">
			<iframe src="browser_config.html" name="config" style="width: 100%; height: 310px; margin: 0; padding: 0; border-style: none;" frameborder="0"></iframe>
			</div></div>
		</td>
	</tr>
	<tr>
		<td style="vertical-align: bottom;padding-top: 12px;">
			<table border="0" cellpadding="0" cellspacing="0" style="vertical-align: bottom; height: 20px;">
			<tr>
				<td>你阅读这些重要的配置说明了吗？</td>
				<td>&nbsp;&nbsp;</td>
				<td style="width: 25px;"><input type="radio" name="understood" value="true" onclick="toggleButton(false);"></td>
				<td> 是</td>
				<td>&nbsp;&nbsp;</td>
				<td style="width: 25px;"><input type="radio" name="understood" value="no" onclick="toggleButton(true);" checked="checked"></td>
				<td> 否</td>
			</tr>

			</table>
		</td>
	</tr>
</table>

<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="location.href='<%= prevPage %>';" disabled="disabled">
<input name="continue" id="continue" type="submit" value="完成" class="dialogbutton" disabled="disabled">
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="location.href='index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<% } else { %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>