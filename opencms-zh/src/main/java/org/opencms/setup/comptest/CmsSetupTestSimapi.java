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

import com.alkacon.simapi.RenderSettings;
import com.alkacon.simapi.Simapi;
import com.alkacon.simapi.filter.ImageMath;
import com.alkacon.simapi.filter.RotateFilter;

import org.opencms.setup.CmsSetupBean;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Arrays;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.ImageWriter;

/**
 * Tests the image processing capabilities.<p>
 * 
 * @since 6.1.8 
 */
public class CmsSetupTestSimapi implements I_CmsSetupTest {

    /** The test name. */
    public static final String TEST_NAME = "图像处理";

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
        boolean ok = true;
        Throwable ex = null;
        try {
            RenderSettings settings = new RenderSettings(Simapi.RENDER_QUALITY);
            settings.setCompressionQuality(0.85f);
            Simapi simapi = new Simapi(settings);

            ImageIO.scanForPlugins();
            Iterator<ImageReader> pngReaders = ImageIO.getImageReadersByFormatName(Simapi.TYPE_PNG);
            if (!pngReaders.hasNext()) {
                throw (new Exception("没有找到用于PNG格式的Java ImageIO读程序。"));
            }
            Iterator<ImageWriter> pngWriters = ImageIO.getImageWritersByFormatName(Simapi.TYPE_PNG);
            if (!pngWriters.hasNext()) {
                throw (new Exception("没有找到用于PNG格式的Java ImageIO写程序。"));
            }

            String basePath = setupBean.getWebAppRfsPath();
            if (!basePath.endsWith(File.separator)) {
                basePath += File.separator;
            }
            basePath += "setup" + File.separator + "resources" + File.separator;

            BufferedImage img1 = Simapi.read(basePath + "test1.png");
            BufferedImage img3 = simapi.applyFilter(img1, new RotateFilter(ImageMath.PI));
            simapi.write(img3, basePath + "test3.png", Simapi.TYPE_PNG);
            BufferedImage img2 = Simapi.read(basePath + "test2.png");

            ok = Arrays.equals(simapi.getBytes(img2, Simapi.TYPE_PNG), simapi.getBytes(img3, Simapi.TYPE_PNG));
        } catch (Throwable e) {
            ok = false;
            ex = e;
        }

        if (ok) {
            testResult.setResult(RESULT_PASSED);
            testResult.setGreen();
        } else {
            testResult.setYellow();
            if (ex != null) {
                testResult.setResult(RESULT_FAILED);
                testResult.setHelp(ex.toString());
                testResult.setInfo("<p>可能缺少<code>-Djava.awt.headless=true</code> JVM参数或X-Server。<br>"
                    + "<b>你可以继续安装，但是图像处理会被禁用。</b></p>");
            } else {
                testResult.setResult(RESULT_WARNING);
                testResult.setHelp("图像处理会起作用，但是结果可能不符合预期。");
                StringBuffer info = new StringBuffer();
                info.append("<p>请检查下列图片的视觉差异：</p>");
                info.append("<table width='100%'>");
                info.append("<tr><th>预期</th><th>结果</th></tr>");
                info.append("<tr><td align='center' width='50%'><img src='resources/test2.png'></td>");
                info.append("<td align='center' width='50%'><img src='resources/test3.png'></td></table>");
                info.append("<p><b>你可以继续安装，但是图像处理可能不会总是符合预期。</b></p>");
                testResult.setInfo(info.toString());
            }
        }
        return testResult;
    }
}
