function []=HTM_beh
%get behavioral performance 
%DM 2016

siteIDs=1:6;
tps=1:8;
RewardSuccess=[];
SuccessRatio=[];
RewardCat={};
SeqIDCat={};
SeqOnCat={};
win_size=50;

%concatenate signals for every animal over all days
for siteID=siteIDs
RewardCat{siteID} = horzcat(reward{siteID,1:6});
SeqEleIDsigCat{siteID} = horzcat(seqEleIDsig{siteID,1:6});
end

%%

%calculate reward success with sliding window
for siteID=siteIDs
    cnt=1;
    win_cnt=1;
    seq_frames=find(diff(round(SeqEleIDsigCat{siteID}*10))>1);
    seq_frames=seq_frames(:,5:5:end);
    for jnd=win_size:win_size:size(seq_frames,2)
        RewardSuccess(siteID,win_cnt) = ( length(find(diff(RewardCat{siteID}(seq_frames(cnt):seq_frames(jnd)+100))==1)) / win_size )  * 100;
        cnt=cnt+win_size;
        win_cnt=win_cnt+1;
    end
end
figure;plot(((RewardSuccess)'),'--')
line([xlim],[50 50],'color','k')

%%
checkerboardOnset={};
LickQuantification={};
FirstLick={};
LickFreq={};
LickFreqBin={};
LickBin=[];
AntLick={};
Latency=[];
AntFreq=[];
seq1_vo=25;
seq2_vo=50;
%calculate latency to lick after checkerboard onset
%get onset frames of checkerboard flash
win_r = 30*10^2;
win_l = 20*10^2;
for tp=tps
    for siteID=siteIDs
        checkerboardOnset{siteID,tp,1} = sort(find(diff(round(seqEleIDsig{siteID,tp}*10))==seq1_vo)*10^2+win_r);
        checkerboardOnset{siteID,tp,2} = sort(find(diff(round(seqEleIDsig{siteID,tp}*10))==seq2_vo)*10^2+win_r);
    end
end

%get lick signal around 5sec window of checkerboard onset
%get frame of first lick after checkerboard onset
lick_th = 0.1;
lat_win=3001:5000;
ant_win=1500:2000;
for seq_ind=1:2
for tp=tps
    cnt=0;
    for siteID=siteIDs
        for ind=1:size(checkerboardOnset{siteID,tp,seq_ind},2)
            cnt=cnt+1;
            LickQuantification{siteID,tp,seq_ind}(ind,:) = lick{siteID,tp}(checkerboardOnset{siteID,tp,seq_ind}(1,ind)-win_l : checkerboardOnset{siteID,tp,seq_ind}(1,ind)+win_r);
            LickFreq{tp,seq_ind}(cnt,:) = lick{siteID,tp}(checkerboardOnset{siteID,tp,seq_ind}(1,ind)-win_l : checkerboardOnset{siteID,tp,seq_ind}(1,ind)+win_r);
            tmp_frames_lat = find(diff(LickQuantification{siteID,tp,seq_ind}(ind,lat_win)>lick_th)==1);
            tmp_frames_ant = find(diff(LickQuantification{siteID,tp,seq_ind}(ind,ant_win)>lick_th)==1);
            if ~isempty(tmp_frames_lat)
                FirstLick{siteID,tp,seq_ind}(ind) = tmp_frames_lat(1);
                AntLick{siteID,tp,seq_ind}(ind) = length(tmp_frames_ant) / (length(ant_win)/1000);
            else
                FirstLick{siteID,tp,seq_ind}(ind) = NaN;
            end 
        end
    end
end

for siteID=siteIDs
    for tp=tps
        Latency(siteID,tp,seq_ind) = nanmean(FirstLick{siteID,tp,seq_ind});
        AntFreq(siteID,tp,seq_ind) = nanmean(AntLick{siteID,tp,seq_ind});
    end
end


%binned lick frequency after checkerboard onset
for tp=tps  
    frames_bin=round(linspace(2001,5000,10));
    for ind=1:size(frames_bin,2)-1
        for jnd=1:size(LickFreq{tp,seq_ind},1)
            LickFreqBin{tp,seq_ind}(jnd,ind) = length(find(diff(LickFreq{tp,seq_ind}(jnd,frames_bin(ind):frames_bin(ind+1))>lick_th)==1));
        end           
    end
    LickBin(:,tp,seq_ind) = nanmean(LickFreqBin{tp,seq_ind},1);
end
end
    %%
figure;
cnt=0;
for tp=1:8
    cnt=cnt+1;
    subplot(2,4,cnt);hold on
    for seq_ind=1:2
    plot(nanmean(LickBin(:,tp,seq_ind),2)*10,'-')
%     ylim([0.5 2.5]);
    end
end


tp=5:6;
figure;hold on
for seq_ind=1:2
    plot(nanmean(LickBin(:,tp,seq_ind),2)*10,'-')
end


