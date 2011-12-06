<%@ page import="
                java.io.*,
                java.util.*,
                org.opencms.i18n.*,
                org.opencms.jsp.*,
                org.opencms.file.*,
                org.opencms.file.types.*,
                org.opencms.main.*,
                org.opencms.util.*,
                org.opencms.workplace.*
        " %><%! 

    public void createResourceWithParentFolders(CmsObject cms, String path, int typeId) throws CmsException {
        String resourcePath = "";
        String[] folders = path.split("/");
        String siteRoot = cms.getRequestContext().getSiteRoot();
        cms.getRequestContext().setSiteRoot("/");
        for (int i = 0; i < folders.length-1; i++) {
            resourcePath = resourcePath + folders[i] + '/';
            if (!cms.existsResource(resourcePath)) {
                CmsResource resource = cms.createResource(resourcePath, CmsResourceTypeFolder.getStaticTypeId());    
            }
        }
        cms.createResource(path, typeId);
        cms.writePropertyObject(path, new CmsProperty(CmsPropertyDefinition.PROPERTY_CONTENT_ENCODING, "ISO-8859-1", null));
        cms.getRequestContext().setSiteRoot(siteRoot);
    }

%><%
        // Create a JSP action element
        CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
        CmsDialog wp = CmsDialog.initCmsDialog(pageContext, request, response);
         
        // Check for template property
        String template = cms.property("template", "search", "undefined");
        HashMap map;        
        
        I_CmsMessageBundle[] bundles = A_CmsMessageBundle.getOpenCmsMessageBundles();
        List bundleNames = new ArrayList();
        for(int i = 0; i < bundles.length; i++) {
            bundleNames.add(bundles[i].getBundleName());
        }
        String[] additionalBundles = cms.property("target").split(",");
        if (additionalBundles != null) {
            for(int i = 0; i < additionalBundles.length; i++) {
                try {
                    // check, if bundle exists; if yes, add it to the select
                    String bundleName = ResourceBundle.getBundle(additionalBundles[i]).toString();
                    bundleNames.add(additionalBundles[i]);
                } catch (MissingResourceException e) {
                    // continue
                }
            }
        }
        Collections.sort(bundleNames);

        String localeString = cms.property("locale").trim();
        if (localeString == null) {
            throw new IllegalArgumentException("你必须指定这个JSP的locale属性");
        }
        // File name semi-constants
        String originalBundle = "org.opencms.workplace.messages";
        int originalBundleIndex = -1;
        if (CmsStringUtil.isNotEmpty(request.getParameter("originalBundle"))) {
            originalBundle = request.getParameter("originalBundle"); 
        }
        originalBundleIndex = bundleNames.indexOf(originalBundle);
        originalBundle = originalBundle.replaceAll("\\.","/");

        // Get the current file and folder name
        String translatedBundle = CmsWorkplace.VFS_PATH_WORKPLACE + "locales/" + localeString + "/messages/" + originalBundle + "_" + localeString + ".properties";


        if(!cms.getCmsObject().existsResource(translatedBundle)) {
            createResourceWithParentFolders(cms.getCmsObject(), translatedBundle, CmsResourceTypePlain.getStaticTypeId());
        } 

        originalBundle = originalBundle + ".properties";
        // Include template head                 
        //cms.include(template, "head");

        String[] localeFragments = localeString.split("_");
        Locale locale;
        switch (localeFragments.length) {
            case 1: locale = new Locale(localeFragments[0]); break;
            case 2: locale = new Locale(localeFragments[0], localeFragments[1]); break;
            case 3: locale = new Locale(localeFragments[0], localeFragments[1], localeFragments[2]); break;
            default: throw new IllegalArgumentException("You have set an illegal locale");
        }

%>

                

        您当前正在浏览的语言是：<%= locale.getDisplayName(new Locale("zh")) %> [<%= localeString %>]</i>.

        <form name="messagebundles">
        
        <table>
          <tr>
            <td style="padding-right:20px">
            <small>请在这里选择您要翻译的本地化文件：</small>
            </td>
            <td colspan="2">
              <%= CmsWorkplace.buildSelect("name=\"originalBundle\"", bundleNames, bundleNames, originalBundleIndex, false) %>
            </td>
            <td colspan="3" align="center">
              <input type="submit" value="ok"/>
            </td> 
          </tr>
        </table>
        </form>

        与这个本地化文件进行比较的翻译后的文件： </i><%= translatedBundle %><i>.
