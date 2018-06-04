import os
from scipy import io

def get_projmeta():
    pathname = "C:\Users\vision\Desktop\HTM_meta_py"
    proj_meta = []
    
    for site_id in os.listdir(pathname):
        meta_name = pathname + site_id
        tmp_meta = io.loadmat(meta_name)['tmp']
    
    # tmp_meta['rd'][0][0][0][0]['timepoint'] 
    #               ^? ^?  ^  ^
    #                   layer timepoint
    
    # Let's convert this awkwardness into something friendlier
    
        rd = tmp_meta['rd'][0][0] # We assume we're only interested in the rd field
        rdtype = rd.dtype # The data types: a list of named python objects
    
        site_projmeta = {n: rd[n] for n in rdtype.names} 
        # This gets the data from each field and neatly organizes it
    
        proj_meta.append(site_projmeta)
        del tmp_meta, site_projmeta

    return proj_meta

