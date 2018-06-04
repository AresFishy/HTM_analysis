function view_tiff_stack_plot_aux(data, aux_data, map)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tiff viewer
% 
% data - our stack
% data2 - optional another stack with same dimensions
%         displayed next to first one
% map - optional change of colormap, default gray
%
% key control:
% 's' - scale to square
% 'm' - play as movie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 3
    map = 'gray';
end

for ind=1:size(aux_data,2)
    aux_data(:,ind)=(aux_data(:,ind)-min(aux_data(:,ind)))/(max(aux_data(:,ind))-min(aux_data(:,ind)));
end

header = 'no header info';
data2 = 0;


hf=figure;
clf;
params.button_down=0;
params.movie_status=0;
params.frame_pause=0.01; % pause in seconds between frames in playback
params.playback_spacing=1; % only every n-th frame is shown during playback default=1 (every frame)
params.as_ind=0; % index over area-selected for plotting activity

set(hf,'UserData',params);
dimensions = size(data);
dimensions2 = size(data2);

if length(dimensions2) > 2
    if dimensions(3) ~= dimensions2(3) || dimensions(2) ~= dimensions2(2)
        data2 = 0; 
        disp('Warning! Inputs do not match in size, only displaying first!');
    end;
end

dimensions2 = size(data2);
offset = 100;

if length(dimensions2)>2
    set(hf,'Position',[offset offset dimensions(2)*2+offset 1.03*dimensions(1)+offset]);
else
    set(hf,'Position',[offset offset dimensions(2)+offset 1.03*dimensions(1)+offset]);
end
frame_ind=1;
 
template=data(:,:,round(size(data,3)/2));
low_contrast_lim=prctile(reshape(template,numel(template),1),10);
high_contrast_lim=prctile(reshape(template,numel(template),1),99.99);

params.clim=[low_contrast_lim high_contrast_lim];

if length(dimensions2)>2
    params.h_f_ax=axes('position',[0 0.03 1 0.97],'color','k','clim',params.clim); 
    params.h_im_data=imagesc([data(:,:,frame_ind) data2(:,:,frame_ind)]);
else
    params.h_f_ax=axes('position',[0 0.03 0.975 0.97],'color','k','clim',params.clim);
    params.h_im_data=imagesc(data(:,:,frame_ind));
end

% set(params.h_im_data,'CDataMapping','direct');

yl=ylim;xl=xlim;
params.h_txt=text(xl(2)/20,yl(2)/20,'1','fontsize',12,'color','w','fontweight','bold');
colormap(map);
h_sl_ax=axes('position',[0 0 1 0.03],'color','k');
xlim([0 1]);
ylim([0 1]);
hold on;
sl_x_pos=0;
h_sl_bar=plot([1 1]*sl_x_pos,[0 1],'r','linewidth',20);

h_aux_ax=axes('position',[0.975 0.03 0.025 0.97],'color','k');
xlim([-1 1]);
if size(aux_data,2)==2
    xlim([-1 3])
end
ylim([0 1]);
hold on;
if size(aux_data,2)==1
    params.h_aux_data=plot([0 0],[0 aux_data(1,1)],'linewidth',10,'color','g');
elseif size(aux_data,2)==2
    disp('dfas')
    params.h_aux_data=plot([0 0],[0 aux_data(1,1)],'linewidth',5,'color','g');
    params.h_aux_data2=plot([2 2],[0 aux_data(1,2)],'linewidth',5,'color','r');
end
axis off

set(hf,'windowbuttondownfcn',@view_tiff_stack_buttdofcn);
set(hf,'windowbuttonupfcn',@view_tiff_stack_buttupfcn);
set(hf,'windowbuttonmotionfcn',{@view_tiff_stack_winmotfcn,h_sl_ax,h_sl_bar,data,data2,aux_data});
set(hf,'KeyPressFcn' ,{@view_tiff_stack_keypress,h_sl_bar,data,data2,aux_data,length(dimensions2)>2,header});
set(hf,'CloseRequestFcn',@close_fcn);
set(hf,'menubar','none','color','k');
set(params.h_f_ax,'clim',params.clim);
set(hf,'UserData',params);


function view_tiff_stack_winmotfcn(hf,e,h_sl_ax,h_sl_bar,data,data2,aux_data)
params=get(hf,'UserData');
if params.button_down
    cp=get(h_sl_ax,'currentpoint');
    cp=cp(1);
    cp=min(cp,1);
    cp=max(cp,0);
    set(h_sl_bar,'Xdata',[1 1]*cp);
    if length(size(data2))>2
        set(params.h_im_data,'CData',[data(:,:,round(cp*(size(data,3)-1))+1) data2(:,:,round(cp*(size(data,3)-1))+1)]);
    else
        set(params.h_im_data,'CData',data(:,:,round(cp*(size(data,3)-1))+1));
    end
    set(params.h_txt,'string',num2str(round(cp*(size(data,3)-1))+1));
    set(params.h_aux_data,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,1)]);
    if size(aux_data,2)==2
        set(params.h_aux_data2,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,2)]);
    end
    
