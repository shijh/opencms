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

import org.opencms.main.CmsSystemInfo;
import org.opencms.setup.CmsSetupBean;

import java.io.File;

/**
 * Tests if the OpenCms WAR file is unpacked.<p>
 * 
 * @since 6.1.8 
 */
public class CmsSetupTestWarFileUnpacked implements I_CmsSetupTest {

    /** The test name. */
    public static final String TEST_NAME = "未解压的WAR文件";

    /**
     * @see org.opencms.setup.comptest.I_CmsSetupTest#getName()
     */
    public String getName() {

        return TEST_NAME;
    }

    /**
     * @see org.opencms.setup.comptest.I_CmsSetupTest#execute(org.opencms.setup.CmsSetupBean)
     */
    public CmsSetupTestResult execute(CmsSetupBean setupBean) {

        CmsSetupTestResult testResult = new CmsSetupTestResult(this);

        String basePath = setupBean.getWebAppRfsPath();
        if (!basePath.endsWith(File.separator)) {
            basePath += File.separator;
        }
        File file = new File(basePath + CmsSystemInfo.FOLDER_WEBINF + CmsSystemInfo.FILE_TLD);
        if (file.exists() && file.canRead() && file.canWrite()) {
            testResult.setGreen();
            testResult.setResult(RESULT_PASSED);
        } else {
            testResult.setRed();
            testResult.setInfo("不能安装OpenCms，除非OpenCms WAR文件被解压缩了！"
                + "请检查你的servlet容器的配置，或者手工把WAR文件解压缩。");
            testResult.setHelp("WAR文件没有解压缩");
            testResult.setResult(RESULT_FAILED);
        }
        return testResult;
    }
}
