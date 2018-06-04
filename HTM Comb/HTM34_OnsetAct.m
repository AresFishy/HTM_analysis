function [toneAct, tone1Act, tone2Act, mToneAct, mTone1Act, mTone2Act, cToneAct, cTone1Act, cTone2Act, gratAct,...
            grat1Act, grat2Act, mGratAct, mGrat1Act, mGrat2Act, cGratAct, cGrat1Act, cGrat2Act, puffAct, mPuffAct,...
            cPuffAct, aPuffAct, maPuffAct, caPuffAct, pPuffAct, mpPuffAct, cpPuffAct, rewAct, mRewAct, cRewAct, pRewAct,...
            mpRewAct, cpRewAct] = HTM34_OnsetAct(proj_meta, act, toneON, tone1ON, tone2ON, gratON, grat1ON, grat2ON, aPuffON, pPuffON, rewON, pRewON)

%Calculate onset activity from half of the trials.

days=1:7;
animals=1:9;

toneAct = {};   tone1Act = {};   tone2Act = {}; mToneAct = {};   mTone1Act = {};   mTone2Act = {};  cToneAct = {};   cTone1Act = {};   cTone2Act = {};
gratAct = {};   grat1Act = {};   grat2Act = {}; mGratAct = {};   mGrat1Act = {};   mGrat2Act = {};  cGratAct = {};   cGrat1Act = {};   cGrat2Act = {};
puffAct = {};   mPuffAct = {};   cPuffAct = {}; aPuffAct = {};   maPuffAct = {};   caPuffAct = {};  pPuffAct = {};   mpPuffAct = {};   cpPuffAct = {};
rewAct = {};    mRewAct = {};    cRewAct = {};  pRewAct = {};    mpRewAct = {};    cpRewAct = {};

