import numpy as np

def eval_performance(proj_meta):
    "---Get a correct one that takes passive stuff into account---"
    correct_choice = np.zeros((len(proj_meta), 7))
    for site in range(len(proj_meta)):
    # for site in range(4,9):
            cnt = 0
            for tp in np.int32(np.linspace(2, 14, 7) - 1):
                rewR = proj_meta[site]['RewardR'][0][tp]
                rewL = proj_meta[site]['RewardL'][0][tp]
                Tones = proj_meta[site]['ToneID'][0][tp]

                # np.where returns the values and indices, so we only use the 2nd array
                toneL_onsets = np.intersect1d(np.where(np.diff(Tones) > 1)[1],
                 np.where(np.diff(Tones) < 2)[1]) + 1
                # The correct tone for left lick is 1.5 V
                toneR_onsets = np.where(np.diff(Tones) > 2)[1] + 1
                # The correct tone for right lick is 3.5 V
                toneL_onsets = np.delete(toneL_onsets, np.where(np.diff(toneL_onsets) < 40))
                toneR_onsets = np.delete(toneR_onsets, np.where(np.diff(toneR_onsets) < 40))

                rewL_onsets = np.where(np.diff(rewL) > 1)[1] + 1
                rewR_onsets = np.where(np.diff(rewR) > 1)[1] + 1

                correctL = []
                for ind in range(len(toneL_onsets)):
                    toneL_bin = np.arange(toneL_onsets[ind], toneL_onsets[ind]+40)
                    left_bin_hits = np.isin(rewL_onsets, toneL_bin)
                    if np.size(left_bin_hits) > 0:
                        correctL.append(np.max(1*left_bin_hits))

                correctR = []
                for ind in range(len(toneR_onsets)):
                    toneR_bin = np.arange(toneR_onsets[ind], toneR_onsets[ind]+40)
                    right_bin_hits = np.isin(rewR_onsets, toneR_bin)
                    if np.size(right_bin_hits) > 0:
                        correctR.append(np.max(1*right_bin_hits))

                correct_choice[site, cnt] = np.mean(np.hstack((correctL, correctR)))
                cnt+=1

    return correct_choice

def eval_performance_DM(proj_meta):
    "David's performance measure code"
    "ProjectAnalysis\Analysis_HTM\HTM Figure Analysis\HTM34_AnimalPerformance.m"
    perf = np.zeros((len(proj_meta), 7))
    for site in range(len(proj_meta)):
        cnt = 0
        for tp in np.int32(np.linspace(2, 14, 7) - 1):
            Tones = proj_meta[site]['ToneID'][0][tp]
            lickR = np.abs(proj_meta[site]['LickR'][0][tp].flatten())
            lickL = np.abs(proj_meta[site]['LickL'][0][tp].flatten())

            toneL_onsets = np.intersect1d(np.where(np.diff(Tones) > 1)[1],
                                      np.where(np.diff(Tones) < 2)[1]) + 1
            toneR_onsets = np.where(np.diff(Tones) > 2)[1] + 1
            # toneL_onsets = np.delete(toneL_onsets, np.where(np.diff(toneL_onsets) < 40))
            # toneR_onsets = np.delete(toneR_onsets, np.where(np.diff(toneR_onsets) < 40))
            toneL_onsets = np.delete(toneL_onsets, np.where(toneL_onsets > len(lickR)-40))
            toneR_onsets = np.delete(toneR_onsets, np.where(toneR_onsets > len(lickR)-40))
            resp1 = []
            for ind in toneL_onsets:
                tmpR = np.where(lickR[ind+20:ind+40] > 0.1)[0]
                tmpL = np.where(lickL[ind+20:ind+40] > 0.1)[0]

                if tmpR.shape[0] == 0 and tmpL.shape[0] == 0:
                    resp1.append(0) # Passive animal..?
                elif tmpR.shape[0] == 0:
                    resp1.append(1) # Correct miss
                elif tmpL.shape[0] == 0:
                    resp1.append(2) # Wrong miss
                else:
                    latR = np.argmax(tmpR)
                    latL = np.argmax(tmpL)
                    if latL < latR:
                        resp1.append(1) # Correct hit
                    else:
                        resp1.append(2) # Wrong hit
            resp1 = np.asarray(resp1)

            resp2 = []
            for ind in toneR_onsets:
                tmpR = np.where(lickR[ind+20:ind+40] > 0.1)[0]
                tmpL = np.where(lickL[ind+20:ind+40] > 0.1)[0]

                if tmpR.shape[0] == 0 and tmpL.shape[0] == 0:
                    resp2.append(0) # Passive animal
                elif tmpR.shape[0] == 0:
                    resp2.append(1) # Wrong miss
                elif tmpL.shape[0] == 0:
                    resp2.append(2) # Correct miss
                else:
                    latR = np.argmax(tmpR)
                    latL = np.argmax(tmpL)
                    if latL < latR:
                        resp2.append(1) # Wrong hit
                    else:
                        resp2.append(2) # Correct hit
            resp2 = np.asarray(resp2)
            perf[site, cnt] = np.divide(np.sum(resp1==1)+np.sum(resp2==2),
                                        np.sum(resp1>0)+np.sum(resp2>0))
            cnt += 1

    perf[perf==1] = np.NaN
    perf[perf==0] = np.NaN
    return perf

