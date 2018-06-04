%Subidvide ROI coordinates based on animal 

cellVector = [0, 361, 135, 387, 249, 324, 279]; %Number of cells per animal
cellVectorSum = cumsum(cellVector);

for animal = 1:6
    roiX{animal} = roiCntrX(cellVectorSum(animal)+1:cellVectorSum(animal+1));
    roiY{animal} = roiCntrY(cellVectorSum(animal)+1:cellVectorSum(animal+1));
end

for animal = 1:6
    subplot(3,2,animal)
    plot(roiX{animal},roiY{animal},'.b')
end