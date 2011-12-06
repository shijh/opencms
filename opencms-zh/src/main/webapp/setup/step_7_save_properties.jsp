<%@ page session="true" pageEncoding="utf-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page 
	String nextPage = "step_8_import_modules.jsp";	
	// previous page
	String prevPage = "step_6_module_selection.jsp";
	
	String serverUrl = request.getScheme() + "://" + request.getServerName();
	int serverPort = request.getServerPort();
	if (serverPort != 80) {
		serverUrl += ":" + serverPort;
	}
%>
<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_SCRIPT_HELP") %>
<script type="text/javascript">
	function checkSubmit() {
		// checks the server URL and the ethernet MAC address
		var regExp = "^(http|https|ftp)\://((([a-z_0-9\-]+)+(([\:]?)+([a-z_0-9\-]+))?)(\@+)?)?(((((([0-1])?([0-9])?[0-9])|(2[0-4][0-9])|(2[0-5][0-5])))\.(((([0-1])?([0-9])?[0-9])|(2[0-4][0-9])|(2[0-5][0-5])))\.(((([0-1])?([0-9])?[0-9])|(2[0-4][0-9])|(2[0-5][0-5])))\.(((([0-1])?([0-9])?[0-9])|(2[0-4][0-9])|(2[0-5][0-5]))))|((([a-z0-9\-])+\.)+([a-z]{2}\.[a-z]{2}|[a-z]{2,4})))(([\:])(([1-9]{1}[0-9]{1,3})|([1-5]{1}[0-9]{2,4})|(6[0-5]{2}[0-3][0-6])))?$";
		var isUrlOK = document.forms[0].workplaceSite.value.match(regExp);
		regExp = "^([0-9a-fA-F][0-9a-fA-F]:){5}([0-9a-fA-F][0-9a-fA-F])$";
		var macValue = document.forms[0].ethernetAddress.value;
		var isMacOK = macValue.match(regExp);
		if (isUrlOK && (isMacOK || macValue == "")) {
			return true;
		} else if (!isMacOK) {
			alert("请输入服务器的MAC地址\n或者空着让程序产生一个随机的地址。");
		} else if (!isUrlOK) {
			alert("请输入内容管理系统作业区的有效地址。");
		}
		return false;
	}
</script>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 设置
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized())	{ %>
<form action="<%= nextPage %>" method="post" class="nomargin" onsubmit="return checkSubmit();">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 350px;">
<tr>
	<td style="vertical-align: top;">

<%= Bean.getHtmlPart("C_BLOCK_START", "内容管理系统设置") %>
<table border="0" cellpadding="4" cellspacing="0">
	<tr>
		<td>输入你的服务器的MAC地址</td>
		<td>
			<input type="text" name="ethernetAddress" value="<%= Bean.getEthernetAddress() %>" style="width: 150px;">
			
		</td>
		<td><%= Bean.getHtmlHelpIcon("1", "") %></td>
	</tr>
		<tr>
		<td>输入你的内容管理系统网站的网址</td>		
		<td>
			<input type="text" name="workplaceSite" value="<%= serverUrl %>" style="width: 150px;">
		</td>
		<td><%= Bean.getHtmlHelpIcon("3", "") %></td>
	</tr>
	<tr>
		<td>输入你的内容管理服务器的名字</td>		
		<td>
			<input type="text" name="serverName" value="<%= Bean.getServerName() %>" style="width: 150px;">
		</td>
		<td><%= Bean.getHtmlHelpIcon("2", "") %></td>
	</tr>
</table>
<%= Bean.getHtmlPart("C_BLOCK_END") %>

</td></tr></table>

<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="location.href='<%= prevPage %>';">
<input name="submit" type="submit" value="继续 &#062;&#062;" class="dialogbutton">
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="location.href='index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "1") %>

<b>服务器名称：</b><br>&nbsp;<br>
服务器名称会用于内容管理系统的多种日志信息。<br>&nbsp;<br>
如果你需要比较多个不同服务器的日志文件，这会带来很多便利。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "3") %>
<b>内容管理服务器网站网址：</b><br>&nbsp;<br>
内容管理系统能够管理多个网站。
然而，内容管理系统作业区只能通过一个指定的网址访问。<br>&nbsp;<br>
你输入的网站网址既作为访问作业区的网址，还作为缺省站点的网址。
为了让你能够添加其它站点，或者如果你要对缺省站点和作业区使用不同的网址，
你必须在安装后自己编辑<code>opencms-system.xml</code>文件。
<%= Bean.getHtmlPart("C_HELP_END") %>

<% } else	{ %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>
