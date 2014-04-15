<%@ page import="org.opencms.setup.*,java.util.*" session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "../../step_4a_database_validation.jsp";		
	// previous page
	String prevPage = "../../step_2_check_components.jsp";
	
    boolean isFormSubmitted = Bean.setDbParamaters(request, CmsSetupBean.DB2_PROVIDER);

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
		} else if (!isValidDbName(document.forms[0].db.value)) {
		    alert("无效的数据库名");
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
<form method="post" onSubmit="return checkSubmit()" class="nomargin" autocomplete="off">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
<tr><td style="vertical-align: top;">

<%= Bean.getHtmlPart("C_BLOCK_START", "数据库") %>
<table border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td>选择数据库</td>
		<td><%= Bean.getHtmlForDbSelection() %></td>
		<td><%= Bean.getHtmlHelpIcon("6", "../../") %></td>
	</tr>
</table>
<%= Bean.getHtmlPart("C_BLOCK_END") %>

</td></tr>
<tr><td style="vertical-align: middle;">

<div class="dialogspacer" unselectable="on">&nbsp;</div>
<iframe src="database_information.html" name="dbinfo" style="width: 100%; height: 82px; margin: 0; padding: 0; border-style: none;" frameborder="0" scrolling="no"></iframe>
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
		<td colspan="2"><input type="checkbox" name="createTables" value="true" checked> 创建数据库表 
		</td>
		<td><%= Bean.getHtmlHelpIcon("5", "../../") %></td>
	</tr>
</table>
<%= Bean.getHtmlPart("C_BLOCK_END") %>
</td></tr>
</table>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="location.href='<%= prevPage %>';">
<input name="submit" type="submit" value="继续 &#062;&#062;" class="dialogbutton">
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="location.href='../../index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "2") %>
<b>内容管理系统使用时的连接</b>在运行内容管理系统时使用。<br>&nbsp;<br>
在安装的过程中，用户需要有创建表和索引的权限（如果您想要安装工具创建它们）。
出于安全上的考虑，指定的用户应该<i>没有</i>数据库管理员的权限。
该用户的信息安装后存储在<code>opencms.properties</code>文件中。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "3") %>
输入连接到你数据库的JDBC<b>连接串</b>（不包括数据库名称).
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "4") %>
输入DB2用于内容管理系统的<b>数据库</b>名。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "5") %>
安装程序仅创建内容管理系统的表，并非数据库<br>&nbsp;<br>
<b>注意</b>： 创建您的数据库的命令如： <code>CREATE DATABASE ${database} USING CODESET UTF-8 TERRITORY DE PAGESIZE 32 K;</code><br>&nbsp;<br>
不选择这个选项使用已经存在的数据库表。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "6") %>
<b>DB2 v9 配置说明：</b><br>&nbsp;<br>
DB2 利用系统用户，所以请在继续下一步前确定已经创建系统用户 。<br>&nbsp;<br>
安装程序并不创建数据库，所以请在继续下一步前创建，语句如 ：<code>CREATE DATABASE ${database} USING CODESET UTF-8 TERRITORY DE PAGESIZE 32 K;</code>.
<%= Bean.getHtmlPart("C_HELP_END") %>

<% } else	{ %>
内容管理系统安装程序 - 数据库安装
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<%= Bean.displayError("../../")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>