<%
        
     byte[] contents = "error".getBytes();
     try {
        CmsFile file = cms.getCmsObject().readFile(translatedBundle);
        contents = file.getContents();
        
                        
        // Get the current file and folder name
        ByteArrayInputStream inStream = new ByteArrayInputStream(contents);
        Properties newMessages = new Properties();
        newMessages.load(inStream);
        
        boolean combineMissing = "true".equals(request.getParameter("combine"));
        boolean hideMatching = "true".equals(request.getParameter("hideMatching"));
        boolean hideMissing = "true".equals(request.getParameter("hideMissing"));        
        boolean hideNew = "true".equals(request.getParameter("hideNew"));

        // Now get a CmsMessages object with all keys from the workplace:        
        Properties originalMessages = new Properties();

        originalMessages.load(getClass().getClassLoader().getResourceAsStream(originalBundle));
    
        String[] magicKeys = { "version", "name", "content-encoding" };
        List magicKeyList = Arrays.asList(magicKeys);
                           
        Enumeration keys;
    
        keys = newMessages.keys();
        List newList = new ArrayList();
        while (keys.hasMoreElements()) {                
                String key = (String)keys.nextElement();
                if (magicKeyList.indexOf(key) < 0) newList.add(key);
                String value = ((String)newMessages.get(key)).replaceAll("\n","\\n");
                String spaces = "";
                while(value.startsWith(" ")) {
                        value = value.substring(1);
                        spaces += "_";
                }
                value = spaces + value;
                spaces = "";
                while(value.endsWith(" ")) {
                        value = value.substring(0, value.length()-1);
                        spaces += "_";
                }
                value += spaces;
                newMessages.put(key, value); 
        }

        keys = originalMessages.keys();
        List originalList = new ArrayList();
        while (keys.hasMoreElements()) {                
                String key = (String)keys.nextElement();
                if (magicKeyList.indexOf(key) < 0) originalList.add(key);
                String value = ((String)originalMessages.get(key)).replaceAll("\n","\\n");
                String spaces = "";
                while(value.startsWith(" ")) {
                        value= value.substring(1);
                        spaces += "_";
                }
                value = spaces + value;
                spaces = "";
                while(value.endsWith(" ")) {
                        value = value.substring(0, value.length()-1);
                        spaces += "_";
                }
                value += spaces;
                originalMessages.put(key, value);
        }
        Collections.sort(originalList);        
        Collections.sort(newList);        
        
        List missingKeys = new ArrayList();
        List matchingKeys = new ArrayList();
        List unnecessaryKeys = new ArrayList();
        
        Iterator i;
        
        i = originalList.iterator();
        while (i.hasNext()) {
                String key = (String)i.next();
                int index = newList.indexOf(key);
                if (index < 0) {
                        missingKeys.add(key);
                } else {
                        if (! "".equals(((String)newMessages.get(key)).trim())) {
                                matchingKeys.add(key);
                        } else {
                                missingKeys.add(key);
                        }
                }
        }
        i = newList.iterator();
        while (i.hasNext()) {
                String key = (String)i.next();
                int index = matchingKeys.indexOf(key);
                if (index < 0) {
                        if (! "".equals(((String)newMessages.get(key)).trim())) {
                                unnecessaryKeys.add(key);
                        }        
                }
        }        
                
%>

<% if (matchingKeys.size() > 0) { %>

<h4>能够匹配的键:
<%
if (hideMatching) {
%><a href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=false&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>" >[显示]</a><%
} else {
%><a href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=true&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>">[隐藏]</a><%
}
%></h4>
<% if (! hideMatching) {%>
<dl>
<%        
        i = matchingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%>
<dt style="color:#006600"><%= key %></dt>
<dd style="color:#660000"><%= CmsEncoder.escapeHtml((String)originalMessages.get(key)) %> &nbsp;</dd>
<dd style="color:#000066"><%= new String(((String)newMessages.get(key)).getBytes("ISO-8859-1"),"UTF-8") %> &nbsp;</dd>
<%        } %>
</dl>
<% } %>
<% } %>
<% if (unnecessaryKeys.size() > 0) { %>

<h4>不必要的键(多余的):</h4>
<dl><%                
        i = unnecessaryKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%>
<dt style="color:#006600"><%= key %></dt>
<dd style="color:#000066"><%= new String(((String)newMessages.get(key)).getBytes("ISO-8859-1"),"UTF-8")  %></dd>
<%        } %>
</dl>

<% } else { %>
<h4>没有不必要的键！</h4>
<p>
很好。
</p>
<% } %>
<% if (missingKeys.size() > 0) { %>

<h4>缺失的键:
<%
if (hideMissing) {
        %><a href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=false" >[显示]</a></h4><%
} else {
%><a href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=true">[隐藏]</a><%
        if (combineMissing) {
                %><a href="localizationtool.jsp?combine=false&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>">[分列显示]</a><%

        } else {
                %><a href="localizationtool.jsp?combine=true&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>">[合并显示]</a><%
        }
%></h4>
<table><tr><td>
<pre style="background-color:#e6ffe6;border:solid;border-width:1px;padding:15px"><%                
        i = missingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
                %><%= key %>=<% 
                if (combineMissing) {
                        out.println(CmsEncoder.escapeHtml((String)originalMessages.get(key)));
                } else { 
                        out.println(); 
                } 
        } %></pre>
</td><td>
<% if (! combineMissing) { %>
<pre style="background-color:#ffe6e6;border:solid;border-width:1px;padding:15px"><%                
        i = missingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%><%= CmsEncoder.escapeHtml((String)originalMessages.get(key)) %>
<% } %></pre>
<% } %>
</td></tr></table>

<% 
        } 
} else { %>

<h4>没有缺失的键!</h4>
<p>
非常好,这意味着所有的键都已经被翻译了。
</p>

<% } %>

<% if (matchingKeys.size() > 0) { %>

<h4>新的键: <%
if (hideNew) {
%><a href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=false&hideMissing=<%= hideMissing %>" >[显示]</a><%
} else {
%><a href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=true&hideMissing=<%= hideMissing %>">[隐藏]</a><%
}
%></h4>
<% if (! hideNew) { %>
<pre style="background-color:#eeeeee;border:solid;border-width:1px;padding:15px"><%                
        i = magicKeyList.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%><%= key %>=<%= new String(((String)newMessages.get(key)).getBytes("ISO-8859-1"),"UTF-8")  %>
<%        } %>
<%                
        i = matchingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%><%= key %>=<%= new String(((String)newMessages.get(key)).getBytes("ISO-8859-1"),"UTF-8")  %>
<%        } %></pre>

<% } %>

<% } %>

<%       

        } catch (Exception e) {
                 out.println("<h3>" + e.getMessage() + "</h3>");
        } 
        // Include template foot
        //cms.include(template, "foot");                
%>