end

function view_tiff_stack_buttdofcn(hf,e)
params=get(hf,'UserData');
params.button_down=1;
set(hf,'UserData',params);

function view_tiff_stack_buttupfcn(hf,e)
params=get(hf,'UserData');
params.button_down=0;
set(hf,'UserData',params);

function view_tiff_stack_keypress(hf,event,h_sl_bar,data,data2,aux_data,twosided,header)
params=get(hf,'UserData');
nFrames = size(data,3);
spacing = 1/nFrames;
switch event.Character
    case 's'  % scale
        temp = get(hf);
        figLength = temp.Position(3);
        if twosided
            set(hf,'Position',[temp.Position(1) temp.Position(2) figLength 1.06*figLength/2]);
        else
            set(hf,'Position',[temp.Position(1) temp.Position(2) figLength 1.03*figLength*size(data,1)/size(data,2)]);
        end
        
    case 'i' %info
        cp=get(h_sl_bar,'Xdata');
        cp=cp(1);
        cp = cp + spacing;
        if isstruct(header)
            msgbox(header(round(cp*(size(data,3)-1))+1).ImageDescription,['Frame nr. ' num2str(round(cp*(size(data,3)-1))+1) ]);
        else
            msgbox(header);
        end
    case 'm' % make a movie
        [avi_fname,avi_path]=uiputfile('tiff_stack.avi','save stack as');
        mov=avifile([avi_path avi_fname],'fps',23,'compression','none');
        speed_factor=input('Select speed to save movie at: ');
        frame_bounds=input('Select [start_frame stop_fram], 0 for all frames: ');
        if frame_bounds==0
            frame_bounds=[0 nFrames];
        end
        for cp=frame_bounds(1)/nFrames:spacing*speed_factor:frame_bounds(2)/nFrames
            set(h_sl_bar,'Xdata',[1 1]*cp);
            if length(size(data2))>2
                set(params.h_im_data,'CData',[data(:,:,round(cp*(nFrames-1))+1) data2(:,:,round(cp*(nFrames-1))+1)]);
            else
                set(params.h_im_data,'CData',mean(data(:,:,round(cp*(nFrames-1)+1):min(size(data,3),round(cp*(nFrames-1))+speed_factor)),3));
            end
            set(params.h_txt,'string',num2str(round(cp*(nFrames-1))+1));
            set(params.h_aux_data,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,1)]);
            if size(aux_data,2)==2
                set(params.h_aux_data2,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,2)]);
            end
            frame = getframe(gcf);
            mov = addframe(mov,frame);
            %imwrite(frame2im(frame),[avi_path avi_fname],'tiff','writemode','append');
        end
        mov = close(mov);
    case 'a' % show activity of selected area
        params.as_ind=params.as_ind+1;
        color_ind='mgycrbw';
        as=ginput(2);
        hold on
        plot([as(2) as(2) as(1) as(1) as(2)],[as(4) as(3) as(3) as(4) as(4)],color_ind(params.as_ind));
        as_x=round(sort([as(3) as(4)]));
        as_y=round(sort([as(1) as(2)]));
        fig_pos=get(gcf,'position');
        if isfield(params,'sup_fig_h') && ishandle(params.sup_fig_h)
            set(params.sup_fig_h,'position',[fig_pos(1) fig_pos(2)-100-33 fig_pos(3) 100]);
        else
            params.sup_fig_h=figure('position',[fig_pos(1) fig_pos(2)-100-33 fig_pos(3) 100],'menubar','none','color','k');
            axes('position',[0 0 1 1],'color','k');
            hold on
        end
        prev_fig_handle=gcf;
        figure(params.sup_fig_h);
        try
            temp = squeeze(mean(mean(data(as_x(1):as_x(2),as_y(1):as_y(2),:),2),1));
            if params.as_ind == 1
            plot(aux_data*2*mean(temp));
            end
            plot(temp,color_ind(params.as_ind));
        catch
            disp('try again - selection not valid');
        end
        axis tight;
        figure(prev_fig_handle);
        set(hf,'UserData',params);
    case 't' % show template
        fig_pos=get(gcf,'position');
        prev_fig_handle=gcf;
        if isfield(params,'sup_fig2_h') && ishandle(params.sup_fig2_h)
            set(params.sup_fig2_h,'position',[fig_pos(1)+fig_pos(3) fig_pos(2) fig_pos(3) fig_pos(4)]);
            figure(params.sup_fig2_h);
        else
            params.sup_fig2_h=figure('position',[fig_pos(1)+fig_pos(3) fig_pos(2) fig_pos(3) fig_pos(4)],'menubar','none');
        end
        axes('position',[0 0 1 1]);
        imagesc(mean(data,3));colormap gray;
        set(gca,'clim',params.clim)
        axis off
        figure(prev_fig_handle);
        set(hf,'UserData',params);
    case 'c' % clear
        hold off
        cp=get(h_sl_bar,'Xdata');
        cp=cp(1);
        axes(params.h_f_ax);
        params.h_im_data=imagesc(data(:,:,round(cp*(size(data,3)-1))+1));
        set(params.h_f_ax,'clim',params.clim,'xtick',[]);
        yl=ylim;xl=xlim;
        params.h_txt=text(xl(2)/20,yl(2)/20,num2str(round(cp*(size(data,3)-1))+1),'fontsize',12,'color','w','fontweight','bold');
        if isfield(params,'sup_fig_h') && ishandle(params.sup_fig_h)
            close(params.sup_fig_h);
        end
        if isfield(params,'sup_fig2_h') && ishandle(params.sup_fig2_h)
            close(params.sup_fig2_h);
        end
        params.as_ind=0;
        set(hf,'UserData',params);
        
