<%@ page import="org.opencms.setup.*,java.util.*" session="true" pageEncoding="utf-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page 
	String nextPage = "step_6_module_selection.jsp";	
	// previous page 
	String prevPage = "step_3_database_selection.jsp";

	CmsSetupDb db = null;

	boolean createDb = false;
	boolean createTables = false;
	boolean dbExists = false;
	boolean dropDb = false;

	if (Bean.isInitialized()) {
		String temp;
		Object a;
		if ((a = session.getAttribute("createDb")) != null) {
			createDb = "true".equals(a.toString());
		}
		if (((a = session.getAttribute("createTables")) != null) && (a.toString().length() > 0)) {
			createTables = "true".equals(a.toString());
	    } else {
			// if not explicitly set, we will certainly create the
			// tables when creating a new database
	    	createTables = createDb;
	    }
		if(createDb || createTables)	{
			db = new CmsSetupDb(Bean.getWebAppRfsPath());
			temp = request.getParameter("dropDb");
			dropDb = (temp != null) && "Yes".equals(temp);
			if (Bean.getDatabase().startsWith("db2") || Bean.getDatabase().startsWith("as400")) {
			    dbExists = true;
			    dropDb = true;
			    createDb = false;
			}
			/* check if database exists */
			if(!dropDb)	{
			    if (Bean.getDatabase().startsWith("oracle") || Bean.getDatabase().startsWith("db2") || Bean.getDatabase().startsWith("as400")) {
					db.setConnection(Bean.getDbDriver(), Bean.getDbWorkConStr(), Bean.getDbConStrParams(), Bean.getDbWorkUser(), Bean.getDbWorkPwd());
				} else {
					db.setConnection(Bean.getDbDriver(), Bean.getDbWorkConStr(), Bean.getDbConStrParams(), Bean.getDbCreateUser(), Bean.getDbCreatePwd());
				}
				dbExists = db.noErrors();
				if(dbExists)	{
					db.closeConnection();
				}
				else	{
					db.clearErrors();
				}
			}
			if( !dbExists || dropDb)	{
                db.closeConnection();
    			if (!Bean.getDatabase().startsWith("db2") && !Bean.getDatabase().startsWith("as400")) {
	    			db.setConnection(Bean.getDbDriver(), Bean.getDbCreateConStr(), Bean.getDbConStrParams(), Bean.getDbCreateUser(), Bean.getDbCreatePwd());
	    		}
			}
			else {
				if (createDb || createTables) {
					nextPage = "step_5_database_creation.jsp";
			  	}
			}
		}
	}
	boolean dbError = false;
	boolean enableContinue = false;
	if(!createDb && !createTables && dbExists)	{
		enableContinue = true;
	}

