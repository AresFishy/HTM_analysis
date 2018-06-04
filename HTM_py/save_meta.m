function save_meta(proj_meta)

% if nargin < 2 || ~exist(destination)
%     if ~exist("C:/Code/tmp_projmeta")
%         mkdir("C:/Code/tmp_projmeta");
%         destination = 'C:/users/tmp_projmeta/';
%     end
% end
    destination = 'C:\Users\vision\Desktop\HTM_meta_py\';
for ind = 1:length(proj_meta)
    
    tmp = proj_meta(ind);
    tmp_name = strcat(destination, 'proj_meta', num2str(ind), '.mat');
    display(tmp_name)
    tmp
    save(tmp_name, 'tmp');
end