end

switch event.Key
    case 'rightarrow'
        cp=get(h_sl_bar,'Xdata');
        cp=cp(1);
        cp = cp + spacing;
        if cp > 1, cp = 1; end;
        set(h_sl_bar,'Xdata',[1 1]*cp);
        if length(size(data2))>2
            set(params.h_im_data,'CData',[data(:,:,round(cp*(size(data,3)-1))+1) data2(:,:,round(cp*(size(data,3)-1))+1)]);
        else
            set(params.h_im_data,'CData',data(:,:,round(cp*(size(data,3)-1))+1));
        end
        set(params.h_txt,'string',num2str(round(cp*(size(data,3)-1))+1));
        set(params.h_aux_data,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,1)]);
        if size(aux_data,2)==2
            set(params.h_aux_data2,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,2)]);
        end
        
    case 'leftarrow'
        cp=get(h_sl_bar,'Xdata');
        cp=cp(1);
        cp = cp - spacing;
        if cp < 0, cp = 0; end;
        set(h_sl_bar,'Xdata',[1 1]*cp);
        if length(size(data2))>2
            set(params.h_im_data,'CData',[data(:,:,round(cp*(size(data,3)-1))+1) data2(:,:,round(cp*(size(data,3)-1))+1)]);
        else
            set(params.h_im_data,'CData',data(:,:,round(cp*(size(data,3)-1))+1));
        end
        set(params.h_txt,'string',num2str(round(cp*(size(data,3)-1))+1));
        set(params.h_aux_data,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,1)]);
        if size(aux_data,2)==2
            set(params.h_aux_data2,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,2)]);
        end
        
    case 'uparrow'
        params=get(hf,'UserData');
        if params.frame_pause<=0.01
            params.playback_spacing=params.playback_spacing*2;
        else
            params.frame_pause=params.frame_pause*0.5;
        end
        set(hf,'UserData',params);
        
    case 'downarrow'
        params=get(hf,'UserData');
        if params.playback_spacing>1
            params.playback_spacing=params.playback_spacing/2;
        else
            params.frame_pause=params.frame_pause*2;
        end
        set(hf,'UserData',params);
        
    case 'space'   % play as movie
        params.movie_status=~params.movie_status;
        set(hf,'UserData',params);
        cp=get(h_sl_bar,'Xdata');
        cp=cp(1);
        while params.movie_status
            params=get(hf,'UserData');
            cp = cp + spacing*params.playback_spacing;
            if cp > 1, cp = 0; end;
            set(h_sl_bar,'Xdata',[1 1]*cp);
            if length(size(data2))>2
                set(params.h_im_data,'CData',[data(:,:,round(cp*(size(data,3)-1))+1) data2(:,:,round(cp*(size(data,3)-1))+1)]);
            else
                set(params.h_im_data,'CData',data(:,:,round(cp*(size(data,3)-1))+1));
            end
            set(params.h_txt,'string',num2str(round(cp*(size(data,3)-1))+1));
            set(params.h_aux_data,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,1)]);
            if size(aux_data,2)==2
                set(params.h_aux_data2,'ydata',[0 aux_data(round(cp*(size(data,3)-1))+1,2)]);
            end
            pause(params.frame_pause);
        end
end

function close_fcn(hf,e)
params=get(hf,'UserData');
if isfield(params,'sup_fig_h') && ishandle(params.sup_fig_h)
    close(params.sup_fig_h);
end
if isfield(params,'sup_fig2_h') && ishandle(params.sup_fig2_h)
    close(params.sup_fig2_h);
end
delete(hf)






