% Specify top directory
top_dir = '/Volumes/MAC/Thesis/Behavior/CP_IP/scanbehavior/';
cd(top_dir);

% Initialize cell structure
anglemetric = cell(2,2);
anglemetric{1,1} = cell(1);
anglemetric{2,1} = cell(1);
anglemetric{1,2} = 'Pre';
anglemetric{2,2} = 'Post';

% Grab all subject folders
subjs = dir('*scan');
anglemetric{1,1} = cell(length(subjs),2);

% Loop over all subjects
for i = 1:length(subjs)
    
    % Grab subject identifier
    id = subjs(i).name(1:2);
    anglemetric{1,1}{i,2} = id;
    
    % Move into subject directory
    cd(subjs(i).name);
    
    % Specify preTraining/postTraining directories
    pre_dir = [id 'preTraining'];
    post_dir = [id 'postTraining'];
    
    %-- PRE --
    % Move into preTraining directory
    cd (pre_dir);
    
    % Grab all angle metric files
    angmet = dir('*anglemetric*');
    
    % Calculate number of scans
    numScans = length(angmet) / 4;
    anglemetric{1,1}{i,1} = cell(numScans,2); % based on scan #
    
    % Loop through each scan
    for j = 1:numScans
        
        % Expand cell to accomodate
        anglemetric{1,1}{i,1}{j,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,2} = ['Scan' num2str(j)];
        
        anglemetric{1,1}{i,1}{j,1}{1,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,1}{1,2} = '45';
        anglemetric{1,1}{i,1}{j,1}{2,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,1}{2,2} = '135';
        
        anglemetric{1,1}{i,1}{j,1}{1,1}{1,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,1}{1,1}{1,2} = 'CP';
        anglemetric{1,1}{i,1}{j,1}{1,1}{2,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,1}{1,1}{2,2} = 'IP';
        anglemetric{1,1}{i,1}{j,1}{2,1}{1,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,1}{2,1}{1,2} = 'CP';
        anglemetric{1,1}{i,1}{j,1}{2,1}{2,1} = cell(2,2);
        anglemetric{1,1}{i,1}{j,1}{2,1}{2,2} = 'IP';
        
        anglemetric{1,1}{i,1}{j,1}{1,1}{1,1}{1,2} = 'B1';
        anglemetric{1,1}{i,1}{j,1}{1,1}{1,1}{2,2} = 'B2';
        anglemetric{1,1}{i,1}{j,1}{1,1}{2,1}{1,2} = 'B1';
        anglemetric{1,1}{i,1}{j,1}{1,1}{2,1}{2,2} = 'B2';
        anglemetric{1,1}{i,1}{j,1}{2,1}{1,1}{1,2} = 'B1';
        anglemetric{1,1}{i,1}{j,1}{2,1}{1,1}{2,2} = 'B2';
        anglemetric{1,1}{i,1}{j,1}{2,1}{2,1}{1,2} = 'B1';
        anglemetric{1,1}{i,1}{j,1}{2,1}{2,1}{2,2} = 'B2';
        
        % Grab CP 45 data
        angmet = dir(['*' num2str(j) '_*anglemetric*i45*']);
        
        % Specify file name
        file_str = angmet(j).name;
        
        % Read from file
        fid = fopen([file_str], 'r');
        idx = [];
        s = zeros(2,10);
        
        % Find occurences and save values
        for k = 1:23
            
            % Get next line
            line = fgets(fid);
            
            % Skip misc. lines
            if (k == 11 || k == 12 || k == 13)
                continue
            end
            
            % Look for "anti"
            idx = regexp(line, 'anti');
            
            if (k <= 10)
                if (isempty(idx))
                    s(1,k) = 1;
                else
                    s(1,k) = -1;
                end
            else
                if (isempty(idx))
                    s(2,k-13) = 1;
                else
                    s(2,k-13) = -1;
                end
            end
            
            idx = [];
        end
        fclose(fid);
        
        % Save into cell
        anglemetric{1,1}{i,1}{j,1}{1,1}{1,1}{1,1} = s(1,:);
        anglemetric{1,1}{i,1}{j,1}{1,1}{1,1}{2,1} = s(2,:);
        
        %--
        
        % Grab CP 135 data
        angmet = dir(['*' num2str(j) '_*anglemetric*i135*']);
        
        % Specify file name
        file_str = angmet(j).name;
        
        % Read from file
        fid = fopen([file_str], 'r');
        idx = [];
        s = zeros(2,10);
        
        % Find occurences and save values
        for k = 1:23
            
            % Get next line
            line = fgets(fid);
            
            % Skip misc. lines
            if (k == 11 || k == 12 || k == 13)
                continue
            end
            
            % Look for "anti"
            idx = regexp(line, 'anti');
            
            if (k <= 10)
                if (isempty(idx))
                    s(1,k) = 1;
                else
                    s(1,k) = -1;
                end
            else
                if (isempty(idx))
                    s(2,k-13) = 1;
                else
                    s(2,k-13) = -1;
                end
            end
            
            idx = [];
        end
        fclose(fid);
        
        % Save into cell
        anglemetric{1,1}{i,1}{j,1}{2,1}{1,1}{1,1} = s(1,:);
        anglemetric{1,1}{i,1}{j,1}{2,1}{1,1}{2,1} = s(2,:);
        
        %--
        
        % Grab IP 45 data
        angmet = dir(['*' num2str(j) '_*anglemetric*inphase45*']);
        
        % Specify file name
        file_str = angmet(j).name;
        
        % Read from file
        fid = fopen([file_str], 'r');
        idx = [];
        s = zeros(2,10);
        
        % Find occurences and save values
        for k = 1:23
            
            % Get next line
            line = fgets(fid);
            
            % Skip misc. lines
            if (k == 11 || k == 12 || k == 13)
                continue
            end
            
            % Look for "anti"
            idx = regexp(line, 'anti');
            
            if (k <= 10)
                if (isempty(idx))
                    s(1,k) = 1;
                else
                    s(1,k) = -1;
                end
            else
                if (isempty(idx))
                    s(2,k-13) = 1;
                else
                    s(2,k-13) = -1;
                end
            end
            
            idx = [];
        end
        fclose(fid);
        
        % Save into cell
        anglemetric{1,1}{i,1}{j,1}{1,1}{2,1}{1,1} = s(1,:);
        anglemetric{1,1}{i,1}{j,1}{1,1}{2,1}{2,1} = s(2,:);
        
        %--
        
        % Grab IP 135 data
        angmet = dir(['*' num2str(j) '_*anglemetric*inphase135*']);
        
        % Specify file name
        file_str = angmet(j).name;
        
        % Read from file
        fid = fopen([file_str], 'r');
        idx = [];
        s = zeros(2,10);
        
        % Find occurences and save values
        for k = 1:23
            
            % Get next line
            line = fgets(fid);
            
            % Skip misc. lines
            if (k == 11 || k == 12 || k == 13)
                continue
            end
            
            % Look for "anti"
            idx = regexp(line, 'anti');
            
            if (k <= 10)
                if (isempty(idx))
                    s(1,k) = 1;
                else
                    s(1,k) = -1;
                end
            else
                if (isempty(idx))
                    s(2,k-13) = 1;
                else
                    s(2,k-13) = -1;
                end
            end
            
            idx = [];
        end
        fclose(fid);
        
        % Save into cell
        anglemetric{1,1}{i,1}{j,1}{2,1}{2,1}{1,1} = s(1,:);
        anglemetric{1,1}{i,1}{j,1}{2,1}{2,1}{2,1} = s(2,:);
        
    end
    
    %-- POST --
    % Move into postTraining directory
    %cd (post_dir);
end


% Output
%{
for i = 1:2
    fprintf(['Block ' num2str(i) ': \n']);
    for j = 1:10
        %fid = fopen([fileprefix filenum '_' num2str(i) '.txt'],'w');
        %fprintf(fid, [ num2str(s(i,1)) ' ' num2str(TR) ' ' num2str(Offset) '\n']);
        %fprintf(fid, [ num2str(s(i,2)) ' ' num2str(TR) ' ' num2str(Offset) '\n']);
        if i == 1
            fprintf([num2str(s(i,j)) '\n']);
        else
            fprintf([num2str(s(i,j)) '\n']);
        end
        %fclose(fid);
    end
end
%}