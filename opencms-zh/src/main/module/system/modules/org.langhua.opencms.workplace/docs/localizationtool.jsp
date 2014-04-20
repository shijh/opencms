<%@ page import="java.io.*,
                 java.util.*,
	             org.opencms.i18n.*,
	             org.opencms.jsp.*,
	             org.opencms.file.*,
	             org.opencms.file.types.*,
	             org.opencms.main.*,
	             org.opencms.util.*,
	             org.opencms.gwt.*,
	             org.opencms.workplace.*"%><%!
	
	public void createResourceWithParentFolders(CmsObject cms, String path,
			int typeId) throws CmsException {
		String resourcePath = "";
		String[] folders = path.split("/");
		String siteRoot = cms.getRequestContext().getSiteRoot();
		cms.getRequestContext().setSiteRoot("/");
		for (int i = 0; i < folders.length - 1; i++) {
			resourcePath = resourcePath + folders[i] + '/';
			if (!cms.existsResource(resourcePath)) {
				CmsResource resource = cms.createResource(resourcePath,
						CmsResourceTypeFolder.getStaticTypeId());
			}
		}
		cms.createResource(path, typeId);
		cms.writePropertyObject(path, new CmsProperty(
				CmsPropertyDefinition.PROPERTY_CONTENT_ENCODING, "UTF-8", null));
		cms.getRequestContext().setSiteRoot(siteRoot);
	}

	public static List<String> collectI18nXmlMessages(CmsObject cms, JspWriter out) {
		Locale locale = new Locale("en");
		// create a new list and add the base bundle
		ArrayList<String> result = new ArrayList<String>();

        try {
            int xmlType = OpenCms.getResourceManager().getResourceType(CmsVfsBundleManager.TYPE_XML_BUNDLE).getTypeId();
            List<CmsResource> xmlBundles = cms.readResources("/", CmsResourceFilter.ALL.addRequireType(xmlType), true);
            for (CmsResource xmlBundle : xmlBundles) {
            	if (!result.contains(xmlBundle.getName())) result.add(xmlBundle.getName());
            }
        } catch (Exception e) {
        	try {
        		out.println("<h3>" + e.getMessage() + "</h3>");
        	} catch (Exception e1) {
        		// do nothing
        	}
        }

		Collections.sort(result);
		return result;
	}

	public static List<String> collectAlkaconModuleMessages(List<String> i18nBundleNames) {
		Locale locale = new Locale("en");
		// create a new list and add the base bundle
		ArrayList<String> result = new ArrayList<String>();

		//////////// iterate over all registered modules ////////////////        
		Set<String> names = OpenCms.getModuleManager().getModuleNames();
		if (names != null) {
			// iterate all module names
			Iterator<String> i = names.iterator();
			while (i.hasNext()) {
				String modName = i.next();
				if (!modName.startsWith("com.alkacon."))
					continue;
				//////////// collect the workplace.properties ////////////////
				// this should result in a name like "my.module.name.workplace"
				String bundleName = modName
						+ CmsWorkplaceMessages.PREFIX_BUNDLE_WORKPLACE;
				// try to load a bundle with the module names
				CmsMessages msg = new CmsMessages(bundleName, locale);
				// bundle was loaded, add to list of bundles
				if (!i18nBundleNames.contains(bundleName) && msg.isInitialized()
						&& msg.getResourceBundle().keySet().size() > 0) {
					result.add(bundleName);
				}
				//////////// collect the messages.properties ////////////////
				// this should result in a name like "my.module.name.messages"
				bundleName = modName
						+ CmsWorkplaceMessages.PREFIX_BUNDLE_MESSAGES;
				// try to load a bundle with the module names
				msg = new CmsMessages(bundleName, locale);
				// bundle was loaded, add to list of bundles
				if (!i18nBundleNames.contains(bundleName) && msg.isInitialized()
						&& msg.getResourceBundle().keySet().size() > 0) {
					result.add(bundleName);
				}
			}
		}

		Collections.sort(result);
		return result;
	}

	public static List<String> collectOpenCmsModuleMessages(List<String> bundleMessages) {
		Locale locale = new Locale("en");
		// create a new list and add the base bundle
		ArrayList<String> result = new ArrayList<String>();

		//////////// iterate over all registered modules ////////////////        
		Set<String> names = OpenCms.getModuleManager().getModuleNames();
		if (names != null) {
			// iterate all module names
			Iterator<String> i = names.iterator();
			while (i.hasNext()) {
				String modName = i.next();
				if (!modName.startsWith("org.opencms."))
					continue;
				//////////// collect the workplace.properties ////////////////
				// this should result in a name like "my.module.name.workplace"
				String bundleName = modName
						+ CmsWorkplaceMessages.PREFIX_BUNDLE_WORKPLACE;
				if (bundleMessages.contains(bundleName)) continue;
				// try to load a bundle with the module names
				CmsMessages msg = new CmsMessages(bundleName, locale);
				// bundle was loaded, add to list of bundles
				if (msg.isInitialized()
						&& msg.getResourceBundle().keySet().size() > 0) {
					result.add(bundleName);
				}
				//////////// collect the messages.properties ////////////////
				// this should result in a name like "my.module.name.messages"
				bundleName = modName
						+ CmsWorkplaceMessages.PREFIX_BUNDLE_MESSAGES;
				if (bundleMessages.contains(bundleName)) continue;
				// try to load a bundle with the module names
				msg = new CmsMessages(bundleName, locale);
				// bundle was loaded, add to list of bundles
				if (msg.isInitialized()
						&& msg.getResourceBundle().keySet().size() > 0) {
					result.add(bundleName);
				}
			}
		}

		Collections.sort(result);
		return result;
	}

	public static List<String> collectClientMessages() {
        String[] clientBundles = new String[] {
                "org.opencms.ade.containerpage.clientmessages",
                "org.opencms.ade.contenteditor.clientmessages",
                "org.opencms.ade.galleries.clientmessages",
                "org.opencms.ade.postupload.clientmessages",
                "org.opencms.ade.publish.clientmessages",
                "org.opencms.ade.sitemap.clientmessages",
                "org.opencms.ade.upload.clientmessages",
                "org.opencms.gwt.clientmessages",
                "org.opencms.gwt.seo.clientmessages"
        };
		Locale locale = new Locale("en");
		// create a new list and add the base bundle
		ArrayList<String> result = new ArrayList<String>();

		for (String clientBundle : clientBundles) {
			CmsMessages msg = new CmsMessages(clientBundle, locale);
			// bundle was loaded, add to list of bundles
			if (msg.isInitialized()
					&& msg.getResourceBundle().keySet().size() > 0) {
				result.add(clientBundle);
			}
		}

		Collections.sort(result);
		return result;
	}
	
	public static List<String> collectServerMessages(CmsJspActionElement cms) {
        I_CmsMessageBundle[] bundles = A_CmsMessageBundle.getOpenCmsMessageBundles();
		ArrayList<String> result = new ArrayList<String>();
        for(int i = 0; i < bundles.length; i++) {
            result.add(bundles[i].getBundleName());
        }
        
        Collections.sort(result);
        return result;
	}
	
	public static List<String> collectAdditionalMessages(List<String> bundleMessages) {
		// all class folders under src-modules
        String[] clientBundles = new String[] {
                "org.opencms.editors.ckeditor",
                "org.opencms.editors.editarea",
                "org.opencms.editors.fckeditor",
                "org.opencms.workplace.administration",
                "org.opencms.workplace.tools.accounts",
                "org.opencms.workplace.tools.cache",
                "org.opencms.workplace.tools.content",
                "org.opencms.workplace.tools.content.check",
                "org.opencms.workplace.tools.content.convertxml",
                "org.opencms.workplace.tools.content.languagecopy",
                "org.opencms.workplace.tools.content.propertyviewer",
                "org.opencms.workplace.tools.content.updatexml",
                "org.opencms.workplace.tools.database",
                "org.opencms.workplace.tools.galleryoverview",
                "org.opencms.workplace.tools.history",
                "org.opencms.workplace.tools.link",
                "org.opencms.workplace.tools.modules",
                "org.opencms.workplace.tools.projects",
                "org.opencms.workplace.tools.publishqueue",
                "org.opencms.workplace.tools.scheduler",
                "org.opencms.workplace.tools.searchindex",
                "org.opencms.workplace.tools.searchindex.sourcesearch",
                "org.opencms.workplace.tools.workplace",
                "org.opencms.workplace.tools.workplace.broadcast",
                "org.opencms.workplace.tools.workplace.rfsfile"
        };
		Locale locale = new Locale("en");
		// create a new list and add the base bundle
		ArrayList<String> result = new ArrayList<String>();

		for (String modName : clientBundles) {
			//////////// collect the workplace.properties ////////////////
			// this should result in a name like "my.module.name.workplace"
			String bundleName = modName
					+ CmsWorkplaceMessages.PREFIX_BUNDLE_WORKPLACE;
			if (bundleMessages.contains(bundleName)) continue;
			// try to load a bundle with the module names
			CmsMessages msg = new CmsMessages(bundleName, locale);
			// bundle was loaded, add to list of bundles
			if (msg.isInitialized()
					&& msg.getResourceBundle().keySet().size() > 0) {
				result.add(bundleName);
			}
			//////////// collect the messages.properties ////////////////
			// this should result in a name like "my.module.name.messages"
			bundleName = modName
					+ CmsWorkplaceMessages.PREFIX_BUNDLE_MESSAGES;
			if (bundleMessages.contains(bundleName)) continue;
			// try to load a bundle with the module names
			msg = new CmsMessages(bundleName, locale);
			// bundle was loaded, add to list of bundles
			if (msg.isInitialized()
					&& msg.getResourceBundle().keySet().size() > 0) {
				result.add(bundleName);
			}
		}

		Collections.sort(result);
		return result;
	}	
