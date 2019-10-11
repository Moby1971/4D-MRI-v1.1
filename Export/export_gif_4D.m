function export_gif_4D(gifexportpath,movie)

% number of movie frames
number_of_frames = size(movie,1);

% total duration is 5 seconds
delay_time = 5/number_of_frames;  

% scale from 0 - 255
movie = round(255*movie/max(movie(:)));

% export movie to animated gif
for idx = 1:number_of_frames
    if idx == 1
        imwrite(uint8(rot90(squeeze(movie(idx,:,:)))),[gifexportpath,filesep,'movie-',num2str(number_of_frames),'frames.gif'],'DelayTime',delay_time,'LoopCount',inf);
    else
        imwrite(uint8(rot90(squeeze(movie(idx,:,:)))),[gifexportpath,filesep,'movie-',num2str(number_of_frames),'frames.gif'],'WriteMode','append','DelayTime',delay_time);
    end
end
            
end                 