
# -*- coding: utf-8 -*-
"""
Created on Tue May  8 15:17:51 2018

@author: ares
"""

import numpy as np


def get_Arc_expression(proj_meta, site, tp):
    arcAct = []
    im_size = (400, 750)

    for z_layer in range(4):
        ROIs = proj_meta[site]['ROIinfo'][z_layer][tp]['indices'][0]
        ROI_inds= [np.unravel_index(ROIs[k], im_size,"F") for k in range(len(ROIs))] # Equivalent to ind2sub.
        # Btw the "F" argument is crucial to get the right indices!!
        ROI_template = proj_meta[site]['template_sec'][z_layer][tp] # Get IEG Template
        tmp_ieg = \
        np.vstack([np.mean(ROI_template[ROI_inds[k][0], ROI_inds[k][1]], axis=0) # ROI indices on template
                for k in range(len(ROI_inds))])
        arcAct.append(tmp_ieg)

    return np.vstack(arcAct)


def normalize_Arc(arcAct, keep_res=False):
    '''Normalize Arc activity by the bottom 8th percentile"
    args:
    arcAct: #cells x 6 IEG level matrix
    keep_res: (optional) decide whether to keep within-session IEG activity'''

    tmp_act = np.mean(arcAct, axis=1)
    # bottom_8pct = np.median(tmp_act[tmp_act < np.percentile(tmp_act, 8)])
    bottom_8pct = np.median(np.percentile(tmp_act, 8))

    if not keep_res:
        return tmp_act / bottom_8pct
    else:
        return np.divide(arcAct, bottom_8pct)

def normalize_IEG(proj_meta, site, tp, cumulative=False):
    tps = np.int32(np.linspace(0, 12, 7)) # Timepoints with IEG recordings
    ieg_tmp = np.hstack([get_Arc_expression(proj_meta, site, timepoint) for timepoint in tps])
    ieg_min = np.expand_dims(np.min(ieg_tmp, axis=1), axis=1)
    ieg_med = np.expand_dims(np.median(ieg_tmp, axis=1), axis=1)
    ieg_tmp = ieg_tmp - ieg_min # Subtract minimum
    ieg_tmp = ieg_tmp / ieg_med # Divide by median
    if cumulative:
        return ieg_tmp
    else:
        norm_IEG = get_Arc_expression(proj_meta, site, tp) - ieg_min
        norm_IEG = norm_IEG / ieg_med
        return norm_IEG


def get_IEG_cells(proj_meta, site, thresh, get_mat=False):
    tps = np.int32(np.linspace(0, 12, 7)) # Timepoints with IEG recordings
    cum_IEG = np.vstack([np.mean(normalize_IEG(proj_meta, site, tp), axis=1) for tp in tps])
    # cum_IEG = np.vstack([normalize_Arc(get_Arc_expression(proj_meta, site, tp),
    # keep_res=False) for tp in tps])
    tmp = np.mean(cum_IEG[1:2,:], axis=0)
    IEG_cells = np.where(tmp >= np.percentile(tmp, thresh))[0]
    if get_mat == False:
        return IEG_cells
    else:
        return IEG_cells, cum_IEG

def get_all_IEG(proj_meta, keep_res=False):
    # Function for the lazy
    tps = np.arange(0, 13, 2) # increment by 2
    if keep_res==True:
        tmp_Arc = [np.vstack([normalize_IEG(proj_meta, site, tp)
    for site in range(4)]) for tp in tps]
        tmp_cFos = [np.vstack([normalize_IEG(proj_meta, site, tp)
        for site in range(4,9)]) for tp in tps]
    else:
        tmp_Arc = [np.hstack([np.mean(normalize_IEG(proj_meta, site, tp), axis=1)
        for site in range(4)]) for tp in tps]

        tmp_cFos = [np.hstack([np.mean(normalize_IEG(proj_meta, site, tp), axis=1)
        for site in range(4,9)]) for tp in tps]
    print("Have ye no shame?")
    return tmp_Arc, tmp_cFos