%><%
        // Create a JSP action element
        CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
        CmsDialog wp = CmsDialog.initCmsDialog(pageContext, request, response);
         
        // Check for template property
        String template = cms.property("template", "search", "undefined");
        
        // OpenCms server side Messages
        List<String> bundleNames = new ArrayList<String>();
        bundleNames.addAll(collectServerMessages(cms));
        
        // OpenCms modules' Messages
        bundleNames.add("");
        bundleNames.addAll(collectOpenCmsModuleMessages(bundleNames));
        
        // OpenCms client side Messages
        bundleNames.add("");
        bundleNames.addAll(collectClientMessages());
        
        // OpenCms i18n XML Messages
        bundleNames.add("");
        List<String> i18nBundleNames = collectI18nXmlMessages(cms.getCmsObject(), out);
        bundleNames.addAll(i18nBundleNames);

        // Alkacon Modules' Messages
        bundleNames.add("");
        bundleNames.addAll(collectAlkaconModuleMessages(i18nBundleNames));
        
        // Additional Modules' Messages
        bundleNames.add("");
        bundleNames.addAll(collectAdditionalMessages(bundleNames));
        
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
        String selectedBundle = originalBundle;
        originalBundleIndex = bundleNames.indexOf(originalBundle);
        originalBundle = originalBundle.replaceAll("\\.","/");

        // Get the current file and folder name
        String translatedBundle = CmsWorkplace.VFS_PATH_WORKPLACE + "locales/" + localeString + "/messages/" + originalBundle + "_" + localeString + ".properties";
        if (i18nBundleNames.contains(selectedBundle)) {
        	translatedBundle = "/system/modules/org.langhua.opencms.workplace/i18n/" + selectedBundle;
        }


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
            default: throw new IllegalArgumentException("你设置了一个不合规范的语言");
        }

