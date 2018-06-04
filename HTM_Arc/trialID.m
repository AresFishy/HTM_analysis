%Get trial IDs
rewTrial = {};
puffTrial = {};
rewON = {};
puffON = {};
for day = 1:8
    for animal = 1:4
        for trial = 1:length(puffON{animal,day})
            if mean(grat{animal,day}(puffON{animal,day}(trial))) > 3
                g1pTrial{animal,day}
            else
                g2p
            end
    end
end

