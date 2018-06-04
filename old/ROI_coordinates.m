%Find the center of each ROI

%Get XY coordinates for each ROI
imgSize = [400,750];

cnt = 1;
for pm = [1:6];
    for rd = 1:4
        for ROI = 1:length(proj_meta(pm).rd(rd,1).ROIinfo)
            [tmpYC tmpXC] = ind2sub(imgSize,proj_meta(pm).rd(rd,1).ROIinfo(ROI).indices);
            roiCoord{cnt} = [tmpXC tmpYC];
            roiLayer(cnt) = rd;
            cnt = cnt + 1;
        end
    end
end

%Get centroid for each ROI
for roi = 1:length(roiCoord);
    roiCntrX(roi) = round((max(roiCoord{roi}(:,1))-min(roiCoord{roi}(:,1)))/2 + min(min(roiCoord{roi}(:,1))));
    roiCntrY(roi) = round((max(roiCoord{roi}(:,2))-min(roiCoord{roi}(:,2)))/2 + min(min(roiCoord{roi}(:,2))));
end

