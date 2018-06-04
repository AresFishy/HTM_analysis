for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2);
        cntNEU=cntNEU+1;
        acttmp=act2mat(proj_meta,siteID,tp);
        maxAct{siteID,cntNEU} = max(acttmp,[],2);
    end
end

%%
tmpCor = [];
for animal = 1:9
    for day1 = 1:7
        for day2 = 1:7
            tmpCor(day1,day2,animal) = corr(maxAct{animal,day1},ieg_exp_cell{animal,tps_exp(day2)},'type','pearson');
        end
    end
end

tmpArcCor = mean(tmpCor(:,:,1:4),3);
tmpCfosCor = mean(tmpCor(:,:,5:9),3);

subplot(221)
imagesc(tmpArcCor);
colormap jet;
set(gca,'clim',[0 0.5])
xlabel('Max Act'); ylabel('mean IEG'); title('Arc')

subplot(222)
imagesc(tmpCfosCor);
colormap jet;
set(gca,'clim',[0 0.5])
xlabel('Max Act'); ylabel('mean IEG'); title('c-Fos')

subplot(223)
for ind = [-7:7]
    if ind < 0
        bar(abs(ind),mean(diag(tmpArcCor,ind)),'FaceColor','r'); hold on
    elseif ind == 0;
        bar(abs(ind),mean(diag(tmpArcCor,ind)),'FaceColor','k');
    else
        bar(abs(ind),mean(diag(tmpArcCor,ind)),'FaceColor','b');
    end
end
xlim([-1 7]); ylim([0 0.5])
set(gca,'XTick',[0 1 2 3 4 5 6],'XTickLabel',{'N','N+-1','N+-2','N+-3','N+-4','N+-5','N+-6'})

subplot(224)
for ind = [-7:7]
    if ind < 0
        bar(abs(ind),mean(diag(tmpCfosCor,ind)),'FaceColor','r'); hold on
    elseif ind == 0;
        bar(abs(ind),mean(diag(tmpCfosCor,ind)),'FaceColor','k');
    else
        bar(abs(ind),mean(diag(tmpCfosCor,ind)),'FaceColor','b');
    end
end
xlim([-1 7]); ylim([0 0.5])
set(gca,'XTick',[0 1 2 3 4 5 6],'XTickLabel',{'N','N+-1','N+-2','N+-3','N+-4','N+-5','N+-6'})
