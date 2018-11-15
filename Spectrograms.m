% Pascal Coding Class
% Homework Seven 
% April. 12th. 2018 
% Helena Palmieri 

%% Preface 

% The goal of this assignment is to depict the one hundred most common
% words in English, in amplitude, and in a spectogram using different windows
% and filters. 

% Deshawn Sambrano's Code -----------------
olddir = pwd; 
tmp = matlab.desktop.editor.getActive; 
newdir = fileparts(tmp.Filename); 
cd(newdir); 
% ------------------------------------------

clear all
close all
clc

%% Loading the Data. 

load ('Top_100_male_midwestern.mat')    % Load Data
clean_data = whos;                      % Creating a Structure 
                                        % Delete rows that aren't words (bits, fs, etc.)

%% Welcome Screen
figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
welcome_screen = text(0.5,0.7,'WELCOME','HorizontalAlignment','center');
set(welcome_screen,'color','k');
set(welcome_screen,'fontsize', 40);
set(welcome_screen,'fontweight','bold');
welcome_screen_dir = text(0.5,0.5,'Press SPACE to move through the graphs','HorizontalAlignment','center');
set(welcome_screen_dir,'color','k');
set(welcome_screen_dir,'fontsize',20);
set(welcome_screen_dir,'fontweight','bold');
welcome_screen_next = text(0.5,0.3,'The graphs may take a while to load so please be patient','HorizontalAlignment','center');
set(welcome_screen_next,'color','k');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold');
shg
pause
delete(welcome_screen_dir);
delete(welcome_screen_next);
delete(welcome_screen);

%% Plotting the 100 Words

for i = 1:100
    if clean_data(i).size(1) ~= 88200;   % If the row is not equal to 88200
        clean_data(i) = [];              % Set it to NOTHING
    end
end

% Figure Aesthics
figure     
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]); 

% This creates a 'for' loop for the 100 subplots
for ii = 1:length(clean_data);
    if clean_data(ii).size(1) == 88200;                     % Pulling only the 88200 length cells
        subplot(10,10,ii)                                   % Set 100 subplots
        plot(eval(num2str(clean_data(ii).name)))            % Plot the words (100)
        soundsc(eval(num2str(clean_data(ii).name)),fs)      % Have the words be spoken
        axis off
        current_word = clean_data(ii).name;                 % Taking one of the words 
        current_word(length(clean_data(ii).name)) = [];     % Removing the 1
        title(gca,[num2str(current_word)],'color','k')      % Making that now the title of the subplot
        pause(2)                                            % pause in between each word (2 seconds)
    end
end
pause
% close all

%% Fourier Transform

% Setting up the windows for the transform, hopefully save some lines. 
window_one = hamming(8);
window_two = kaiser(8);
window_three = hamming(256);
window_four = kaiser(256);

% Setting up the frequency points
nfft = 512;
ySubDivisions = nfft;

% Figure for Hamming (8) ------------------------------------------------------
figure      
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]); 
overl = length(window_one)-1;                              % This is the minimal possible shift, maximal overlap
subplot(2,2,1)                                             % Subplot 1/4
spectrogram(a1,window_one,overl,ySubDivisions,fs,'yaxis'); % Plotting the Spectrogram
title (gca, 'Hamming 8 A','color','k','FontSize',16)       % Title
box off                   
set(gca,'TickDir','out')
shg

