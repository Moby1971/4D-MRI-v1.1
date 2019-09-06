function export_dicom_4D(app,directory,im4D,parameters,tag)


% create folder if not exist, and clear
folder_name = [directory,['/DICOM-',tag]];
if (~exist(folder_name, 'dir')); mkdir(folder_name); end
delete([folder_name,'/*']);

[nr_frames,dimx,dimy,dimz] = size(im4D);

% export the dicom images

dcmid = dicomuid;   % unique identifier
dcmid = dcmid(1:50);


for i=1:nr_frames
    
    for j=1:dimx
        
        app.ProgressViewField.Value = round(100*((i-1)*dimx+j)/(nr_frames*dimx));
        drawnow;
        
        dcm_header = generate_dicomheader_4D(parameters,i,j,dimx,dimy,dimz,dcmid);
        fn = ['00000',num2str((i-1)*parameters.NO_SLICES+j)];
        fn = fn(size(fn,2)-5:size(fn,2));
        fname = [folder_name,'/DICOM-4D-',fn,'.dcm'];
        image = rot90(squeeze(cast(round(im4D(i,j,:,:)),'uint16')));
        dicomwrite(image, fname, dcm_header);
        
    end
    
end




end