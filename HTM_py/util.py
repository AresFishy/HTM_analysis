# A number of convenient functions for analysis of the HTM dataset (and others)

import numpy as np
import pickle
import matplotlib.pyplot as plt

def load_meta():
    proj_meta = pickle.load(open("C:/Users/vision/Desktop/HTM_meta_py/HTM_projmeta.py", "rb"))
    return proj_meta

def act2mat(proj_meta, site, tp):
    act = np.vstack([proj_meta[site]['act'][k][tp] for k in range(4)])
    return act

def tone_responses(proj_meta, site, tp, win_pre, win_post):
    act = act2mat(proj_meta, site, tp)
    Tones = proj_meta[site]['ToneID'][0][tp]
    # np.where returns the values and indices, so we only use the 2nd array
    toneL_onsets = np.intersect1d(np.where(np.diff(Tones) > 1)[1], np.where(np.diff(Tones) < 2)[1]) + 1
    # The correct tone for left lick is 1.5 V
    toneR_onsets = np.where(np.diff(Tones) > 2)[1] + 1
    # The correct tone for right lick is 3.5 V
    toneL_onsets = np.delete(toneL_onsets, np.where(np.diff(toneL_onsets) < 40))
    toneR_onsets = np.delete(toneR_onsets, np.where(np.diff(toneR_onsets) < 40))
    toneL_onsets = np.delete(toneL_onsets, 0)
    toneR_onsets = np.delete(toneR_onsets, 0)
    toneL_onsets = np.delete(toneL_onsets, -1)
    toneR_onsets = np.delete(toneR_onsets, -1)

    toneL_act = np.zeros((act.shape[0], len(toneL_onsets), win_post+win_pre))
    for ind in range(len(toneL_onsets)):
        toneL_act[:,ind,:] = act[:,toneL_onsets[ind]-win_pre:toneL_onsets[ind]+win_post]

    toneR_act = np.zeros((act.shape[0], len(toneR_onsets), win_pre+win_post))
    for ind in range(len(toneR_onsets)):
        toneR_act[:,ind,:] = act[:,toneR_onsets[ind]-win_pre:toneR_onsets[ind]+win_post]

    return toneL_act, toneR_act

def elemwise_subtract(array, arr_to_sub, dim=2):
    return np.subtract(array, np.expand_dims(arr_to_sub, axis=dim))

def ca():
    plt.close("all")

def imagesc(X, *args, **kwargs):
    plt.imshow(X, *args, **kwargs, aspect="auto", interpolation="nearest")

def sem(data, dim=0):
    return np.nanstd(data, dim) / np.sqrt(np.shape(data)[dim])

def act_responses(proj_meta, site, tp, channel, win_pre, win_post):
    try:
        act = act2mat(proj_meta, site, tp)
        aux_channel = proj_meta[site][channel][0][tp]
        channel_onsets = np.where(np.diff(aux_channel) > 1)[1] + 1
        channel_onsets = np.delete(channel_onsets, 0)
        channel_onsets = np.delete(channel_onsets, -1)
        channel_onsets = np.delete(channel_onsets, -1)
        channel_act = np.zeros((act.shape[0], len(channel_onsets), win_pre+win_post))
        cnt = 0
        for ind in channel_onsets:
            channel_act[:,cnt,:] = act[:,ind-win_pre:ind+win_post]
            cnt += 1
        return channel_act
    except:
        return np.full((act.shape[0], win_pre+win_post), np.nan)

def mean_subtract(array, win_start, win_end):
    "Mean-subtract activity array over specified window"
    return elemwise_subtract(array, np.mean(array[:,:,win_start:win_end], axis=2))

def plot_SEM(array, *args, **kwargs):
    mn = np.nanmean(array, axis=0)
    Sem = sem(array, dim=0)
    x = np.arange(len(mn))
    plt.plot(x, mn, *args, **kwargs)
    plt.fill_between(x, mn-Sem, mn+Sem, *args, **kwargs)


def clean_inds(array, win1=19, win2=24, thresh=0.05):
    "Lazily made sharp onset detection"
    diff = np.diff(array)[:,win1:win2]
    suspish_onsets = np.where(np.max(np.abs(diff), axis=1) >= thresh)[0]
    rem_inds = np.setdiff1d(np.arange(array.shape[0]), suspish_onsets)
    return rem_inds

def artefact_removal(array, win1, win2, thresh):
    "Properly done artefact removal"
