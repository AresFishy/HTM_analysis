%Concatenate data - HTM Project
%AVP 2016

%Concatenate data
for animal = 1:4
    daycnt = 0;
    for day = 2:2:14
        daycnt = daycnt +1;
        if size(proj_meta(animal).rd,2)-day > -1;
            for layer = 1:4;
                tempact{layer} = proj_meta(animal).rd(layer,day).act;
            end
            act{animal,daycnt} = vertcat(tempact{1:4}); %Cell activity across layers
            airPuff{animal,daycnt} = proj_meta(animal).rd(layer,day).AirPuff; %AirPuff signals
            lickL{animal,daycnt} = proj_meta(animal).rd(layer,day).LickL; %Lick signals
            lickR{animal,daycnt} = proj_meta(animal).rd(layer,day).LickR; %Lick signals
            grat{animal,daycnt} = proj_meta(animal).rd(layer,day).GratID; %Sequence Element ID signal signals
            tone{animal,daycnt} = proj_meta(animal).rd(layer,day).ToneID; %Sequence Element ID signal signals
            rewL{animal,daycnt} = proj_meta(animal).rd(layer,day).RewardL; %Sequence Element ID signal signals
            rewR{animal,daycnt} = proj_meta(animal).rd(layer,day).RewardR; %Sequence Element ID signal signals
            blink{animal,daycnt} = proj_meta(animal).rd(layer,day).blinkR; %Blink signals
            pupilD{animal,daycnt} = proj_meta(animal).rd(layer,day).pupil_diamR; %Pupil diameter signals
        end
    end
end

%Calculate onsets
puffON = {};    aPuffON = {};   pPuffON = {};
rewLON = {};    rewRON = {};    rewON = {};     pRewON = {};    aRewLON = {};   pRewLON = {};   aRewRON = {};   pRewRON = {}; 
tone1ON = {};   tone2ON = {};   toneON = {};
grat1ON = {};   grat2ON = {};   gratON = {};    gratOFF = {};




