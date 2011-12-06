<%@ page import="org.opencms.setup.*,java.util.*" session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "../../step_4a_database_validation.jsp";		
	// previous page
	String prevPage = "../../step_2_check_components.jsp";
	
    boolean isFormSubmitted = Bean.setDbParamaters(request, CmsSetupBean.AS400_PROVIDER);

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
内容管理系统安装程序 - 安装<%= Bean.getDatabaseName(Bean.getDatabase()) %> 数据库
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<form method="post" onSubmit="return checkSubmit()" class="nomargin">

<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
<tr><td style="vertical-align: top;">

<%= Bean.getHtmlPart("C_BLOCK_START", "数据库") %>
<table border="0" cellpadding="2" cellspacing="0">
	<tr>
		<td>选择数据库</td>
		<td>
			<select name="database" style="width: 250px;" size="1" onchange="location.href='../../step_3_database_selection.jsp?database='+this.options[this.selectedIndex].value;">
			<!-- --------------------- JSP CODE --------------------------- -->
			<%
				/* get all available databases */
				List databases = Bean.getSortedDatabases();
				/* 	List all databases found in the dbsetup.properties */
				if (databases !=null && databases.size() > 0)	{
					for(int i=0;i<databases.size();i++)	{
						String db = (String) databases.get(i);
						String dn = Bean.getDatabaseName(db);
						String selected = "";
						if(Bean.getDatabase().equals(db))	{
							selected = "selected";
						}
						out.println("<option value='"+db+"' "+selected+">"+dn);
					}
				}
				else	{
					out.println("<option value='null'>没有找到数据库");
				}
			%>
			<!-- --------------------------------------------------------- -->
			</select>
		</td>
		<td><%= Bean.getHtmlHelpIcon("6", "../../") %></td>
	</tr>
</table>
<%= Bean.getHtmlPart("C_BLOCK_END") %>

</td></tr>
<tr><td style="vertical-align: middle;">

<div class="dialogspacer" unselectable="on">&nbsp;</div>
<iframe src="database_information.html" name="dbinfo" style="width: 100%; height: 80px; margin: 0; padding: 0; border-style: none;" frameborder="0" scrolling="no"></iframe>
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
输入连接您的数据库的JDBC <b>连接串</b> （没有数据库的参数 ，例如： <code>jdbc:as400://xxx.xxx.xxx.xxx</code>）。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "4") %>
输入内容管理系统使用的AS400 <b>数据库</b> 名称。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "5") %>
安装工具只是为内容管理系统 <b>创建</b>表<br>&nbsp;<br>
如果想使用已经存在的表那么不选择这个选项。
<%= Bean.getHtmlPart("C_HELP_END") %>

<%= Bean.getHtmlPart("C_HELP_START", "6") %>
<b>AS400 配置说明：</b><br>&nbsp;<br>
安装工具没有创建用户，所以请确定在继续前创建用户。<br>&nbsp;<br>
安装工具没有创建数据库， 所以请在继续前创建它。
<%= Bean.getHtmlPart("C_HELP_END") %>

<% } else	{ %>
内容管理系统安装程序 - 数据库安装
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<%= Bean.displayError("../../")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>