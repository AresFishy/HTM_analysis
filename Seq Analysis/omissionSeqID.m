%Get ID of sequences containing an omission
seqOM = {};
seqOMID = {};
for day = 1:8
    for animal = 1:6
        seqOM{animal,day} = find(seqEleID{animal,day} == 1);
        seqOMID{animal,day} = zeros(length(seqEleID{animal,day}),1);
        for om = 1:length(seqOM{animal,day})
            seqOMID{animal,day}(seqOM{animal,day}(om)-3:seqOM{animal,day}(om)+1) = 1;
        end
    end
end