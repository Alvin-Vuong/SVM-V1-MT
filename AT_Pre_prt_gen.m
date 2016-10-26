% Specify location of file
directory = 'C:Users/Alvin/Desktop/Mac/Task1/';
cd(directory);

% Loop over files
for f = 1:3
    fileprefix = 'scan';
    filenum = num2str(f);
    filetype = '.prt';

    % Read from file
    fid = fopen([fileprefix filenum filetype], 'r');
    idx = [];
    s = zeros(4,2);

    % Find occurences and save values
    for i = 1:4
        while isempty(idx)
            line = fgets(fid);
            idx = regexp(line, 'trained_[ic]p');
        end

        line = fgets(fid);
        line = fgets(fid);

        idx = regexp(line, '\s.*');
        s(i,1) = str2double(line(1:idx-1));

        line = fgets(fid);

        idx = regexp(line, '\s.*');
        s(i,2) = str2double(line(1:idx-1));

        idx = [];
    end
    fclose(fid);

    % Constants
    TR = 2.5;
    Offset = 1;

    % Output to files
    for i = 1:4
        fid = fopen([fileprefix filenum '_' num2str(i) '.txt'],'w');
        fprintf(fid, [ num2str(s(i,1)) ' ' num2str(TR) ' ' num2str(Offset) '\n']);
        fprintf(fid, [ num2str(s(i,2)) ' ' num2str(TR) ' ' num2str(Offset) '\n']);
        fclose(fid);
    end
end