for day = days
    for animal = animals
        for cell = 1:size(act{animal,day},1)
            %Tone activity
            for trial = 1:length(toneON{animal,day})
                tmpON = toneON{animal,day}(trial);
                toneAct{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            for trial = 1:length(tone1ON{animal,day})
                tmpON = tone1ON{animal,day}(trial);
                tone1Act{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            for trial = 1:length(tone2ON{animal,day})
                tmpON = tone2ON{animal,day}(trial);
                tone2Act{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            %Grating Activity
            for trial = 1:length(gratON{animal,day})
                tmpON = gratON{animal,day}(trial);
                gratAct{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            for trial = 1:length(grat1ON{animal,day})
                tmpON = grat1ON{animal,day}(trial);
                grat1Act{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            for trial = 1:length(grat2ON{animal,day})
                tmpON = grat2ON{animal,day}(trial);
                grat2Act{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            
            %Airpuff activity
            for trial = 1:length(aPuffON{animal,day}) %Active
                tmpON = aPuffON{animal,day}(trial);
                aPuffAct{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            for trial = 1:length(pPuffON{animal,day}) %Passive
                tmpON = pPuffON{animal,day}(trial);
                pPuffAct{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            
            %Reward Activity
            for trial = 1:length(rewON{animal,day}) %Active
                tmpON = rewON{animal,day}(trial);
                rewAct{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
            %Passive Reward Activity
            for trial = 1:length(pRewON{animal,day}) %Passive
                tmpON = pRewON{animal,day}(trial);
                pRewAct{animal,day}(trial,cell,:) = act{animal,day}(cell,tmpON-10:tmpON+20) - mean(act{animal,day}(cell,tmpON-10:tmpON-1));
            end
        end
    end
end

for day = days
    for animal = animals
        %Calculate mean activity per animal for each stimulus type
        if ~isempty(act{animal,day})
            mToneAct{animal,day} = squeeze(mean(toneAct{animal,day}(1:2:end,:,:),1)); %Half of the trials for selection
            mTone1Act{animal,day} = squeeze(mean(tone1Act{animal,day}(1:2:end,:,:),1));
            mTone2Act{animal,day} = squeeze(mean(tone2Act{animal,day}(1:2:end,:,:),1));
            
            mToneActA{animal,day} = squeeze(mean(toneAct{animal,day},1)); %All trials for cells not selected on it
            mTone1ActA{animal,day} = squeeze(mean(tone1Act{animal,day},1));
            mTone2ActA{animal,day} = squeeze(mean(tone2Act{animal,day},1));
            
            mGratAct{animal,day} = squeeze(mean(gratAct{animal,day}(1:2:end,:,:),1));
            mGrat1Act{animal,day} = squeeze(mean(grat1Act{animal,day}(1:2:end,:,:),1));
            mGrat2Act{animal,day} = squeeze(mean(grat2Act{animal,day}(1:2:end,:,:),1));
            
            mGratActA{animal,day} = squeeze(mean(gratAct{animal,day},1));
            mGrat1ActA{animal,day} = squeeze(mean(grat1Act{animal,day},1));
            mGrat2ActA{animal,day} = squeeze(mean(grat2Act{animal,day},1));
            
            if ~isempty(aPuffAct{animal,day})
                maPuffAct{animal,day} = squeeze(mean(aPuffAct{animal,day}(1:2:end,:,:),1));
                maPuffActA{animal,day} = squeeze(mean(aPuffAct{animal,day},1));
            else
                maPuffAct{animal,day} = NaN(size(act{animal,day},1),31);
                maPuffActA{animal,day} = NaN(size(act{animal,day},1),31);
            end
            
            mpPuffAct{animal,day} = squeeze(mean(pPuffAct{animal,day}(1:2:end,:,:),1));
            
            
            mpPuffActA{animal,day} = squeeze(mean(pPuffAct{animal,day},1));
            
            if ~isempty(rewAct{animal,day})
                mRewAct{animal,day} = squeeze(mean(rewAct{animal,day}(1:2:end,:,:),1));
                mRewActA{animal,day} = squeeze(mean(rewAct{animal,day},1));
            else
                mRewAct{animal,day} = NaN(size(act{animal,day},1),31);
                mRewActA{animal,day} = NaN(size(act{animal,day},1),31);
            end
            if ~isempty(pRewAct{animal,day})
                mpRewAct{animal,day} = squeeze(mean(pRewAct{animal,day}(1:2:end,:,:),1));
                mpRewActA{animal,day} = squeeze(mean(pRewAct{animal,day},1));
            else
                mpRewAct{animal,day} = NaN(size(act{animal,day},1),31);
                mpRewActA{animal,day} = NaN(size(act{animal,day},1),31);
            end
        else
            mToneAct{animal,day} = NaN(size(act{animal,1},1),31);
            mTone1Act{animal,day} = NaN(size(act{animal,1},1),31);
            mTone2Act{animal,day} = NaN(size(act{animal,1},1),31);
            
            mGratAct{animal,day} = NaN(size(act{animal,1},1),31);
            mGrat1Act{animal,day} = NaN(size(act{animal,1},1),31);
            mGrat2Act{animal,day} = NaN(size(act{animal,day},1),31);
            
            maPuffAct{animal,day} = NaN(size(act{animal,1},1),31);
            mpPuffAct{animal,day} = NaN(size(act{animal,1},1),31);
            mRewAct{animal,day} = NaN(size(act{animal,1},1),31);
            mpRewAct{animal,day} = NaN(size(act{animal,1},1),31);
            
            mToneActA{animal,day} = NaN(size(act{animal,1},1),31);
            mTone1ActA{animal,day} = NaN(size(act{animal,1},1),31);
            mTone2ActA{animal,day} = NaN(size(act{animal,1},1),31);
            
            mGratActA{animal,day} = NaN(size(act{animal,1},1),31);
            mGrat1ActA{animal,day} = NaN(size(act{animal,1},1),31);
            mGrat2ActA{animal,day} = NaN(size(act{animal,day},1),31);
            
            maPuffActA{animal,day} = NaN(size(act{animal,1},1),31);
            mpPuffActA{animal,day} = NaN(size(act{animal,1},1),31);
            mRewActA{animal,day} = NaN(size(act{animal,1},1),31);
            mpRewActA{animal,day} = NaN(size(act{animal,1},1),31);
        end
    end
    %Get combined activity across animals
    cToneAct{day} = vertcat(mToneAct{:,day}); %Based on half the trials
    cTone1Act{day} = vertcat(mTone1Act{:,day});
    cTone2Act{day} = vertcat(mTone2Act{:,day});
    
    cGratAct{day} = vertcat(mGratAct{:,day});
    cGrat1Act{day} = vertcat(mGrat1Act{:,day});
    cGrat2Act{day} = vertcat(mGrat2Act{:,day});
    
    caPuffAct{day} = vertcat(maPuffAct{:,day});
    cpPuffAct{day} = vertcat(mpPuffAct{:,day});
    cRewAct{day} = vertcat(mRewAct{:,day});
    cpRewAct{day} = vertcat(mpRewAct{:,day});
    
    cToneActA{day} = vertcat(mToneActA{:,day}); %Based on all trials
    cTone1ActA{day} = vertcat(mTone1ActA{:,day});
    cTone2ActA{day} = vertcat(mTone2ActA{:,day});
    
    cGratActA{day} = vertcat(mGratActA{:,day});
    cGrat1ActA{day} = vertcat(mGrat1ActA{:,day});
    cGrat2ActA{day} = vertcat(mGrat2ActA{:,day});
    
    caPuffActA{day} = vertcat(maPuffActA{:,day});
    cpPuffActA{day} = vertcat(mpPuffActA{:,day});
    cRewActA{day} = vertcat(mRewActA{:,day});
    cpRewActA{day} = vertcat(mpRewActA{:,day});
end