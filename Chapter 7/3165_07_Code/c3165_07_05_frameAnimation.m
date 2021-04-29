%% CHAPTER 7, ANIMATION WITH PLAYBACK OF FRAME CAPTURES
%   3165_07_05: 
%   Copyright 2012 Packt Publishing
%   $Revision: 1 $
%   $Date: 2012-07-09 24:00:00

% Add path to utilities
addpath([pwd '\..\..\..\utilities']);

load MRI
figure; 
for image_num = 1:27;        
    image(D(:,:,image_num));colormap(map);
    f(image_num) = getframe;
end
close;
movie(f);

load MRI
aviobj = avifile('3165_07_05_1.avi','fps',3,'quality',100,'compression','none');
for image_num = 1:27;        
    image(D(:,:,image_num));colormap(map);
    aviobj = addframe(aviobj,getframe);
end
aviobj = close(aviobj);
close;

imwrite(D,map,'3165_07_05_2.gif','gif' ...
				, 'DelayTime',.2 ...
				, 'WriteMode','overwrite' ...
                , 'Location', [503   289] ...
                , 'ScreenSize',[873   642]...
				, 'LoopCount',7);

%generate smooth version from fewer snapshots using anymate
D_less = D(:,:,1,1:2:end);
for image_num = 1:size(D_less,4)-1;
    figure; image(D_less(:,:,image_num));
    colormap(map);
end
    
anymate