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

import org.dom4j.io.SAXReader;

/**
 * Test for the XML API.<p>
 * 
 * @since 6.1.8 
 */
public class CmsSetupTestXmlAPI implements I_CmsSetupTest {

    /** The test name. */
    public static final String TEST_NAME = "XML API";

    /**
     * @see org.opencms.setup.comptest.I_CmsSetupTest#getName()
     */
    public String getName() {

        return TEST_NAME;
    }

    /**
     * @see org.opencms.setup.comptest.I_CmsSetupTest#execute(org.opencms.setup.CmsSetupBean)
     */
    public CmsSetupTestResult execute(CmsSetupBean setupBean) throws Exception {

        CmsSetupTestResult testResult = new CmsSetupTestResult(this);

        SAXReader reader = new SAXReader();
        Throwable exc = null;
        try {
            reader.setValidation(false);
            reader.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
        } catch (Throwable e) {
            exc = e;
        }

        if (exc == null) {
            testResult.setResult("通过");
            testResult.setHelp("OpenCms需要Xerces 2才能运行。通常它是servlet环境的一部分。");
            testResult.setGreen();
        } else {
            testResult.setResult("没通过");
            testResult.setRed();
            testResult.setInfo("OpenCms需要配置了Xerces XML API。"
                + "请确定设置了下列Java系统参数：<br><pre>"
                + "javax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl\n"
                + "javax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl\n"
                + "javax.xml.transform.TransformerFactory=org.apache.xalan.processor.TransformerFactoryImpl\n"
                + "org.xml.sax.driver=org.apache.xerces.parsers.SAXParser</pre>");
            testResult.setHelp(exc.getClass().getName() + ": " + exc.getMessage());
        }
        return testResult;
    }
}
