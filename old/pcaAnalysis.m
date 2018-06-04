%PCA analysis
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            CovMatR = cov(seqActMeanRew{animal,day}');
            [Vr,Dr] = eigs(CovMatR,4);
            CovMatP = cov(seqActMeanPuff{animal,day}');
            [Vp,Dp] = eigs(CovMatP,4);
            
            eig = 1; %Which eigenvector coefficient to use for grouping cells
            
            % [~,sortV] = sort(V(:,eig)); %Plot eigenvector coefficients
            % figure;
            % imagesc(V(sortV,:))
            % set(gca,'clim',[-0.01 0.01])
            % ylabel('Cell #')
            % xlabel('Eigenvector')
            
            pcaCellNrew{animal,day} = find(Vr(:,eig) < -0.02); %Top 200 Cells with negative coefficient
            pcaCellPrew{animal,day} = find(Vr(:,eig) > 0.02); %All Intermediary cells
            pcaCellIrew{animal,day} = find(Vr(:,eig) > -0.001 & Vr(:,1) < 0.001); %Top 200 Cells with positive coefficient
            
            pcaCellNpuff{animal,day} = find(Vp(:,eig) < -0.02); %Top 200 Cells with negative coefficient
            pcaCellPpuff{animal,day} = find(Vp(:,eig) > 0.02); %All Intermediary cells
            pcaCellIpuff{animal,day} = find(Vp(:,eig) > -0.001 & Vp(:,1) < 0.001); %Top 200 Cells with positive coefficient
            
        end
    end
    cellVector = [0, 361, 135, 387, 249, 324]; %Number of cells per animal
    pcaCellNCombR{day} = []; 
    pcaCellPCombR{day} = []; 
    pcaCellICombR{day} = []; 
    pcaCellNCombP{day} = []; 
    pcaCellPCombP{day} = []; 
    pcaCellICombP{day} = []; 
    
    for animal = 1:6;
        pcaCellNCombR{day} = [pcaCellNCombR{day}; pcaCellNrew{animal,day}+sum(cellVector(1:animal))];
        pcaCellPCombR{day} = [pcaCellPCombR{day}; pcaCellPrew{animal,day}+sum(cellVector(1:animal))];
        pcaCellICombR{day} = [pcaCellICombR{day}; pcaCellIrew{animal,day}+sum(cellVector(1:animal))];
        pcaCellNCombP{day} = [pcaCellNCombP{day}; pcaCellNpuff{animal,day}+sum(cellVector(1:animal))];
        pcaCellPCombP{day} = [pcaCellPCombP{day}; pcaCellPpuff{animal,day}+sum(cellVector(1:animal))];
        pcaCellICombP{day} = [pcaCellICombP{day}; pcaCellIpuff{animal,day}+sum(cellVector(1:animal))];
    end
    
end


%%
day = 5;


figure;
subplot(121)
plotSEM(seqActComb{day}(pcaCellNCombR{day},:)')
plotSEM(seqActComb{day}(pcaCellPCombR{day},:)')
plotSEM(seqActComb{day}(pcaCellICombR{day},:)')
ylabel('dF/F')
xlabel('Frame #')
legend({'pcaCellI','pcaCellN','pcaCellP'})
subplot(122)
plotSEM(OnsetActComb{day}(pcaCellNCombR{day},:)')
plotSEM(OnsetActComb{day}(pcaCellPCombR{day},:)')
plotSEM(OnsetActComb{day}(pcaCellICombR{day},:)')
ylabel('dF/F')
xlabel('Frame #')
legend({'pcaCellI','pcaCellN','pcaCellP'})

% figure;
% plot3(V(:,1),V(:,2),V(:,3),'.')
% ylim([-0.1 0.1])
% xlim([-0.1 0.1])
% zlim([-0.1 0.1])