%><%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 创建数据库表
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized())	{ %>
<form action="<%= nextPage %>" method="post" class="nomargin">
<table border="0" cellpadding="5" cellspacing="0" style="width: 100%; height: 350px;">
<tr>
	<td style="vertical-align: middle;">
				<%
					if (!createDb && !createTables && !dbExists)	{
						enableContinue = true;
						%>
						<%= Bean.getHtmlPart("C_BLOCK_START", "创建数据库") %>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="resources/warning.png" border="0"></td>
								<td>&nbsp;&nbsp;</td>
								<td>你没有创建内容管理系统数据库。<br>
									没有数据库表将不能成功导入作业区！
								</td>
							</tr>
						</table>
						<%= Bean.getHtmlPart("C_BLOCK_END") %>
						<%
					}
					else {
						if (dbExists && createTables && !dropDb && db != null)	{
							db.closeConnection(); %>
							<%= Bean.getHtmlPart("C_BLOCK_START", "创建数据库") %>
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><img src="resources/warning.png" border="0"></td>
									<td>&nbsp;&nbsp;</td>
									<td>检测到存在一个数据库。删除它吗？</td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
									<td>
										<input type="submit" name="dropDb" class="dialogbutton" style="margin-left: 0;" value="是" onClick="this.value='Yes';">&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" value="否" onClick="location.href='step_3_database_selection.jsp';" class="dialogbutton">
									</td>
								</tr>
							</table>
							<%= Bean.getHtmlPart("C_BLOCK_END") %>
							<%
						}
						else	{
							if (createDb && dropDb && db != null)	{
								// Drop Database %>
								<%= Bean.getHtmlPart("C_BLOCK_START", "正在删除数据库 ...") %>
								<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
								
								<%
								db.closeConnection();
								db.setConnection(Bean.getDbDriver(), Bean.getDbWorkConStr(), Bean.getDbConStrParams(), Bean.getDbCreateUser(), Bean.getDbCreatePwd());
								db.dropDatabase(Bean.getDatabase(), Bean.getReplacer());
								if (db.noErrors())	{ %>
									<tr>
										<td><img src="resources/ok.png" border="0"></td>
										<td>&nbsp;&nbsp;</td>
										<td style="width: 100%;">成功删除数据库。</td>
									</tr>									
									<%
									enableContinue = true;
								} else {
									enableContinue = false;
									dbError = true;
								 %>
									<tr>
										<td><img src="resources/error.png" border="0"></td>
										<td>&nbsp;&nbsp;</td>
										<td style="width: 100%;">
											<div style="width: 100%; height:70px; overflow: auto;">
											<p style="margin-bottom: 4px;">无法删除数据库!</p>
											<%
											List<String> errors = db.getErrors();
											Iterator<String> it = errors.iterator();
											while (it.hasNext())	{
												out.println(it.next() + "<br>");
												out.println("-------------------------------------------" + "<br>");
											}
											db.clearErrors();
									 		%>
											</div>
										</td>
									</tr>				
								
									<%
						
								} %>
								</table>
								<%= Bean.getHtmlPart("C_BLOCK_END") %>
								<div class="dialogspacer" unselectable="on">&nbsp;</div>
								
								<%
							}

							if (createDb && db != null) {
								// Create Database %>
								<%= Bean.getHtmlPart("C_BLOCK_START", "正在创建数据库 ...") %>
								<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
								
								<%
								db.createDatabase(Bean.getDatabase(), Bean.getReplacer());
								if (db.noErrors())	{ %>
									<tr>
										<td><img src="resources/ok.png" border="0"></td>
										<td>&nbsp;&nbsp;</td>
										<td style="width: 100%;">成功创建数据库。</td>
									</tr>									
									<%
									enableContinue = true;
								} else { 
									enableContinue = false;
									dbError = true;
								%>
									<tr>
										<td><img src="resources/error.png" border="0"></td>
										<td>&nbsp;&nbsp;</td>
										<td style="width: 100%;">
											<div style="width: 100%; height:70px; overflow: auto;">
											<p style="margin-bottom: 4px;">无法创建数据库!</p>
											<%
											List<String> errors = db.getErrors();
											Iterator<String> it = errors.iterator();
											while (it.hasNext())	{
												out.println(it.next() + "<br>");
												out.println("-------------------------------------------" + "<br>");
											}
											db.clearErrors();
									 		%>
											</div>
										</td>
									</tr>				
									<%
								}
								%>
								</table>
								<%= Bean.getHtmlPart("C_BLOCK_END") %>
								<div class="dialogspacer" unselectable="on">&nbsp;</div>
								<%
							}
							if (db != null) {
								db.closeConnection();
							}
							if (createTables && db != null) {
								db.setConnection(Bean.getDbDriver(), Bean.getDbWorkConStr(), Bean.getDbConStrParams(), Bean.getDbWorkUser(),Bean.getDbWorkPwd());
								//Drop Tables (intentionally quiet)
								db.dropTables(Bean.getDatabase());
								db.clearErrors();
								db.closeConnection();

								// reopen the connection in order to display errors
								db.setConnection(Bean.getDbDriver(), Bean.getDbWorkConStr(), Bean.getDbConStrParams(), Bean.getDbWorkUser(),Bean.getDbWorkPwd());
				
								//Create Tables %>
								
								<%= Bean.getHtmlPart("C_BLOCK_START", "正在创建库表 ...") %>
								<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
								<%
								db.createTables(Bean.getDatabase(), Bean.getReplacer());
								if(db.noErrors())	{
									%>
									<tr>
										<td><img src="resources/ok.png" border="0"></td>
										<td>&nbsp;&nbsp;</td>
										<td style="width: 100%;">成功创建库表。</td>
									</tr>									
									<%
									enableContinue = true;
								}
								else	{ 
									enableContinue = false;
									dbError = true;
								%>
								
									<tr>
										<td><img src="resources/error.png" border="0"></td>
										<td>&nbsp;&nbsp;</td>
										<td style="width: 100%;">
											<div style="width: 100%; height:70px; overflow: auto;">
											<p style="margin-bottom: 4px;">无法创建库表!</p>
											<%
											List<String> errors = db.getErrors();
											Iterator<String> it = errors.iterator();
											while (it.hasNext())	{
												out.println(it.next() + "<br>");
												out.println("-------------------------------------------" + "<br>");
											}
											db.clearErrors();
											db.closeConnection();
									 		%>
											</div>
										</td>
									</tr>				
									<%
								}
								%>
								</table>
								<%= Bean.getHtmlPart("C_BLOCK_END") %>
								<%
							}
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
<% 
  if (db != null) {
     db.closeConnection();
  }
  if (enableContinue && !dbError)	{
	out.println("<script type=\"text/javascript\">\ndocument.getElementById(\"btcontinue\").disabled = false;\n</script>");
} %>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<% } else	{ %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>