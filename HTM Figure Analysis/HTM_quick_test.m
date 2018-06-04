%plot tone resp


%sel_1 selects for cells that are the top10% Arc expressing cells (average
%IEg level across all 7 days)
%sel_2 same for cfos


figure;hold on
aaa=[];
aaa(:,:,1)=tone_respComb{2}(logical(sel2(:,1)),:);
aaa(:,:,2)=tone_respComb{3}(logical(sel2(:,1)),:);


aaa(:,:,3)=tone_respComb{6}(logical(sel2(:,1)),:);
aaa(:,:,4)=tone_respComb{7}(logical(sel2(:,1)),:);

clrind='bb';
lstyle={'-','--'};
sub_win=10:20;
for tp=1:2
    if tp==1
        tps=1:2;
    else
        tps=3:4;
    end
    subplot(1,2,1);hold on
y=nanmean(bsxfun(@minus,nanmean(aaa(:,:,tps),3),nanmean(nanmean(aaa(:,sub_win,tps),2),3)));
s=nanSEM(bsxfun(@minus,nanmean(aaa(:,:,tps),3),nanmean(nanmean(aaa(:,sub_win,tps),2),3)));
shadedErrorBar(1:201,y,s,{'color',clrind(tp),'linestyle',lstyle{tp}})
end
title('tone resp high Arc')



aaa=[];
aaa(:,:,1)=tone_respComb{2}(logical(sel2(:,2)),:);
aaa(:,:,2)=tone_respComb{3}(logical(sel2(:,2)),:);


aaa(:,:,3)=tone_respComb{6}(logical(sel2(:,2)),:);
aaa(:,:,4)=tone_respComb{7}(logical(sel2(:,2)),:);

clrind='bb';
lstyle={'-','--'};
sub_win=10:20;
for tp=1:2
    if tp==1
        tps=1:2;
    else
        tps=3:4;
    end
    subplot(1,2,2);hold on
y=nanmean(bsxfun(@minus,nanmean(aaa(:,:,tps),3),nanmean(nanmean(aaa(:,sub_win,tps),2),3)));
s=nanSEM(bsxfun(@minus,nanmean(aaa(:,:,tps),3),nanmean(nanmean(aaa(:,sub_win,tps),2),3)));
shadedErrorBar(1:201,y,s,{'color',clrind(tp),'linestyle',lstyle{tp}})
end

title('tone resp high cfos')

