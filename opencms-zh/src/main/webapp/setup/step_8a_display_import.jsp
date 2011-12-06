<%@ page session="true" pageEncoding="utf-8" %><%--
--%><jsp:useBean id="Bean" class="org.opencms.setup.CmsSetupBean" scope="session" /><%--
--%><jsp:setProperty name="Bean" property="*" /><%

	// next page to be accessed
	String nextPage = "step_9_browser_configuration_notes.jsp";
	// previous page in the setup process 
	String prevPage = "index.jsp";

%>
<%= Bean.getHtmlPart("C_HTML_START") %>
内容管理系统安装程序 - 导入模块
<%= Bean.getHtmlPart("C_HEAD_START") %>
	<script type="text/javascript">

		var enabled = false;
		var finished = false;
		var animation;
		var message = "正在导入模块 ... 请稍等";
		var countchar = 0;

		// indicates if the document has been loaded 
		function enable() {
			enabled = true;
			parent.data.location.href="step_8b_data_import.jsp";
			replaceInfo(message, "wait.gif");
		}

		// displays the given output 
		function start(out) {
			if (enabled) {
				document.forms[0].ctn.disabled = true;
				document.forms[0].bck.disabled = true;
				
				temp = "";
				for(var i=out.length-1; i>=0; i--) {
					// modified by Shi Yusen, shiys@langhua.cn
					temp += decodeURIComponent(out[i])+"\n";
					// temp += unescape(out[i])+"\n";
				}
				
				var pageBody = temp + document.forms[0].output.value;				
				var size = 163840;		
				if (pageBody.length > size) {
					pageBody = pageBody.substring(0, size);
				}
			    
				document.forms[0].output.value = pageBody;
			}
		}

		// displays a message and enables the continue button
		function finish() {
			replaceInfo("已完成。请检查输出内容，检查导入模块时是否发生错误。", "ok.png");
			document.forms[0].ctn.disabled = false;
			document.forms[0].bck.disabled = true;
			finished = true;
		}

		// if finished, you can access next page 
		function nextpage() {
			if (finished) {
				top.location.href="<%= nextPage %>";
			}
		}

		// if finished, you can go back 
		function lastpage() {
			if (finished) {
				top.location.href="<%= prevPage %>";
			}
		}

		// replaces info message 
		function replaceInfo(msgString, imgSrc) {
			var el = document.getElementById("statustxt");
			var newTextNode = document.createTextNode(msgString);
			el.replaceChild(newTextNode, el.firstChild);
			el = document.getElementById("statusimg");
			el.src = "resources/" + imgSrc;
		}

	</script>
<%= Bean.getHtmlPart("C_STYLES") %>
<%= Bean.getHtmlPart("C_STYLES_SETUP") %>
<%= Bean.getHtmlPart("C_HEAD_END") %>
内容管理系统安装程序 - 导入模块
<%= Bean.getHtmlPart("C_CONTENT_SETUP_START") %>

<% if (Bean.isInitialized()) { %>
<form action="<%= nextPage %>" method="post" class="nomargin">
<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
<tr>
	<td style="vertical-align: middle;">
		<%= Bean.getHtmlPart("C_BLOCK_START", "状态") %>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="resources/wait.gif" border="0" id="statusimg"></td>
				<td>&nbsp;&nbsp;</td>
				<td>
					<span id="statustxt">正在导入模块 ... 请稍等</span>
				</td>
			</tr>
		</table>
		<%= Bean.getHtmlPart("C_BLOCK_END") %>
		<div class="dialogspacer" unselectable="on">&nbsp;</div>
	</td>
</tr>
<tr>
	<td style="vertical-align: top;">
			<textarea style="width:99%; height:260px; font-size: 11px;" cols="60" rows="16" wrap="off" name="output" id="output"></textarea>
	</td>
</tr>
</table>
<%= Bean.getHtmlPart("C_CONTENT_END") %>

<%= Bean.getHtmlPart("C_BUTTONS_START") %>
<input name="bck" id="bck" type="button" value="&#060;&#060; 后退" class="dialogbutton" onclick="lastpage();">
<input name="ctn" id="ctn" type="button" value="继续 &#062;&#062;" class="dialogbutton" onclick="nextpage();">
<input name="cancel" type="button" value="取消" class="dialogbutton" onclick="top.document.location.href='index.jsp';" style="margin-left: 50px;">
</form>
<%= Bean.getHtmlPart("C_BUTTONS_END") %>
<script type="text/javascript">
	enable();
</script>
<% } else { %>
<%= Bean.displayError("")%>
<%= Bean.getHtmlPart("C_CONTENT_END") %>
<% } %>
<%= Bean.getHtmlPart("C_HTML_END") %>
