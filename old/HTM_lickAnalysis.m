%subdivide sequences into high / low lick trials

seq1_val=-5;
seq2_val=-30;
seq_win=140;
lick_th=0.1;
lick1={};
lick2={};

for siteID=1:6
    for tp=1:8
        seq1_onsets=find(round(diff(seqEleIDsig{siteID,tp})*10)==seq1_val);        
        seq2_onsets=find(round(diff(seqEleIDsig{siteID,tp})*10)==seq2_val);
        for ind=1:length(seq1_onsets)
            lick1{siteID,tp}(:,ind) = length(find(diff(Lick{siteID,tp}(1,seq1_onsets(ind):seq1_onsets(ind)+seq_win)>lick_th)==1));
        end
        for ind=1:length(seq2_onsets)
            lick2{siteID,tp}(:,ind) = length(find(diff(Lick{siteID,tp}(1,seq2_onsets(ind):seq2_onsets(ind)+seq_win)>lick_th)==1));
        end
    end
end

lick1Comb={};
lick2Comb={};
for tp=1:8
    lick1Comb{tp}=horzcat(lick2{:,tp});
    lick2Comb{tp}=horzcat(lick2{:,tp});  
end

figure;
cnt=0;
for tp=1:8
    cnt=cnt+1;
    subplot(2,4,cnt);
    histogram(lick1Comb{tp})
    xlim([-5 40])
    ylim([0 150])
end
figure;
cnt=0;
for tp=1:8
    cnt=cnt+1;
    subplot(2,4,cnt);
    histogram(lick2Comb{tp})
    xlim([-5 40])
    ylim([0 150])
end





