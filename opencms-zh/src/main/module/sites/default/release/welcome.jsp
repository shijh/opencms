<%@ page session="false" taglibs="cms" import="org.opencms.jsp.*" %><%
CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
if (cms.getRequestContext().getLocale().getLanguage().startsWith("zh")) {
%>
<div>
<h1>祝贺你！</h1>

<h2>你成功安装了OpenCms。</h2>

<p>你安装的OpenCms版本是：<cms:info property="opencms.version" /><br>
<span class="small">运行环境是 
<cms:info property="java.vm.vendor" /> 
<cms:info property="java.vm.name" /> 
<cms:info property="java.vm.version" /> 
<cms:info property="java.vm.info" />，操作系统是
<cms:info property="os.name" /> 
<cms:info property="os.version" /> 
(<cms:info property="os.arch" />)</span></p>

<p>这是OpenCms的缺省首页。
你<em>不能</em>在本地文件系统中找到这个文件，它在OpenCms的
<em>虚拟文件系统</em>中，由所连接的数据库提供。
你能通过OpenCms作业区访问虚拟文件系统。</p>

<div class="high">
<p>要登录OpenCms作业区，请在浏览器中点击下面的网址：</p>
<p><a href="#" onclick="window.open('<cms:link>/system/login/</cms:link>');return false;"><cms:link>/system/login/</cms:link></a></p>
</div>

<div class="login">
你当前被认证为：<br>
用户：<tt><cms:user property="name" /></tt><br>
描述：<tt><cms:user property="description" /></tt>
</div>

<p>第一次登录时可以使用下面的账户：</p>
<p>
用户名：<tt>Admin</tt><br/>
密　码：<tt>admin</tt>
</p>

<p><strong>重要：</strong>你应该立刻修改这个缺省密码，以防他人这么做。</p>

</div>
<%
} else {
%>
<div>
<h1>Congratulations!</h1>

<h2>You have setup OpenCms successfully.</h2>

<p>Your installed OpenCms version is: <cms:info property="opencms.version" /><br>
<span class="small">Running on 
<cms:info property="java.vm.vendor" /> 
<cms:info property="java.vm.name" /> 
<cms:info property="java.vm.version" /> 
<cms:info property="java.vm.info" /> with
<cms:info property="os.name" /> 
<cms:info property="os.version" /> 
(<cms:info property="os.arch" />)</span></p>

<p>As you may have guessed by now, this is the default OpenCms home page. 
It can <em>not</em> be found on the local file system ;-) but in the OpenCms
<em>virtual file system</em> or VFS, which is served from the connected database.
You can access the VFS through the OpenCms workplace.</p>

<div class="high">
<p>To login to the OpenCms workplace, point your browser to the following URL:</p>
<p><a href="#" onclick="window.open('<cms:link>/system/login/</cms:link>');return false;"><cms:link>/system/login/</cms:link></a></p>
</div>

<div class="login">
You are currently identified as:<br>
User: <tt><cms:user property="name" /></tt><br>
Description: <tt><cms:user property="description" /></tt>
</div>

<p>Use the following account information for your first login:</p>
<p>
Username: <tt>Admin</tt><br/>
Password: <tt>admin</tt>
</p>

<p><strong>Important:</strong> You should change this default password immediately,
before someone else does it for you.</p>

</div>
<%
}
%>