overl = length(window_one)-1;                                  % This is the minimal possible shift, maximal overlap
subplot(2,2,2)                                                 % Subplot 2/4
spectrogram(about1,window_one,overl,ySubDivisions,fs,'yaxis'); % Plotting the Spectrogram
title (gca, 'Hamming 8 About','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg

overl = length(window_one)-1;                                  % This is the minimal possible shift, maximal overlap
subplot(2,2,3)                                                 % Subplot 3/4
spectrogram(after1,window_one,overl,ySubDivisions,fs,'yaxis'); % Plotting the Spectrogram
title (gca, 'Hamming 8 After','color','k','FontSize',16)       % Title 
box off
set(gca,'TickDir','out')
shg

overl = length(window_one)-1;                                  % This is the minimal possible shift, maximal overlap
subplot(2,2,4)                                                 % Subplot 4/4
spectrogram(all1,window_one,overl,ySubDivisions,fs,'yaxis');   % Plotting the Spectrogram
title (gca, 'Hamming 8 All','color','k','FontSize',16)         % Title
box off
set(gca,'TickDir','out')
shg

pause  % Done with A, About, After, All at Hamming (8) window size

% Figure for Kaiser (8) ------------------------------------------------------
figure      
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
overl = length(window_two)-1;                             % This is the minimal possible shift, maximal overlap
subplot(2,2,1)                                            % Subplot 1/4
spectrogram(a1,window_two,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Kaiser 8 A','color','k','FontSize',16)       % Title
box off 
set(gca,'TickDir','out')
shg
 
overl = length(window_two)-1;                                 % This is the minimal possible shift, maximal overlap
subplot(2,2,2)                                                % Subplot 2/4
spectrogram(about1,window_two,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Kaiser 8 About','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg

overl = length(window_two)-1;                                 % This is the minimal possible shift, maximal overlap
subplot(2,2,3)                                                % Subplot 3/4 
spectrogram(after1,window_two,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Kaiser 8 After','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg

overl = length(window_two)-1;                                % This is the minimal possible shift, maximal overlap
subplot(2,2,4)                                               % Subplot 4/4
spectrogram(all1,window_two,overl,ySubDivisions,fs,'yaxis')  % Plotting the Spectrogram
title (gca, 'Kaiser 8 All','color','k','FontSize',16)        % Title
box off
set(gca,'TickDir','out')
shg

pause   % Done with A, About, After, All at Kaiser (8) window size

% Figure for Hamming (256) ------------------------------------------------------
figure      
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
overl = length(window_three)-1;                              % This is the minimal possible shift, maximal overlap
subplot(2,2,1)                                               % Subplot 1/4
spectrogram(a1,window_three,overl,ySubDivisions,fs,'yaxis')  % Plotting the Spectrogram
title (gca, 'Hamming 256 A','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg

overl = length(window_three)-1;                                 % This is the minimal possible shift, maximal overlap
subplot(2,2,2)                                                  % Subplot 2/4
spectrogram(about1,window_three,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Hamming 256 About','color','k','FontSize',16)      % Title
box off
set(gca,'TickDir','out')
shg

overl = length(window_three)-1;                                  % This is the minimal possible shift, maximal overlap
subplot(2,2,3)                                                   % Subplot 3/4 
spectrogram(after1,window_three,overl,ySubDivisions,fs,'yaxis')  % Plotting the Spectrogram
title (gca, 'Hamming 256 After','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg
 
overl = length(window_three)-1;                                % This is the minimal possible shift, maximal overlap
subplot(2,2,4)                                                 % Subplot 4/4 
spectrogram(all1,window_three,overl,ySubDivisions,fs,'yaxis')  % Plotting the Spectrogram
title (gca, 'Hamming 256 All','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg

pause   % Done with A, About, After, All at Hamming (256) window size

% This filter (Hamming) and window (256) is BY FAR the best one for this data set

% Figure for Kaiser (256) ------------------------------------------------------
figure      
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
overl = length(window_four)-1;                             % This is the minimal possible shift, maximal overlap
subplot(2,2,1)                                             % Subplot 1/4
spectrogram(a1,window_four,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Kaiser 256 A','color','k','FontSize',16)      % Title
box off
set(gca,'TickDir','out')
shg  

overl = length(window_four)-1;                                 % This is the minimal possible shift, maximal overlap
subplot(2,2,2)                                                 % Subplot 2/4
spectrogram(about1,window_four,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Kaiser 256 About','color','k','FontSize',16)      % Title
box off
set(gca,'TickDir','out')
shg  

overl = length(window_four)-1;                                 % This is the minimal possible shift, maximal overlap
subplot(2,2,3)                                                 % Subplot 3/4 
spectrogram(after1,window_four,overl,ySubDivisions,fs,'yaxis') % Plotting the Spectrogram
title (gca, 'Kaiser 256 After','color','k','FontSize',16)      % Title
box off
set(gca,'TickDir','out')
shg 

overl = length(window_four)-1;                                % This is the minimal possible shift, maximal overlap
subplot(2,2,4)                                                % Subplot 4/4
spectrogram(all1,window_four,overl,ySubDivisions,fs,'yaxis')  % Plotting the Spectrogram
title (gca, 'Kaiser 256 All','color','k','FontSize',16)       % Title
box off
set(gca,'TickDir','out')
shg   

pause   % Done with A, About, After, All at Kaiser (256) window size

%% End Screen
figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
end_screen = text(0.5,0.7,'DONE','HorizontalAlignment','center');
set(end_screen,'color','k');
set(end_screen,'fontsize', 40);
set(end_screen,'fontweight','bold');
end_screen_dir = text(0.5,0.5,'Thank you for clicking through!','HorizontalAlignment','center'); 
set(end_screen_dir,'color','k');
set(end_screen_dir,'fontsize',20);
set(end_screen_dir,'fontweight','bold');
end_screen_next = text(0.5,0.3,'Bye!','HorizontalAlignment','center');
set(end_screen_next,'color','k');
set(end_screen_next,'fontsize',20);
set(end_screen_next,'fontweight','bold');
shg
pause

% END 

