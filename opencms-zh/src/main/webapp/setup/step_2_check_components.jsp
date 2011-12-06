<%@ page import="java.util.*" session="true" pageEncoding="utf-8"%><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page
	String nextPage = "step_3_database_selection.jsp";	
	// previous page
	String prevPage = "index.jsp";

	boolean isSubmitted = (request.getParameter("systemInfo") != null);
	boolean hasSystemInfo = (request.getParameter("systemInfo") != null) && (request.getParameter("systemInfo").equals("false"));
	boolean hasUserAccepted = (request.getParameter("accept") != null) && (request.getParameter("accept").equals("true"));

	String descriptions = "";
	org.opencms.setup.comptest.CmsSetupTests setupTests = null;
	org.opencms.setup.comptest.CmsSetupTestResult testResult = null;
	String resultIcon = null;
	String helpIcon = null;
	String violatedConditions = "";
	String questionableConditions = "";

	if (Bean.isInitialized()) {
		if(!isSubmitted) {
			setupTests = new org.opencms.setup.comptest.CmsSetupTests();
			setupTests.runTests(Bean);
		} else {
			response.sendRedirect(nextPage);
		}
	}
%>
<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序 - 组件测试
<%= Bean.getHtmlPart("C_HEAD_START") %>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_SCRIPT_HELP") %>
<script type="text/javascript" language="JavaScript">
<!--

function toggleContinueButton() {
	var form = document.components;	
	form.submit.disabled = !form.accept.checked;
}

//-->
</script>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 组件测试
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>
<% if (Bean.isInitialized()) { %>
<form action="<%= nextPage %>" method="post" class="nomargin" name="components">
<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 350px;">
<tr>
	<td style="vertical-align: top; height: 100%;">
<%  
	if (isSubmitted) {
		if (hasSystemInfo && !hasUserAccepted) {
			out.print("<b>要继续内容管理系统的安装，你必须清楚内容管理系统可能无法在你的系统上工作!");
		}
	} else { 	
%>	
		
		<%= Bean.getHtmlPart("C_BLOCK_START", "验证组件") %>	
		<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;"><tr><td>
		<div style="width: 100%; height:130px; overflow: auto;">
		<table border="0" cellpadding="2">
		
<%
		List testResults = setupTests.getTestResults();
		for (int i=0;i<testResults.size();i++) {
			testResult = (org.opencms.setup.comptest.CmsSetupTestResult) testResults.get(i);
			
			if (testResult.isRed()) {
				resultIcon = "cross";
				violatedConditions += "<p>" + testResult.getInfo() + "</p>";
			} else if (testResult.isYellow()) {
				resultIcon = "unknown";
				questionableConditions += "<p>" + testResult.getInfo() + "</p>";
			} else if (testResult.isGreen() && (testResult.getInfo() != null) && !"".equals(testResult.getInfo())) {
				questionableConditions += "<p>" + testResult.getInfo() + "</p>";
				resultIcon = "check";
			} else {
				resultIcon = "check";
			}
					
			if (!testResult.isGreen() && (testResult.getHelp() != null) && !"".equals(testResult.getHelp())) {
				descriptions += Bean.getHtmlPart("C_HELP_START", "" + i) + testResult.getHelp() + Bean.getHtmlPart("C_HELP_END");
				helpIcon = Bean.getHtmlHelpIcon("" + i, "");
			} else {
				helpIcon = "";
			}
			
%>
			<tr>
				<td style="text-align: left; white-space: nowrap;"><%= testResult.getName() %>:</td>
				<td style="text-align: left; font-weight:bold; width: 100%;"><%= testResult.getResult() %></td>
				<td style="text-align: right; width: 40px; height: 16px; white-space: nowrap;"><%= helpIcon %>&nbsp;<img src="resources/<%= resultIcon %>.png" border="0"></td>
			</tr>
<%
		}	
%>
		</table>
		</div>
		</td></tr></table>
		<%= Bean.getHtmlPart("C_BLOCK_END") %>
		
		<div class="dialogspacer" unselectable="on">&nbsp;</div>
		
		<div style="width: 100%; height:120px; overflow: auto;">
		<table border="0" cellpadding="5" cellspacing="0">
			<tr><td align="center" valign="top">
			<%
				if(setupTests.isRed()) {
					out.print("<img src='resources/error.png'>");
				} else if (setupTests.isYellow()) {
					out.print("<img src='resources/warning.png'>");
				} else {
					out.print("<img src='resources/ok.png'>");
				}
			%>
			</td>
			<td colspan="2" valign="middle">
			<%
				if (setupTests.isRed()) {
					out.println("<p>Y你的系统没有内容管理系统所需的组件。可以假设内容管理系统不能在你的系统上运行。</p>");
					out.println(violatedConditions);
				} else if (setupTests.isYellow()) {
					out.print("你的系统使用的组件没有与内容管理系统一起测试过。可能内容管理系统无法在你的系统上运行。");
					out.println(questionableConditions);
				} else {
					out.print("<b>你的系统使用的组件经测试能够运行内容管理系统。</b>");
					if (!"".equals(questionableConditions)) {
					    out.print(" <b>但是，请务必检查下列各点：</b>");					    
						out.println(questionableConditions);
					}
				}
			%></td>
			</tr>
		</table>
		</div>
		
		<div class="dialogspacer" unselectable="on">&nbsp;</div>
		
		<table border="0" cellpadding="2" cellspacing="0">
			<% if (!setupTests.isGreen()) { 
			    // show table
			%>
				<tr><td>
				<table border="0"><tr>
					<td style="vertical-align: top;"><input type="checkbox" name="accept" value="true" onClick="toggleContinueButton()"> </td>
					<td style="padding-top: 5px;">我知道我的系统没有内容管理系统所需的组件。继续安装。</td>
				</tr></table>
				</td></tr>
			<% } %>
		</table>
			
		<input type="hidden" name="systemInfo" value="<%= setupTests.isGreen() %>">
		<% } %>
	</td>
</tr>
</table>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="back" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="location.href='<%= prevPage %>';">
<%
String disabled = "";
if (!setupTests.isGreen() && !hasUserAccepted) {
	disabled = " disabled=\"disabled\"";
}
%>
<input name="submit" type="submit" value="继续 &#062;&#062;" class="dialogbutton"<%= disabled %>>
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="location.href='index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>

<%= descriptions %>

<% } else	{ %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>