%Bin data in time
seqActBin1 = {};
seqActBinMean1 = {};
seqActBinComb1 = {};
seqActBin2 = {};
seqActBinMean2 = {};
seqActBinComb2 = {};
binVector = round(linspace(1,200,41));
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            for bin = 1:length(binVector)-1
                for cell = 1:size(seqAct1{animal,day},1)
                    seqActBin1{animal,day}(cell,:,bin) = nanmean(seqAct1{animal,day}(cell,:,binVector(bin):binVector(bin+1)),3);
                end
                for cell = 1:size(seqAct2{animal,day},1)
                    seqActBin2{animal,day}(cell,:,bin) = nanmean(seqAct2{animal,day}(cell,:,binVector(bin):binVector(bin+1)),3);
                end
            end
            seqActBinMean1{animal,day} = squeeze(mean(seqActBin1{animal,day},2));
            seqActBinMean2{animal,day} = squeeze(mean(seqActBin2{animal,day},2));
        else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct
            seqActBinMean1{animal,day} = NaN(size(act{animal,2},1),40);
            seqActBinMean2{animal,day} = NaN(size(act{animal,2},1),40);
        end
        seqActBinComb1{day} = vertcat(seqActBinMean1{:,day});
        seqActBinComb2{day} = vertcat(seqActBinMean2{:,day});
    end
end