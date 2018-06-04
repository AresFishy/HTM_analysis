function LickLRsuccess(expID_list)
ex_l = expID_list;
data = [];
for ind = 1: length(ex_l)
    tmpdata = checkAux(ex_l(ind));  
    data = [data, tmpdata];
end
%%
%data=checkAux(68742);
%To get clear tone signe
tone = (conv(data(7,:),[1 1 1]) > 1);
lickL = conv(data(5,:),[1 1 1]);
lickR = conv(data(4,:),[1 1 1]);
toneON = find(diff(tone) > 0.5);
if toneON(end)+4000 > length(tone)
    toneON = toneON(1:end-1);
end
toneInt = [];
lickOnR = [];
lickOnL = [];
rewOnR = [];
rewOnL = [];
rewCountR = 0;
rewCountL = 0;
randRew =0;
for ind = 1:length(toneON)
    toneInt(ind,:) = toneON(ind)+2000:toneON(ind)+3999;
    
    tLickR = find(lickR(toneInt(ind,:)) < -20);
    tLickL = find(lickL(toneInt(ind,:)) < -20);
    if isempty(tLickR)
        lickOnR(ind) = NaN(1,1);
    else
        lickOnR(ind) = tLickR(1);
    end
    if isempty(tLickL)
        lickOnL(ind) = NaN(1,1);
    else
        lickOnL(ind) = tLickL(1);
    end
    
    tRewR = find(data(9,toneInt(ind,:)) > 2);
    tRewL = find(data(8,toneInt(ind,:)) > 2);
    
    if isempty(tRewR)
        rewOnR(ind) = NaN(1,1);
    else
        rewOnR(ind) = tRewR(1);
    end
    if isempty(tRewL)
        rewOnL(ind) = NaN(1,1);
    else
        rewOnL(ind) = tRewL(1);
    end
    
    tPuff = find(data(3,toneInt(ind,:)) > 2);
    if isempty(tPuff)
        puffOn(ind) = NaN(1,1);
    else
        puffOn(ind) = tPuff(1);
    end
    
    
    if ~isnan(rewOnR(ind))
        if lickOnR(ind) <= rewOnR(ind)
            if isnan(lickOnL(ind));
                rewCountR = rewCountR + 1;
            elseif lickOnR(ind) < lickOnL(ind)
                rewCountR = rewCountR + 1;
            end
        end
    end
    

    if ~isnan(rewOnL(ind))
        if lickOnL(ind) <= rewOnL(ind)
            if isnan(lickOnR(ind));
                rewCountL = rewCountL + 1;
            elseif lickOnL(ind) < lickOnR(ind)
                rewCountL = rewCountL + 1;
            end
        end
    end
         
    if isnan(lickOnR(ind)) && isnan(lickOnL(ind))
        if ~isnan(rewOnR(ind)) || ~isnan(rewOnL(ind))
            randRew = randRew + 1;
        end
    end
    if ~isnan(rewOnR(ind))
        if lickOnR(ind) >= rewOnR(ind)
            randRew = randRew + 1;
        end
    end
    if ~isnan(rewOnL(ind))
        if lickOnL(ind) >= rewOnL(ind)
            randRew = randRew + 1;
        end
    end
end

errors = length(find(~isnan(puffOn)));
rewards = rewCountR + rewCountL;
success_rate = rewards / (rewards + errors) * 100


