% Assignment Four
% Pascal Scientific Coding
% (Name)
% February. 28th. 2018

%% Preface
clear all
close all
clc

% This assignment is an attempt to recreate the Posner Paradigm Experiment
% (Posner 1980). Afterwards we will collect the data and plot the means of
% the reaction times.

% IMPORTANT: If you press the space bar before the stimulus (*) is presented
% the experiment will go back to the MatLab terminal. Just pay attention
% and you'll be fine.

%% Intialization
figure
set(gcf,'color','w');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
i = 0
condition_vector = repmat(1, 200, 1)
condition_vector(81:160) = 2;
condition_vector(161:180) = 3
condition_vector(181:200) = 4
condition_vector = condition_vector(randperm(length(condition_vector)))
response_time_valid_left = nan(200,1)
response_time_invalid_left = nan(200,1)
response_time_valid_right = nan(200,1)
response_time_invalid_right = nan(200,1)

%% Welcome Screen
welcome_screen = text(0.4,0.7,'WELCOME');
set(welcome_screen,'color','k');
set(welcome_screen,'fontsize', 40);
set(welcome_screen,'fontweight','bold');
welcome_screen_dir = text(0.4,0.4,'Please maintain fixation');
set(welcome_screen_dir,'color','k');
set(welcome_screen_dir,'fontsize',20);
set(welcome_screen_dir,'fontweight','bold');
welcome_screen_warning = text(0.4, 0.3,'WARNING: If you press the SPACE BAR before the * appears you WILL be returned to the MatLab Terminal');
set(welcome_screen_warning,'HorizontalAlignment','center')
set(welcome_screen_warning,'color','r');
set(welcome_screen_warning,'fontsize',20);
set(welcome_screen_warning,'fontweight','bold');
welcome_screen_next = text(0.37,0.2,'Press SPACE when you see *');
set(welcome_screen_next,'color','k');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold');
shg
pause
delete(welcome_screen_warning); 
delete(welcome_screen_dir);
delete(welcome_screen_next);
delete(welcome_screen);

%% Experiment Frame
% Creation of Left and Right Cue Framework --------------------------------
axis([0 10 0 10]);
left_square = rectangle('Position', [2 4 0.6 1]);
left_square. EdgeColor = 'k';
left_square. LineWidth = 3 ;
right_square = rectangle('Position', [6.7 4 0.6 1]);
right_square. EdgeColor = 'k';
right_square. LineWidth = 3 ;

% Fixation Cross ----------------------------------------------------------
fix_cross = text (4.5, 4.5,'+');
set(fix_cross,'fontsize',20);
set(fix_cross,'color','k');

%% Experiment

for i = 1 : 200
        %% Valid Left
    if condition_vector(i) == 1
        
        % Framework ------------------------------------------------------
        scale_factor = .5; % sets the maximum pause time to 500 milliseconds
        pause_time = rand(1) * scale_factor % makes the pause random
        pause(pause_time) % actually makes the pause happen
        left_square. EdgeColor = 'b' % Cue
        shg
        pause (0.3)
        left_square. EdgeColor = 'k'
        scale_factor = 1.5; % sets the maximum pause time to 1.5 seconds
        pause_time = rand(1) * scale_factor % makes the pause random
        pause(pause_time) % actually makes the pause happen
        valid_cue = text (2.25, 4.38,'*') % Stimulus
        set(valid_cue,'fontsize',40);
        set(valid_cue,'color','k');
        tic
        pause
        response_time_valid_left (i) = toc
        
        %% Invalid Left
    elseif condition_vector(i) == 2
               
        % Framework ---------------------------------------------------
        scale_factor = .5; % sets the maximum pause time to 500 milliseconds
        pause_time = rand(1) * scale_factor % makes the pause random
        pause(pause_time) % actually makes the pause happen
        right_square.EdgeColor = 'b' % Cue
        shg
        pause (0.3)
        right_square. EdgeColor = 'k'
        scale_factor = 1.5; % sets the maximum pause time to 1.5 seconds
        pause_time = rand(1) * scale_factor % makes the pause random
        pause(pause_time) % actually makes the pause happen
        valid_cue = text (2.25, 4.38,'*') % Stimulus
        set(valid_cue,'fontsize',40);
        set(valid_cue,'color','k');
        tic
        pause
        response_time_invalid_left (i) = toc
        
        %% Valid Right
    elseif condition_vector(i) == 3
              
        % Framework -----------------------------------------------
        scale_factor = .5; % sets the maximum pause time to 500 milliseconds
        pause_time = rand(1) * scale_factor % makes the pause random
        pause(pause_time) % actually makes the pause happen
        right_square.EdgeColor = 'b' % Cue
        shg
        pause (0.3)
        right_square.EdgeColor = 'k'
        scale_factor = 1.5; % sets the maximum pause time to 1.5 seconds
        pause_time = rand(1) * scale_factor % makes the pause random
        pause(pause_time) % actually makes the pause happen
        valid_cue = text (6.9, 4.38,'*') % Stimulus
        set(valid_cue,'fontsize',40);
        set(valid_cue,'color','k');
        tic
        pause
        response_time_valid_right (i) = toc
        
        %% Invalid Right       
    else condition_vector(i) == 4
    
        % Framework -------------------------------------------
        scale_factor = .5; % Sets the maximum pause time to 500 milliseconds
        pause_time = rand(1) * scale_factor % Makes the pause random
        pause(pause_time) % Actually makes the pause happen
        right_square.EdgeColor = 'b' % Cue
        shg
        pause (0.3)
        right_square.EdgeColor = 'k'
        scale_factor = 1.5; % Sets the maximum pause time to 1.5 seconds
        pause_time = rand(1) * scale_factor % Makes the pause random
        pause(pause_time) % Actually makes the pause happen
        valid_cue = text (6.95, 4.38,'*') % Stimulus
        set(valid_cue,'fontsize',40);
        set(valid_cue,'color','k');
        tic
        pause
        response_time_invalid_right (i) = toc
        
    end
    delete(valid_cue)
    
end

delete (valid_cue)
delete (right_square)
delete (left_square)
delete (fix_cross)

%% End Screen
axis([0 10 0 10]);
end_screen = text(3,6,'FINISH');
set(end_screen,'color','k');
set(end_screen,'fontsize', 40);
set(end_screen,'fontweight','bold');
end_screen_thanks = text(1.5,5,'Click SPACE to see your results!');
set(end_screen_thanks,'color','k');
set(end_screen_thanks,'fontsize',20);
set(end_screen_thanks,'fontweight','bold');
shg
pause
delete(end_screen_thanks);
delete(end_screen);
                                     
%% Obtaining the Means
mean_invalid_left = mean(response_time_invalid_left,'omitnan')
mean_valid_left = mean(response_time_valid_left,'omitnan')
mean_invalid_right = mean(response_time_invalid_right, 'omitnan')
mean_valid_right = mean(response_time_valid_right,'omitnan')

%% Plotting 
mean_bar = [mean_invalid_left mean_valid_left ; mean_invalid_right mean_valid_right]
bar_graph = bar(mean_bar)
shg
direction_labels = {'Left','Right'};
set(gca,'Xticklabel',direction_labels) % Changing x axis labels to color_labels
set(gca,'TickDir','out') % This makes it so that the ticks are outside
set(gcf,'color','w') % This sets the background of the plot as white
xlabel('Condition Type') % Larger x-axis label
ylabel('Reaction Times') % y-axis label
title(gca,'Reaction Times based on Condition Types') % Title
box off % Take off meaningless lines that box in the figure
lgd = legend('\color{black} Invalid','\color{black} Valid','location','NorthWest')

% END