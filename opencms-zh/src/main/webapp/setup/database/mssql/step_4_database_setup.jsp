<%@ page import="org.opencms.setup.*,java.util.*" session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "../../step_4a_database_validation.jsp";		
	// previous page
	String prevPage = "../../step_2_check_components.jsp";
	
    boolean isFormSubmitted = Bean.setDbParamaters(request, CmsSetupBean.MSSQL_PROVIDER);
%>
<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_SCRIPT_HELP") %>
<script type="text/javascript">
<!--
	function checkSubmit()	{
		if(document.forms[0].dbCreateConStr.value == "")	{
			alert("请输入连接串");
			document.forms[0].dbCreateConStr.focus();
			return false;
		}
		else if (document.forms[0].db.value == "")	{
			alert("请输入数据库名");
			document.forms[0].db.focus();
			return false;
		}
		else	{
			return true;
		}
	}

	<%
		if(isFormSubmitted)	{
			out.println("location.href='"+nextPage+"';");
		}
	%>
//-->
</script>
<%= Bean.getHtmlPart("C_HEAD_END") %>

<% if (Bean.isInitialized()) { %>
内容管理系统安装程序 - 安装 <%= Bean.getDatabaseName(Bean.getDatabase()) %> 数据库
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<form method="post" onSubmit="return checkSubmit()" class="nomargin">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
<tr><td style="vertical-align: top;">

<%= Bean.getHtmlPart("C_BLOCK_START", "数据库") %>
<table border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td>选择数据库</td>
		<td><%= Bean.getHtmlForDbSelection() %></td>
		<% if (Bean.getFullDatabaseKey().endsWith("_jpa")) { %>
			<td><%= Bean.getHtmlHelpIcon("7", "../../") %></td>
		<% } else { %>
			<td><%= Bean.getHtmlHelpIcon("6", "../../") %></td>
		<% } %>
	</tr>
</table>
<%= Bean.getHtmlPart("C_BLOCK_END") %>

</td></tr>
<tr><td style="vertical-align: middle;">

<div class="dialogspacer" unselectable="on">&nbsp;</div>
<% if (Bean.getFullDatabaseKey().contains("_jpa")) { %>
	<iframe src="database_information_jpa.html" name="dbinfo" style="width: 100%; height: 80px; margin: 0; padding: 0; border-style: none;" frameborder="0" scrolling="no"></iframe>
<% } else { %>
	<iframe src="database_information.html" name="dbinfo" style="width: 100%; height: 82px; margin: 0; padding: 0; border-style: none;" frameborder="0" scrolling="no"></iframe>
<% } %>
<div class="dialogspacer" unselectable="on">&nbsp;</div>

</td></tr>
<tr><td style="vertical-align: bottom;">

<%= Bean.getHtmlPart("C_BLOCK_START", "数据库设置") %>

<table border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
		<td>用户名</td>
		<td>密码</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>安装时的连接</td>
		<td><input type="text" name="dbCreateUser" size="8" style="width:150px;" value='<%= Bean.getDbCreateUser() %>'></td>
		<td style="text-align: right;"><input type="text" name="dbCreatePwd" size="8" style="width:150px;" value='<%= Bean.getDbCreatePwd() %>'></td>
		<td><%= Bean.getHtmlHelpIcon("1", "../../") %></td>
	</tr>
	<tr>
		<td>内容管理系统使用时的连接</td>
		<td><input type="text" name="dbWorkUser" size="8" style="width:150px;" value='<%= Bean.getDbWorkUser() %>'></td>
		<td style="text-align: right;"><input type="text" name="dbWorkPwd" size="8" style="width:150px;" value='<%= Bean.getDbWorkPwd() %>'></td>
		<td><%= Bean.getHtmlHelpIcon("2", "../../") %></td>
	</tr>
	<tr>
		<td>连接串</td>
		<td colspan="2"><input type="text" name="dbCreateConStr" size="22" style="width:315px;" value='<%= Bean.getDbCreateConStr() %>'></td>
		<td><%= Bean.getHtmlHelpIcon("3", "../../") %></td>
	</tr>
	<tr>
		<td>数据库</td>
		<td colspan="2"><input type="text" name="db" size="22" style="width:315px;" value='<%= Bean.getDb() %>'></td>
		<td><%= Bean.getHtmlHelpIcon("4", "../../") %></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2"><input type="checkbox" name="createDb" value="true" checked> 创建数据库表 
		</td>
		<td><%= Bean.getHtmlHelpIcon("5", "../../") %></td>
	</tr>
</table>
<%= Bean.getHtmlPart("C_BLOCK_END") %>
</td></tr>
</table>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; Back" class="dialogbutton" onclick="location.href='<%= prevPage %>';">
<input name="submit" type="submit" value="Continue &#062;&#062;" class="dialogbutton">
<input name="cancel" type="button" value="Cancel" class="dialogbutton" onclick="location.href='../../index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "1") %>
<b>安装时的连接</b><i>仅</i>在安装过程中使用。<br>&nbsp;<br>
指定的用户必须有数据库的管理员权限，以便创建数据库表。
该用户信息在安装完成后系统将不再保存。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "2") %>
<b>内容管理系统使用时的连接</b>在安装完成后运行内容管理系统时使用。<br>&nbsp;<br>
出于安全上的考虑，指定的用户应该<i>没有</i>数据库管理员的权限。
该用户的信息安装后存储在<code>opencms.properties</code>文件中。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "3") %>
输入连接到你数据库的JDBC<b>连接串</b>。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "4") %>
输入SQLServer用于内容管理系统的<b>数据库</b>名。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "5") %>
安装程序<b>创建</b>内容管理系统的SQLServer数据库表。<br>&nbsp;<br>
<b>注意</b>: 会覆盖已存在的数据库表！<br>&nbsp;<br>
如果要使用一个已经存在的数据库，请不要选中这个选项。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "6") %>
<b>SQLServer安装提示：</b><br>&nbsp;<br>
资源路径最多440个字符，更长的资源路径不能正确使用。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "7") %>
<b>传统的SQL驱动程序</b>已经经过完整测试，与JPA驱动程序相比，性能要稍微好一点。 
因为SQL驱动程序是每个关系数据库管理系统专用的，对于某些数据库，可能没有驱动程序。<br>&nbsp;<br>
<b>JPA驱动程序</b>是新一代驱动程序，基于JPA规范(Java Persistence API)。 
<b>Apache OpenJPA</b>实现了现代JPA，易于扩展，配置灵活。
<%= Bean.getHtmlPart("C_HELP_END") %>

<% } else	{ %>
内容管理系统安装程序 - 数据库安装
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<%= Bean.displayError("../../")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>
