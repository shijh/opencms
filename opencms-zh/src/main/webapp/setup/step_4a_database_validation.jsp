<%@ page import="org.opencms.setup.*,java.util.*" session="true" pageEncoding="UTF-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page 
	String nextPage = "step_5_database_creation.jsp";	
	// previous page 
	String prevPage = "step_3_database_selection.jsp";

	CmsSetupDb db = null;
	boolean enableContinue = false;
	String chkVars = null;
	List conErrors = null;

	if (Bean.isInitialized()) {
		db = new CmsSetupDb(Bean.getWebAppRfsPath());
		// try to connect as the runtime user
		db.setConnection(Bean.getDbDriver(), Bean.getDbWorkConStr(), Bean.getDbConStrParams(), Bean.getDbWorkUser(),Bean.getDbWorkPwd());
		if (!db.noErrors()) {
		    // try to connect as the setup user
		    db.closeConnection();
			db.clearErrors();
			db.setConnection(Bean.getDbDriver(), Bean.getDbCreateConStr(), Bean.getDbConStrParams(), Bean.getDbCreateUser(), Bean.getDbCreatePwd());
		}
		conErrors = new ArrayList(db.getErrors());
		db.clearErrors();
		enableContinue = conErrors.isEmpty();
		chkVars = db.checkVariables(Bean.getDatabase());
		db.closeConnection();
		if (enableContinue && db.noErrors() && chkVars == null && Bean.validateJdbc()) {
			response.sendRedirect(nextPage);
			return;
		}
	}
%><%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 验证数据库链接
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized())	{ %>
<form action="<%= nextPage %>" method="post" class="nomargin">
<table border="0" cellpadding="5" cellspacing="0" style="width: 100%; height: 350px;">
<tr>
	<td style="vertical-align: middle;">
				<%
					if (!enableContinue) {
						%>
						<%= Bean.getHtmlPart("C_BLOCK_START", "创建数据库连接") %>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="resources/error.png" border="0"></td>
								<td>&nbsp;&nbsp;</td>
								<td>无法用指定的参数创建数据库连接。<br>
									请检查下面的意外错误。出现这个错误可能有两个原因:
									<ul>
									  <li><b>你的数据库停了</b>，或者</li>
									  <li><b>你的数据库用指定的参数无权访问。</b></li>
									</ul>
									另外请注意， 对<%=Bean.getDatabaseName(Bean.getDatabase())%>我们推荐使用下列JDBC驱动程序:<br>
									<code><%=Bean.getDatabaseLibs(Bean.getDatabase()).toString()%></code><p>
									请检查这个JDBC驱动程序在你的Java类的路径上。
                        </td>
							</tr>
							<tr>
								<td colspan='2'>&nbsp;&nbsp;</td>
								<td style="width: 100%;">
									<div style="width: 100%; height:200px; overflow: auto;">
									<%
									for (int i = 0; i < conErrors.size(); i++)	{
										out.println(conErrors.get(i) + "<br>");
										out.println("-------------------------------------------" + "<br>");
									}
							 		%>
									</div>
								</td>
							</tr>				
						</table>
						<%= Bean.getHtmlPart("C_BLOCK_END") %>
						<%
					} else {
						if (!Bean.validateJdbc()) {
							%>
							<%= Bean.getHtmlPart("C_BLOCK_START", "正在验证数据库驱动程序") %>
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><img src="resources/warning.png" border="0"></td>
									<td>&nbsp;&nbsp;</td>
									<td>请注意，对于<%=Bean.getDatabaseName(Bean.getDatabase())%>我们推荐使用下列JDBC驱动程序:<br>
										<code><%=Bean.getDatabaseLibs(Bean.getDatabase()).toString()%></code><p>
										<b>但是这些驱动程序不在<code><%=Bean.getLibFolder()%></code>中</b><p>
										<i>如果你使用其它驱动程序或者你用其它方法把驱动程序添加到Java类路径(classpath)，
										   你可以继续。如果<b>不是这样</b>的，请找到并部署好这些驱动程序, 并重新启动 
										   你的servlet服务器。</i>
									</td>
								</tr>
							</table>
							<%= Bean.getHtmlPart("C_BLOCK_END") %>
							<%
						}					
						if (!db.noErrors() || chkVars != null)	{ %>
							<%= Bean.getHtmlPart("C_BLOCK_START", "验证数据库服务器配置") %>
							<table border="0" cellpadding="0" cellspacing="0"><%
						    boolean isError = !db.noErrors();
							enableContinue = enableContinue && !isError;
							if (chkVars != null) {%>
								<tr>
									<td><img src="resources/warning.png" border="0"></td>
									<td>&nbsp;&nbsp;</td>
									<td><%=chkVars%></td>
								</tr><%
							}
							if (!db.noErrors()) {%>
								<tr>
									<td><img src="resources/error.png" border="0"></td>
									<td>&nbsp;&nbsp;</td>
									<td style="width: 100%;">
										<div style="width: 100%; height:140px; overflow: auto;">
										<p style="margin-bottom: 4px;">检查服务器配置时出错!</p>
										<%
										out.println("-------------------------------------------" + "<br>");
										List<String> errors = db.getErrors();
										Iterator<String> it = errors.iterator();
										while (it.hasNext())	{
											out.println(it.next() + "<br>");
										}
										db.clearErrors();
										%>
										</div>
									</td>
								</tr><%
							}%>
							</table>
							<%= Bean.getHtmlPart("C_BLOCK_END") %>
							<%
						}
					}
				%>

	</td>
</tr>
</table>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="location.href='<%= prevPage %>';">
<input name="btcontinue" type="submit" value="继续 &#062;&#062;" class="dialogbutton" disabled="disabled" id="btcontinue">
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="location.href='index.jsp';" style="margin-left: 50px;">
</form>
<% if (enableContinue)	{
	out.println("<script type=\"text/javascript\">\ndocument.getElementById(\"btcontinue\").disabled = false;\n</script>");
} %>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<% } else	{ %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>