for day = 1:7
    for animal = 1:4
        %Get puff onsets based on active or passive
        tmpptAct = -tone{animal,day}+airPuff{animal,day};
        tmpptAct(tmpptAct < 0) = 0;
        tmpptAct = diff(tmpptAct);
        aPuffON{animal,day} = find(tmpptAct > 1 & tmpptAct < 4)+1; %Puffs where the mouse licked (active)
        pPuffON{animal,day} = find(tmpptAct > 4)+1; %Puffs where the mouse did not lick (passive)
        
        rewLON{animal,day} = find(diff(rewL{animal,day}) > 4)+1; %Rewards from licking left
        rewRON{animal,day} = find(diff(rewR{animal,day}) > 4)+1; %Rewards from licking right
        if ~isempty(tone{animal,day})
            tone2ON{animal,day} = find(diff((conv(tone{animal,day},[1 1 1])) > 5) > 0.5); %Tone 2 onsets
            tmptone1ON{animal,day} = find(diff((conv(tone{animal,day},[1 1 1])) > 2) > 0.5); %All tone onsets
            tone1ON{animal,day} = setdiff(tmptone1ON{animal,day}+1,tone2ON{animal,day}); %Tone 1 onsets (onsets not tone 2 onsets)
            toneON{animal,day} = sort([tone1ON{animal,day} tone2ON{animal,day}]); %All Tone onsets
        end
        if ~isempty(grat{animal,day})
            grat1ON{animal,day} = find(diff(grat{animal,day}) > 3); %Grating 1 onsets
            grat2ON{animal,day} = find(diff(grat{animal,day}) < 3 & diff(grat{animal,day}) > 1); %Grating 2 onsets
            gratON{animal,day} = sort([grat1ON{animal,day} grat2ON{animal,day}]); %All grating onsets
            gratOFF{animal,day} = find(diff(grat{animal,day}) < -1); %Grating offsets
        end
              
        %Remove reward trials where it was randomly given
        rew1id = []; %Find random rewards given to the left 
        if ~isempty(rewLON{animal,day});
            for trial = 1:length(rewLON{animal,day})
                tON = rewLON{animal,day}(trial);
                if max(abs(lickL{animal,day}(tON-5:tON+1))) > 1
                    rew1id(trial) = 1;
                else
                    rew1id(trial) = 0;
                end
            end
            aRewLON{animal,day} = rewLON{animal,day}(find(rew1id == 1));
            pRewLON{animal,day} = rewLON{animal,day}(find(rew1id == 0));
        else
            aRewLON{animal,day} = []; %Rewards given when the mouse licked before (active)
            pRewLON{animal,day} = []; %Rewards given randomly (passive)
        end
        
        rew2id = []; %Find random rewards given to the right
        if ~isempty(rewRON{animal,day});
            for trial = 1:length(rewRON{animal,day})
                tON = rewRON{animal,day}(trial);
                if max(abs(lickR{animal,day}(tON-5:tON+1))) > 1
                    rew2id(trial) = 1;
                else
                    rew2id(trial) = 0;
                end
                aRewRON{animal,day} = rewRON{animal,day}(find(rew2id == 1));
                pRewRON{animal,day} = rewRON{animal,day}(find(rew2id == 0));
            end
        else
            aRewRON{animal,day} = []; %Rewards given when the mouse licked before (active)
            pRewRON{animal,day} = []; %Rewards given randomly (passive)
        end
        rewON{animal,day} = sort([aRewLON{animal,day} aRewRON{animal,day}]); %All Active rewards
        pRewON{animal,day} = sort([pRewLON{animal,day} pRewRON{animal,day}]); %All Passive rewards
        %Get onsets with as least 40 frames pre-activity
        aPuffON{animal,day} = aPuffON{animal,day}(aPuffON{animal,day} > 40);
        pPuffON{animal,day} = pPuffON{animal,day}(pPuffON{animal,day} > 40);
        rewLON{animal,day} = rewLON{animal,day}(rewLON{animal,day}  > 40);
        rewRON{animal,day} = rewRON{animal,day}(rewRON{animal,day}  > 40);
        rewON{animal,day} = rewON{animal,day}(rewON{animal,day}  > 40);
        pRewON{animal,day} = pRewON{animal,day}(pRewON{animal,day}  > 40);
        tone1ON{animal,day} = tone1ON{animal,day}(tone1ON{animal,day}  > 40);
        tone2ON{animal,day} = tone2ON{animal,day}(tone2ON{animal,day}  > 40);
        toneON{animal,day} = toneON{animal,day}(toneON{animal,day}  > 40);
        grat1ON{animal,day} = grat1ON{animal,day}(grat1ON{animal,day}  > 40);
        grat2ON{animal,day} = grat2ON{animal,day}(grat2ON{animal,day}  > 40);
        gratON{animal,day} = gratON{animal,day}(gratON{animal,day}  > 40);
        
        %Get onsets with as least 30 frames post-activity
        aPuffON{animal,day} = aPuffON{animal,day}(aPuffON{animal,day} < length(grat{animal,day})-30);
        pPuffON{animal,day} = pPuffON{animal,day}(pPuffON{animal,day} < length(grat{animal,day})-30);
        rewLON{animal,day} = rewLON{animal,day}(rewLON{animal,day} < length(grat{animal,day})-30);
        rewRON{animal,day} = rewRON{animal,day}(rewRON{animal,day} < length(grat{animal,day})-30);
        rewON{animal,day} = rewON{animal,day}(rewON{animal,day} < length(grat{animal,day})-30);
        pRewON{animal,day} = pRewON{animal,day}(pRewON{animal,day} < length(grat{animal,day})-30);
        tone1ON{animal,day} = tone1ON{animal,day}(tone1ON{animal,day} < length(grat{animal,day})-30);
        tone2ON{animal,day} = tone2ON{animal,day}(tone2ON{animal,day} < length(grat{animal,day})-30);
        toneON{animal,day} = toneON{animal,day}(toneON{animal,day} < length(grat{animal,day})-30);
        grat1ON{animal,day} = grat1ON{animal,day}(grat1ON{animal,day} < length(grat{animal,day})-30);
        grat2ON{animal,day} = grat2ON{animal,day}(grat2ON{animal,day} < length(grat{animal,day})-30);
        gratON{animal,day} = gratON{animal,day}(gratON{animal,day} < length(grat{animal,day})-30);
    end
end





