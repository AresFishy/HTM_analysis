%convert rew1 rew2 puff1 and puff2 to universal indices
rew1G = {};
rew2G = {};
puff1G = {};
puff2G = {};
for day = 1:8
    for animal = 1:6
        seq1RP{animal,day} = zeros(length(seqStart1{animal,day}),1);
        seq2RP{animal,day} = ones(length(seqStart2{animal,day}),1);
        seq1RP{animal,day}(rew1{animal,day}) = 2;
        seq2RP{animal,day}(rew2{animal,day}) = 3;
        seqRP{animal,day} = [seq1RP{animal,day};seq2RP{animal,day}];
        [~,seqSort{animal,day}] = sort([seqStart1{animal,day} seqStart2{animal,day}]);
        seqRPsort{animal,day} = seqRP{animal,day}(seqSort{animal,day});
        
        rew1G{animal,day} = find(seqRPsort{animal,day} == 2);
        rew2G{animal,day} = find(seqRPsort{animal,day} == 3);
        puff1G{animal,day} = find(seqRPsort{animal,day} == 0);
        puff2G{animal,day} = find(seqRPsort{animal,day} == 1);
    end
end