def perf_bytrial(proj_meta, site, tp):
    "Same as eval_performance_DM but with per-trial resolution"
    "resp1: Left tone, correct=1, wrong=2, passive=0"
    "resp2: Right tone, correct=2, wrong=1, passive=0"
    cnt = 0
    Tones = proj_meta[site]['ToneID'][0][tp]
    lickR = np.abs(proj_meta[site]['LickR'][0][tp].flatten())
    lickL = np.abs(proj_meta[site]['LickL'][0][tp].flatten())

    toneL_onsets = np.intersect1d(np.where(np.diff(Tones) > 1)[1],
                              np.where(np.diff(Tones) < 2)[1]) + 1
    toneR_onsets = np.where(np.diff(Tones) > 2)[1] + 1
    # toneL_onsets = np.delete(toneL_onsets, np.where(np.diff(toneL_onsets) < 40))
    # toneR_onsets = np.delete(toneR_onsets, np.where(np.diff(toneR_onsets) < 40))
    toneL_onsets = np.delete(toneL_onsets, np.where(toneL_onsets > len(lickR)-40))
    toneR_onsets = np.delete(toneR_onsets, np.where(toneR_onsets > len(lickR)-40))
    resp1 = [] # Left tone
    for ind in toneL_onsets:
        tmpR = np.where(lickR[ind+20:ind+40] > 0.1)[0]
        tmpL = np.where(lickL[ind+20:ind+40] > 0.1)[0]

        if tmpR.shape[0] == 0 and tmpL.shape[0] == 0:
            resp1.append(0)
        elif tmpR.shape[0] == 0:
            resp1.append(1)
        elif tmpL.shape[0] == 0:
            resp1.append(2)
        else:
            latR = np.argmax(tmpR)
            latL = np.argmax(tmpL)
            if latL < latR:
                resp1.append(1)
            else:
                resp1.append(2)
    resp1 = np.asarray(resp1)

    resp2 = [] # Right tone
    for ind in toneR_onsets:
        tmpR = np.where(lickR[ind+20:ind+40] > 0.1)[0]
        tmpL = np.where(lickL[ind+20:ind+40] > 0.1)[0]

        if tmpR.shape[0] == 0 and tmpL.shape[0] == 0:
            resp2.append(0)
        elif tmpR.shape[0] == 0:
            resp2.append(1)
        elif tmpL.shape[0] == 0:
            resp2.append(2)
        else:
            latR = np.argmax(tmpR)
            latL = np.argmax(tmpL)
            if latL < latR:
                resp2.append(1)
            else:
                resp2.append(2)
    resp2 = np.asarray(resp2)

    return resp1, resp2
