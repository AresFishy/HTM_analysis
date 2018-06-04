for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            tmpXcorr = [];
            for cell = 1:size(act{animal,day},1)
                tmpXcorr(cell) = mean(xcorr(act{animal,day}(cell,:),'unbiased'));
            end
            xCorrCells{animal,day} = find(tmpXcorr > 1.1);
        end
    end
end


%%

xCorrCell = {};
xCorrLag= {};
for day = 1:8
    for animal = 1:6
        cnt = 0;
        for cell1 = 1:size(act{animal,day},1)
            for cell2 = cell1+1:size(act{animal,day},1)
                str = sprintf('Animal %d Cell1 %d Cell2 %d',animal,cell1,cell2);
                [val,lags] = xcorr(smooth(act{animal,day}(cell1,:),5),smooth(act{animal,day}(cell2,:),5),500,'unbiased');
                midV=round(length(val)/2);
                midL=round(length(lags)/2);
                Vwdw = val(midL-100:midL+100);
                Lwdw = lags(midV-100:midV+100);
                [~,mV] = max(Vwdw);
                %plot(Lwdw,Vwdw);
                %ylim([min(Vwdw) min(Vwdw)+0.04])
                %xlim([-100 100])
                %title(str)
                %drawnow;
                
                %pause
                
                if max(Vwdw) > median(Vwdw) + 0.005
                    cnt = cnt + 1;
                    xCorrCell{animal,day}(cnt,:) = [cell1,cell2];
                    xCorrLag{animal,day}(cnt) = Lwdw(mV);
                end
            end
        end
    end
end
        
        
       