%>



您当前正在浏览的语言是：<%= locale.getDisplayName(new Locale("zh")) %>
<i>
[<%= localeString %>]
</i>。

<form name="messagebundles">

	<table>
		<tr>
			<td style="padding-right: 20px"><small>请在这里选择您要翻译的本地化文件：</small>
			</td>
			<td colspan="2"><%= CmsWorkplace.buildSelect("name=\"originalBundle\"", bundleNames, bundleNames, originalBundleIndex, false) %>
			</td>
			<td colspan="3" align="center"><input type="submit" value="确定" />
			</td>
		</tr>
	</table>
</form>

与这个本地化文件进行比较的翻译后的文件：
<i><%= translatedBundle %></i>。 <%
        
     byte[] contents = "error".getBytes();
     try {
        CmsFile file = cms.getCmsObject().readFile(translatedBundle);
        contents = file.getContents();
        
        ByteArrayInputStream inStream = new ByteArrayInputStream(contents);
        Properties newMessages = new Properties();
        newMessages.load(inStream);
%>
	<h4><%= translatedBundle %>有<%= newMessages.keySet().size() %>个键</h4>
<%        
        boolean combineMissing = !"false".equals(request.getParameter("combine"));
        boolean hideMatching = "true".equals(request.getParameter("hideMatching"));
        boolean hideMissing = "true".equals(request.getParameter("hideMissing"));        
        boolean hideNew = "true".equals(request.getParameter("hideNew"));

        // Now get a CmsMessages object with all keys from the workplace:        
        String[] magicKeys = { "version", "name", "content-encoding" };
        List<String> magicKeyList = Arrays.asList(magicKeys);
                           
        Enumeration<? extends Object> keys;
    
        keys = newMessages.keys();
        List<String> newList = new ArrayList<String>();
        while (keys.hasMoreElements()) {                
                String key = (String)keys.nextElement();
                if (magicKeyList.indexOf(key) < 0) newList.add(key);
                String value = (newMessages.getProperty(key)).replaceAll("\n","\\n");
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

        Properties originalMessages = new Properties();
        ResourceBundle originalResourceBundle = null;
        try {
            originalMessages.load(getClass().getClassLoader().getResourceAsStream(originalBundle));
            keys = originalMessages.keys();
        } catch (Exception e) {
			CmsMessages msg = new CmsMessages(selectedBundle, new Locale("en"));
			originalResourceBundle = msg.getResourceBundle();
            keys = originalResourceBundle.getKeys();
        }
    	
        List<String> originalList = new ArrayList<String>();
        while (keys.hasMoreElements()) {
                String key = (String)keys.nextElement();
                if (magicKeyList.indexOf(key) < 0) originalList.add(key);
                String value = originalResourceBundle != null ? originalResourceBundle.getString(key).replaceAll("\n","\\n") : ((String) originalMessages.get(key)).replaceAll("\n","\\n");
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
        
        Set<String> missingKeys = new HashSet<String>();
        List<String> matchingKeys = new ArrayList<String>();
        List<String> unnecessaryKeys = new ArrayList<String>();
        
        Iterator<String> i;
        
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
                
%> <% if (matchingKeys.size() > 0) { %>

	<h4>
		能够匹配的键:
		<%
if (hideMatching) {
%><a
			href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=false&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>&originalBundle=<%= selectedBundle %>">[显示]</a>
		<%
} else {
%><a
			href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=true&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>&originalBundle=<%= selectedBundle %>">[隐藏]</a>
		<%
}
%>
	</h4> <% if (! hideMatching) {%>
	<dl>
		<%        
        i = matchingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%>
		<dt style="color: #006600"><%= key %></dt>
		<dd style="color: #660000"><%= CmsEncoder.escapeHtml((String)originalMessages.get(key)) %>
			&nbsp;
		</dd>
		<dd style="color: #000066"><%= new String(((String)newMessages.get(key)).getBytes("ISO-8859-1"),"UTF-8") %>
			&nbsp;
		</dd>
		<%        } %>
	</dl> <% } %> <% } %> <% if (unnecessaryKeys.size() > 0) { %>

	<h4>不必要的键(多余的):</h4>
	<dl>
		<%                
        i = unnecessaryKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%>
		<dt style="color: #006600"><%= key %></dt>
		<dd style="color: #000066"><%= new String(((String)newMessages.get(key)).getBytes("ISO-8859-1"),"UTF-8")  %></dd>
		<%        } %>
	</dl> <% } else { %>
	<h4>没有不必要的键！</h4>
	<p>很好。</p> <% } %> <% if (missingKeys.size() > 0) { %>

	<h4>
		缺失的键:
		<%
if (hideMissing) {
        %><a
			href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=false&originalBundle=<%= selectedBundle %>">[显示]</a>
	</h4> <%
} else {
%><a
	href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=true&originalBundle=<%= selectedBundle %>">[隐藏]</a>
	<%
        if (combineMissing) {
                %><a
	href="localizationtool.jsp?combine=false&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>&originalBundle=<%= selectedBundle %>">[分列显示]</a>
	<%

        } else {
                %><a
	href="localizationtool.jsp?combine=true&hideMatching=<%= hideMatching %>&hideNew=<%= hideNew %>&hideMissing=<%= hideMissing %>&originalBundle=<%= selectedBundle %>">[合并显示]</a>
	<%
        }
%></h4>
	<table>
		<tr>
			<td><pre
					style="background-color: #e6ffe6; border: solid; border-width: 1px; padding: 15px">
<%                
        i = missingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
                %><%= key %>=<% 
                if (combineMissing) {
                        out.println(CmsEncoder.escapeHtml((String)originalMessages.get(key)));
                } else { 
                        out.println(); 
                } 
        } %>
				</pre>
			</td>
			<td>
				<% if (! combineMissing) { %> <pre
					style="background-color: #ffe6e6; border: solid; border-width: 1px; padding: 15px">
<%                
        i = missingKeys.iterator();        
        while (i.hasNext()) {
                String key = (String)i.next();
%><%= CmsEncoder.escapeHtml((String)originalMessages.get(key)) %>
<% } %>
				</pre> <% } %>
			</td>
		</tr>
	</table> <% 
        } 
} else { %>

	<h4>没有缺失的键!</h4>
	<p>非常好,这意味着所有的键都已经被翻译了。</p> <% } %> <% if (matchingKeys.size() > 0) { %>

	<h4>
		新的键:
		<%
if (hideNew) {
%><a
			href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=false&hideMissing=<%= hideMissing %>&originalBundle=<%= selectedBundle %>">[显示]</a>
		<%
} else {
%><a
			href="localizationtool.jsp?combine=<%= combineMissing %>&hideMatching=<%= hideMatching %>&hideNew=true&hideMissing=<%= hideMissing %>&originalBundle=<%= selectedBundle %>">[隐藏]</a>
		<%
}
%>
	</h4> <% if (! hideNew) { %> <pre
		style="background-color: #eeeeee; border: solid; border-width: 1px; padding: 15px">
<%                
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
<%        } %>
	</pre> <% } %> <% } %> <%       

        } catch (Exception e) {
                 out.println("<h3>" + e.getMessage() + "</h3>");
        } 
        // Include template foot
        //cms.include(template, "foot");                
%>