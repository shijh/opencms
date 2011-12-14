/*
 * This library is for OpenCms 
 *
 * Copyright (C) Langhua OpenSource
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.file.collectors;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.util.CmsUUID;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

/**
 * Comparator for sorting resource objects based on  size.<p>
 * 
 * Serves as {@link java.util.Comparator} for resources and as comparator key for the resource
 * at the same time. Uses lazy initializing of comparator keys in a resource.<p>
 * 
 * @since 6.0.0 
 */
public class CmsPrioritySizeResourceComparator implements Comparator<Object> {

    /** The name of the size property to read. */
    public static final String PROPERTY_SIZE = "collector.size";

    /** The size sort order. */
    private boolean m_asc;

    /** The current OpenCms user context. */
    private CmsObject m_cms;

    /** The size of this comparator key. */
    private int m_size;

    /** The internal map of comparator keys. */
    private Map<CmsUUID, CmsPrioritySizeResourceComparator> m_keys;

    /**
     * Creates a new instance of this comparator key.<p>
     * 
     * @param cms the current OpenCms user context
     * @param asc if true, the size sort order is ascending, otherwise descending
     */
    public CmsPrioritySizeResourceComparator(CmsObject cms, boolean asc) {

        m_cms = cms;
        m_asc = asc;
        m_keys = new HashMap<CmsUUID, CmsPrioritySizeResourceComparator>();
    }

    /**
     * Creates a new instance of this comparator key.<p>
     * 
     * @param resource the resource to create the key for
     * @param cms the current OpenCms user context
     * 
     * @return a new instance of this comparatoy key
     */
    private static CmsPrioritySizeResourceComparator create(CmsResource resource, CmsObject cms) {

    	CmsPrioritySizeResourceComparator result = new CmsPrioritySizeResourceComparator(null, false);
        result.init(resource, cms);
        return result;
    }

    /**
     * @see java.util.Comparator#compare(java.lang.Object, java.lang.Object)
     */
    public int compare(Object arg0, Object arg1) {

        if ((arg0 == arg1) || !(arg0 instanceof CmsResource) || !(arg1 instanceof CmsResource)) {
            return 0;
        }

        CmsResource res0 = (CmsResource)arg0;
        CmsResource res1 = (CmsResource)arg1;

        CmsPrioritySizeResourceComparator key0 = (CmsPrioritySizeResourceComparator)m_keys.get(res0.getStructureId());
        CmsPrioritySizeResourceComparator key1 = (CmsPrioritySizeResourceComparator)m_keys.get(res1.getStructureId());

        if (key0 == null) {
            // initialize key if null
            key0 = CmsPrioritySizeResourceComparator.create(res0, m_cms);
            m_keys.put(res0.getStructureId(), key0);
        }
        if (key1 == null) {
            // initialize key if null
            key1 = CmsPrioritySizeResourceComparator.create(res1, m_cms);
            m_keys.put(res1.getStructureId(), key1);
        }
        
        if (m_asc) {
            // sort in ascending order
            if (key0.getSize() > key1.getSize()) {
                return 1;
            }
            if (key0.getSize() < key1.getSize()) {
                return -1;
            }
        } else {
            // sort in descending order
            if (key0.getSize() > key1.getSize()) {
                return -1;
            }
            if (key0.getSize() < key1.getSize()) {
                return 1;
            }
        }

        return 0;
    }

    /**
     * Returns the size of this resource comparator key.<p>
     * 
     * @return the size of this resource comparator key
     */
    public int getSize() {

        return m_size;
    }

    /**
     * Initializes the comparator key based on the member variables.<p> 
     * 
     * @param resource the resource to use 
     * @param cms the current OpenCms user contxt
     */
    private void init(CmsResource resource, CmsObject cms) {

        try {
        	m_size = resource.getLength();
        } catch (NumberFormatException e) {
        	m_size = 0;
        }
    }

}
