
% Assignment One
% Pascal Scientific Programming
% (Name)
% February. 4th. 2018 

%% Preface for Assignment 

load('Assigment1_data.mat') 

%% Finding the Reaction Times 

% Here we are subtracting the the onset time of the stimulus from the
% overall response time and assigning that difference to the new variables 
% that begin with reaction_time_(etc). 

% This was done three times, or in other words for each participant.

% Reaction Time for 200 mg of Caffeine
reaction_time_200 = (data_caffeine_200 - stimTime_caffeine_200);

% Reaction Time for 400 mg of Caffeine
reaction_time_400 = (data_caffeine_400 - stimTime_caffeine_400);

% Reaction Time for Control (NO CAFFEINE) 
reaction_time_control = (data_control - stimTime_control); 

%% Finding the Valid Trials 

% Here we are finding the trials that above zero and creating a new data
% structure with the trials that are above zero, these will be 
% considered the valid trials.

% This is done three times, or in other words for each participant.

% Valid Reaction Times 200mg
[row] = find(reaction_time_200 > 0);
valid_trials_200 = reaction_time_200(row); 

% Valid Reaction Times 400mg
[row] = find(reaction_time_400 > 0); 
valid_trials_400 = reaction_time_400(row); 

% Valid Reaction Times Control (NO CAFFEINE) 
[row] = find(reaction_time_control > 0);
valid_trials_control = reaction_time_control(row); 
    
%% Plotting the Participants

figure

% Here we are plotting the valid trials of the 200mg participant
plot(valid_trials_200) % You can just insert valid_trials_200 because it 
                       % assumes the y axis and takes the dimensions as 
                       % the x-axis

Handle200 = plot(valid_trials_200); 
Handle200.Color = 'b'; % This colors the 200mg participant as blue

hold on % End of plotting the 200mg participant 


% Here we are plotting the valid trials of the 400mg participant 
plot(valid_trials_400) % You can just insert valid_trials_400 because it 
                       % assumes the y axis and takes the dimensions as 
                       % the x-axis

Handle400 = plot(valid_trials_400); 
Handle400.Color = 'r'; % This colors the 400mg participant as red

hold on % End of plotting the 400mg participant 


% Here we are plotting the valid trials of the control participant 
plot(valid_trials_control) % You can just insert valid_trials_control because 
                           % it assumes the y axis and takes the dimensions as 
                           % the x-axis

HandleCONTROL = plot(valid_trials_control);  
HandleCONTROL.Color = 'k'; % This colors the control participant as black

hold on % End of plotting the control participant 


%% Aesthetic and Necessary Changes to the Final Plot 

xlabel('Valid Trials') % This is the label for the x-axis
ylabel('Reaction Time per Trial') % This is the label for the y-axis
title('Effects of Caffeine on Reaction Time')% This is the plot title

set(gcf,'color','w') % This sets the background of the plot as white
set(gca,'tickdir','out') % This makes it so that the ticks are outside 
box off % Take off meaningless lines that box in the figure

startPlot = 0; % This is where we start to plot
endPlot = 272; % End of plot
xlim([startPlot endPlot]) % Now our plotting limits are the same as the data we have

pbaspect([10 4 1]) % This is the plot box aspect ratio meaning that 
                   % this changed the plot so that the x-axis is longer 
                   % than the y axis, the z axis (1) does not apply

% This creates the legend/key for the plot
legend([Handle200, Handle400, HandleCONTROL], '200 mg of Caffeine', '400 mg of Caffeine', 'Control', 'Location', 'SouthEastOutside')

%END
