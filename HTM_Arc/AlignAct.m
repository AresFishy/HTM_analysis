%Align activity to individual trials for half of the trials (the ones not used for cell selection)
trialON = [];
trialAct = {};      mTrialAct = {};     cTrialAct = {};
aPuffTrialAct = {};  maPuffTrialAct = {}; caPuffTrialAct = {};
pPuffTrialAct = {};  mpPuffTrialAct = {}; cpPuffTrialAct = {};
rewTrialAct = {};   mRewTrialAct = {};  cRewTrialAct = {};
pRewTrialAct = {};   mpRewTrialAct = {};  cpRewTrialAct = {};
omTrialAct = {};    mOmTrialAct = {};   cOmTrialAct = {};

pupilSizeP = {};    mPupilSizeP = {};   cPupilSizeP = {};
pupilSizeR = {};    mPupilSizeR = {};   cPupilSizeR = {};
pupilSizeOM = {};   mPupilSizeOM = {};  cPupilSizeOM = {};
aPupilSizeP = {};

lickActP = {};     mLickActP = {};     cLickActP = {};
lickActR = {};     mLickActR = {};     cLickActR = {};
lickActOM = {};    mLickActOM = {};    cLickActOM = {};
aLickActP = {};

for day = 1:8
    for animal = 1:4
        omTrialAct{animal,day} = NaN(1,size(act{animal,1},1),201);
    end
end

