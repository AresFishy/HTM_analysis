animal = 5;
zl = 4;

nROIs = size(proj_meta(animal).rd(zl,1).ROIinfo,2);
ROIs = 1:size(proj_meta(animal).rd(zl,1).ROIinfo,2);
imgSizeX = 40;
imgSizeY = 20;
templateSize = [400 750];
%Set the half-width of each plot.
xSize = round(imgSizeX/2);
ySize = round(imgSizeY/2);

%ROI1 = [35 39 40 41 43 45 46 48 49 51 55 58 59 61 63 64 65 66 67 68 70 72 76 77];

for ROI = 4:length(ROIs)
    cnt = 0;
     %Used for plotting
    str = sprintf('Animal %d ROI %d Layer %d',animal,ROI,zl);
    for tp = 1:size(proj_meta(animal).rd,2);
        cnt = cnt + 1;
        [yROI xROI] = ind2sub(templateSize,proj_meta(animal).rd(zl,tp).ROIinfo(ROIs(ROI)).indices);
        
        %Find ROI center
        yROIcntr = round((max(yROI)-min(yROI))/2) + min(yROI);
        xROIcntr = round((max(xROI)-min(xROI))/2) + min(xROI);
        %Set ROI display size (+/- pixels)
        yROImax = yROIcntr + ySize;
        yROImin = yROIcntr - ySize;
        xROImax = xROIcntr + xSize;
        xROImin = xROIcntr - xSize;
        if mod(cnt,2) ~= 0 
            subplot(2,8,cnt-(cnt-1)/2) %size(proj_meta(animal).rd,2)
            imagesc(proj_meta(animal).rd(zl,tp).template(yROImin:yROImax,xROImin:xROImax))
            colormap gray
            set(gca,'xtick',[],'ytick',[]) 
        else
            subplot(2,8,(cnt-cnt/2)+8) %size(proj_meta(animal).rd,2)
            imagesc(proj_meta(animal).rd(zl,tp).template(yROImin:yROImax,xROImin:xROImax))
            colormap gray
            set(gca,'xtick',[],'ytick',[]) 
        end
        
    end
    title(str)
    pause
end

