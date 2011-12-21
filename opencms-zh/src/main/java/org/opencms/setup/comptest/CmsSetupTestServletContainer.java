/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software GmbH, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.setup.comptest;

import org.opencms.setup.CmsSetupBean;

/**
 * Tests the servlet container.<p>
 * 
 * @since 6.1.8 
 */
public class CmsSetupTestServletContainer implements I_CmsSetupTest {

    /** The test name. */
    public static final String TEST_NAME = "Servlet容器";

    /**
     * @see org.opencms.setup.comptest.I_CmsSetupTest#execute(org.opencms.setup.CmsSetupBean)
     */
    public CmsSetupTestResult execute(CmsSetupBean setupBean) {

        CmsSetupTestResult testResult = new CmsSetupTestResult(this);

        String[][] supportedContainers = {
            {"Apache Tomcat/4.1", null},
            {"Apache Tomcat/5", null},
            {"Apache Tomcat/6", null},
            {"Apache Tomcat/7", null},
            {"WebLogic Server 9", null},
            {
                "Resin/3",
                "请确定安装期间，web应用程序自动重部署（auto-redeployment）功能被禁用了。做到这一点的一个方法，是在你的配置文件<code>resin.conf</code>中，把'<code>dependency-check-interval</code>'选项设置为<code>-1</code>，或很大的数字比如<code>2000s</code>。"},
            {
                "IBM WebSphere Application Server/6",
                "迄今为止发现的限制，是当使用<code>sendRedirect</code>方法时，你必须总是使用绝对路径。"},
            {"Sun GlassFish Enterprise Server v2.1", null},
            {
                "GlassFish/v3",
                "GlassFish/v3不是一个稳定版本，并且不再做重大修改了。请选择一个稳定版本。"},
            {"JBoss Web/2.1.3.GA", null}};

        String[][] unsupportedContainers = {
            {"Tomcat Web Server/3", "不再支持Tomcat 3.x。请至少使用Tomcat 4.1。"},
            {"Apache Tomcat/4.0", "不再支持Tomcat 4.0.x。请至少使用Tomcat 4.1。"},
            {"Resin/2", "OpenCms的JSP不能与Resin 2.x一起工作。请使用Resin 3。"},
            {
                "IBM WebSphere Application Server/5",
                "OpenCms与Websphere处理<code>sendRedirect</code>方法会发生冲突。请至少使用WebSphere 6。"}};

        String servletContainer = setupBean.getServletConfig().getServletContext().getServerInfo();
        testResult.setResult(servletContainer);

        int supportedServletContainer = hasSupportedServletContainer(servletContainer, supportedContainers);
        int unsupportedServletContainer = unsupportedServletContainer(servletContainer, unsupportedContainers);

        if (unsupportedServletContainer > -1) {
            testResult.setRed();
            testResult.setInfo(unsupportedContainers[unsupportedServletContainer][1]);
            testResult.setHelp("这个servlet容器无法与OpenCms一起工作。即使OpenCms是完全符合标准的，"
                + "然而标准本身留下了一些“灰色”(比如未明确)的区域。"
                + "请考虑使用其它的、支持的servlet容器。");
        } else if (supportedServletContainer < 0) {
            testResult.setYellow();
            testResult.setHelp("这个servlet容器没有与OpenCms一起测试过。请考虑使用其它的、支持的servlet容器。");
        } else if (supportedContainers[supportedServletContainer][1] != null) {
            // set additional info for supported servlet containers
            testResult.setInfo(supportedContainers[supportedServletContainer][1]);
        } else {
            testResult.setGreen();
        }
        return testResult;
    }

    /**
     * @see org.opencms.setup.comptest.I_CmsSetupTest#getName()
     */
    public String getName() {

        return TEST_NAME;
    }

    /** 
     * Checks if the used servlet container is part of the servlet containers OpenCms supports.<p>
     * 
     * @param thisContainer The servlet container in use
     * @param supportedContainers All known servlet containers OpenCms supports
     * 
     * @return true if this container is supported, false if it was not found in the list
     */
    private int hasSupportedServletContainer(String thisContainer, String[][] supportedContainers) {

        for (int i = 0; i < supportedContainers.length; i++) {
            if (thisContainer.indexOf(supportedContainers[i][0]) >= 0) {
                return i;
            }
        }
        return -1;
    }

    /** 
     * Checks if the used servlet container is part of the servlet containers OpenCms
     * does NOT support.<p>
     * 
     * @param thisContainer the servlet container in use
     * @param unsupportedContainers all known servlet containers OpenCms does NOT support
     * 
     * @return the container id or -1 if the container is not supported
     */
    private int unsupportedServletContainer(String thisContainer, String[][] unsupportedContainers) {

        for (int i = 0; i < unsupportedContainers.length; i++) {
            if (thisContainer.indexOf(unsupportedContainers[i][0]) >= 0) {
                return i;
            }
        }
        return -1;
    }
}
