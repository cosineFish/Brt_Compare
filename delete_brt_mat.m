function delete_brt_mat
    fileNamesStr = {'num_HRA001.mat','brt_HRA001.mat',...
        'brtData_xtick.mat','brt_RPG.mat','averageBrt.mat'};
    for i = 1:length(fileNamesStr)
        file = fullfile(cd,fileNamesStr{i});
        if(exist(file,'file')~=0)
            delete(file);
        end
    end
end