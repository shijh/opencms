<%@ page import="org.opencms.setup.*,java.util.*" session="true" pageEncoding="utf-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "../../step_4a_database_validation.jsp";		
	// previous page
	String prevPage = "../../step_2_check_components.jsp";
	
    boolean isFormSubmitted = Bean.setDbParamaters(request, CmsSetupBean.ORACLE_PROVIDER);
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
		else if (document.forms[0].dbWorkUser.value == "")	{
			alert("请输入用户名");
			document.forms[0].dbWorkUser.focus();
			return false;
		}
		else if (document.forms[0].dbWorkPwd.value == "")	{
			alert("请输入密码");
			document.forms[0].dbWorkPwd.focus();
			return false;
		}
		else if (document.forms[0].createDb.value != "" && document.forms[0].dbDefaultTablespace.value == "") {
			alert("请输入缺省表空间名");
			document.forms[0].dbWorkPwd.focus();
			return false;
		}
		else if (document.forms[0].createDb.value != "" && document.forms[0].dbIndexTablespace.value == "") {
			alert("请输入索引表空间名");
			document.forms[0].dbWorkPwd.focus();
			return false;
		}
		else if (document.forms[0].createDb.value != "" && document.forms[0].dbTemporaryTablespace.value == "") {
			alert("请输入临时表空间名");
			document.forms[0].dbWorkPwd.focus();
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
<form method="POST" onSubmit="return checkSubmit()" class="nomargin" autocomplete="off">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
<tr><td style="vertical-align: top;">

<%= Bean.getHtmlPart("C_BLOCK_START", "数据库") %>
<table border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td>选择数据库</td>
		<td><%= Bean.getHtmlForDbSelection() %></td>
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
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>安装时的连接</td>
							<td><input type="text" name="dbCreateUser" size="8" style="width:120px;" value='<%= Bean.getDbCreateUser() %>'></td>
							<td><input type="text" name="dbCreatePwd" size="8" style="width:120px;" value='<%= Bean.getDbCreatePwd() %>'></td>
							<td><%= Bean.getHtmlHelpIcon("1", "../../") %></td>
							<td>&nbsp;</td>
						</tr>
						<%
						String user = Bean.getDbWorkUser();
						%>
						<tr>
							<td>内容管理系统使用时的连接</td>
							<td><input type="text" name="dbWorkUser" size="8" style="width:120px;" value='<%= user %>'></td>
							<td><input type="text" name="dbWorkPwd" size="8" style="width:120px;" value='<%= Bean.getDbWorkPwd() %>'></td>
							<td><%= Bean.getHtmlHelpIcon("2", "../../") %></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>连接串</td>
							<td colspan="2"><input type="text" name="dbCreateConStr" size="22" style="width:250px;" value='<%= Bean.getDbCreateConStr() %>'></td>
							<td><%= Bean.getHtmlHelpIcon("3", "../../") %></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>缺省</td>
							<td>索引</td>
							<td>临时</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>表空间</td>
							<td><input type="text" name="dbDefaultTablespace" size="8" style="width:120px;" value='<%= Bean.getDbProperty(Bean.getDatabase() + ".defaultTablespace") %>'></td>
							<td><input type="text" name="dbIndexTablespace" size="8" style="width:120px;" value='<%= Bean.getDbProperty(Bean.getDatabase() + ".indexTablespace") %>'></td>
							<td><input type="text" name="dbTemporaryTablespace" size="8" style="width:120px;" value='<%= Bean.getDbProperty(Bean.getDatabase() + ".temporaryTablespace") %>'></td>
							<td><%= Bean.getHtmlHelpIcon("4", "../../") %></td>
						</tr>
						<tr>
							<td>创建数据库</td>
							<td><input type="checkbox" name="createDb" value="true" checked> User</td>
							<td><input type="checkbox" name="createTables" value="true" checked> Tables<input type="hidden" name="createTables" value="false"></td>
							<td><%= Bean.getHtmlHelpIcon("5", "../../") %></td>
							<td>&nbsp;</td>
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
b>缺省</b>表空间存放内容管理系统所需的全部数据。<br><br>
<b>索引</b>表空间可以与缺省表空间项同，但是这样做会降低数据库的性能。<br><br>
<b>临时</b>表空间是Oracle临时数据所需的表空间
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "5") %>
安装程序<b>创建</b>Oracle用于内容管理系统的用户、数据库和表。<br>&nbsp;<br>
<b>注意</b>: 会覆盖已存在的数据库表！<br>&nbsp;<br>
如果要使用一个已经存在的数据库，请不要选中这个选项。
<%= Bean.getHtmlPart("C_HELP_END") %>

<% } else	{ %>
内容管理系统安装程序 - 数据库安装
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<%= Bean.displayError("../../")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>