%The trialID can be used to designate trial types (ID's) for classification
%purposes

for day = 1:8
    for animal = 1:4
        aPuffTrialAct{animal,day} = [];
        tmpON = toneON{animal,day};
        trialON{animal,day} = tmpON(diff(tmpON) > 180 & diff(tmpON) < 270);
        cLick{animal,day} = mean([lickR{animal,day}; lickL{animal,day}]) < -1;

        apCnt = 0; %Active lick puff
        ppCnt = 0; %No lick puff
        rCnt = 0; %Active rewards
        prCnt = 0; %Passive rewards
        omCnt = 0;  %Omissions
        trialID{animal,day} = zeros(length(trialON{animal,day}),1);
        for trial = 1:length(trialON{animal,day})
            if trialON{animal,day}(trial) + 200 < size(act{animal,day},2)
                trialAct{animal,day}(trial,:,:) = bsxfun(@minus,act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180),mean(act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)),2));
                pupilSize{animal,day}(trial,:) = pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                %Get trials with active puff
                if length(find(aPuffON{animal,day}-trialON{animal,day}(trial) < 50 & aPuffON{animal,day}-trialON{animal,day}(trial) > 15)) == 1
                    apCnt = apCnt + 1;
                    trialID{animal,day}(trial) = 2; %Set reward trials to 1 and puff trials as 2
                    aPuffTrialAct{animal,day}(apCnt,:,:) = bsxfun(@minus,act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180),mean(act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)),2));
                    aPupilSizeP{animal,day}(apCnt,:) = pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    aLickActP{animal,day}(apCnt,:) = cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                %Get trials with passive puff
                elseif length(find(pPuffON{animal,day}-trialON{animal,day}(trial) < 50 & pPuffON{animal,day}-trialON{animal,day}(trial) > 15)) == 1
                    ppCnt = ppCnt + 1;
                    %trialID{animal,day}(trial) = 2; %Set reward trials to 1 and puff trials as 2
                    pPuffTrialAct{animal,day}(ppCnt,:,:) = bsxfun(@minus,act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180),mean(act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)),2));
                    pPupilSizeP{animal,day}(ppCnt,:) = pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    pLickActP{animal,day}(ppCnt,:) = cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    %Get reward trials
                elseif length(find(rewON{animal,day}-trialON{animal,day}(trial) < 50 & rewON{animal,day}-trialON{animal,day}(trial) > 15)) == 1
                    rCnt = rCnt + 1;
                    trialID{animal,day}(trial) = 1; %Set reward trials to 1 and puff trials as 2
                    rewTrialAct{animal,day}(rCnt,:,:) = bsxfun(@minus,act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180),mean(act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)),2));
                    pupilSizeR{animal,day}(rCnt,:) = pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    lickActR{animal,day}(rCnt,:) = cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    
                    %Get random reward trials
                elseif length(find(pRewON{animal,day}-trialON{animal,day}(trial) < 50 & pRewON{animal,day}-trialON{animal,day}(trial) > 15)) == 1               
                    prCnt = prCnt + 1;
                    pRewTrialAct{animal,day}(prCnt,:,:) = bsxfun(@minus,act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180),mean(act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)),2));
                    pPupilSizeR{animal,day}(prCnt,:) = pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    pLickActR{animal,day}(prCnt,:) = cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                
                else %Remaining is omission trials
                    omCnt = omCnt + 1;
                    trialID{animal,day}(trial) = NaN(1,1);
                    %trialID{animal,day}(trial) = 3;
                    omTrialAct{animal,day}(omCnt,:,:) = bsxfun(@minus,act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180),mean(act{animal,day}(:,trialON{animal,day}(trial)-20:trialON{animal,day}(trial)),2));
                    pupilSizeOM{animal,day}(omCnt,:) = pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(pupilD{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    lickActOM{animal,day}(omCnt,:) = cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180)-mean(cLick{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)));
                    lickLOM{animal,day}(omCnt,:) = lickL{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180);
                    lickROM{animal,day}(omCnt,:) = lickR{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180);
                    toneOM{animal,day}(omCnt,:) = tone{animal,day}(trialON{animal,day}(trial)-20:trialON{animal,day}(trial)+180);
                end
            end
        end
        
        trialID{animal,day}(trialID{animal,day} == 0) = NaN(1,1); %Set everything that is not an active puff or reward to NaN.
        
        %Calculate mean activity across trials
        if ~isempty(trialAct{animal,day});
            mAct{animal,day} = nanmean(act{animal,day},2);
            mTrialAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(1:2:end,:,:),1));
            if ~isempty(rewON{animal,day})
                mRewTrialAct{animal,day} = squeeze(nanmean(rewTrialAct{animal,day}(1:2:end,:,:),1));
                mPupilSizeR{animal,day} = mean(pupilSizeR{animal,day},1);
                mLickActR{animal,day} = mean(lickActR{animal,day},1);
            else
                mRewTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
                mPupilSizeR{animal,day} = NaN(1,201);
                mLickActR{animal,day} = NaN(1,201);
            end
            if ~isempty(pRewON{animal,day})
                mpRewTrialAct{animal,day} = squeeze(nanmean(pRewTrialAct{animal,day}(1:2:end,:,:),1));
                mpPupilSizeR{animal,day} = mean(pPupilSizeR{animal,day},1);
                mpLickActR{animal,day} = mean(pLickActR{animal,day},1);
            else
                mpRewTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
                mpPupilSizeR{animal,day} = NaN(1,201);
                mpLickActR{animal,day} = NaN(1,201);
            end
            if ~isempty(aPuffTrialAct{animal,day})
                maPuffTrialAct{animal,day} = squeeze(nanmean(aPuffTrialAct{animal,day}(1:2:end,:,:),1));
                maPupilSizeP{animal,day} = mean(aPupilSizeP{animal,day},1);
                maLickActP{animal,day} = mean(aLickActP{animal,day},1);
            else
                maPuffTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
                maPupilSizeP{animal,day} = NaN(1,201);
                maLickActP{animal,day} = NaN(1,201);
            end
            if ~isempty(pPuffTrialAct{animal,day})
                mpPuffTrialAct{animal,day} = squeeze(nanmean(pPuffTrialAct{animal,day}(1:2:end,:,:),1));
                mpPupilSizeP{animal,day} = mean(pPupilSizeP{animal,day},1);
                mpLickActP{animal,day} = mean(pLickActP{animal,day},1);
            else
                mpPuffTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
                mpPupilSizeP{animal,day} = NaN(1,201);
                mpLickActP{animal,day} = NaN(1,201);
            end
            if ~isnan(omTrialAct{animal,day})
                mOmTrialAct{animal,day} = squeeze(nanmean(omTrialAct{animal,day},1));
                mPupilSizeOM{animal,day} = mean(pupilSizeOM{animal,day},1);
                mLickActOM{animal,day} = mean(lickActOM{animal,day},1);
            else
                mOmTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
                mPupilSizeOM{animal,day} = NaN(1,201);
                mLickActOM{animal,day} = NaN(1,201);
            end
        else
            mTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            maPuffTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            mpPuffTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            mRewTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            mpRewTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            mOmTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            maPuffTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            mpPuffTrialAct{animal,day} = NaN(size(act{animal,1},1),201);
            mAct{animal,day} = NaN(size(act{animal,1},1),1);
        end
    end
    
    %Combine across animals
    cAct{day} = vertcat(mAct{:,day});
    cTrialAct{day} = vertcat(mTrialAct{:,day});
    cRewTrialAct{day} = vertcat(mRewTrialAct{:,day});
    cpRewTrialAct{day} = vertcat(mpRewTrialAct{:,day});
    cOmTrialAct{day} = vertcat(mOmTrialAct{:,day});
    caPuffTrialAct{day} = vertcat(maPuffTrialAct{:,day});
    cpPuffTrialAct{day} = vertcat(mpPuffTrialAct{:,day});
    
    caPupilSizeP{day} = vertcat(maPupilSizeP{:,day});
    cpPupilSizeP{day} = vertcat(mpPupilSizeP{:,day});
    cPupilSizeR{day} = vertcat(mPupilSizeR{:,day});
    cpPupilSizeR{day} = vertcat(mPupilSizeR{:,day});
    cPupilSizeOM{day} = vertcat(mPupilSizeOM{:,day});
    
    caLickActP{day} = vertcat(maLickActP{:,day});
    cpLickActP{day} = vertcat(mpLickActP{:,day});
    cLickActR{day} = vertcat(mLickActR{:,day});
    cpLickActR{day} = vertcat(mLickActR{:,day});
    cLickActOM{day} = vertcat(mLickActOM{:,day});

end

