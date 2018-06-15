% Assignment Two 
% Helena Palmieri 
% Pascal Scientific Programming 
% February. 14th. 2016 

%% Description of What This Code Does 
% Here we are asked to parse data collected from the dress phenomenon into
% a format that can be used for further analysis. 
% We will then attempt to create histrograms of both the self-reported
% color responses and the self-reported circadian type. 

%% Preface for Assignment 

load('Assignment2Data.mat') 

%% Data Parsing 

% Column One Parsing: Self-Reported Color Response 

numericalDATA = nan(size(DATA));
for i = 1:length(DATA)
    if strcmp(DATA{i,1},'White/Gold')
       numericalDATA(i,1) = 1;
    elseif strcmp(DATA{i,1},'Blue/Black')
           numericalDATA(i,1) = 2;
    elseif strcmp(DATA{i,1},'White/Black')
           numericalDATA(i,1) = 3;
    elseif strcmp(DATA{i,1},'Blue/Gold')
           numericalDATA(i,1) = 4;
    elseif strcmp(DATA{i,1},'It was quickly switching between white/gold and blue/black')
           numericalDATA(i,1) = 5;
    else
        numericalDATA(i,1) = 6;
    end
end

%Column Two Parsing: Circadian Type

for i = 1:length(DATA(:,2))
    if strcmp(DATA{i,2},'Strong lark')
       numericalDATA(i,2) = 1;
       elseif strcmp(DATA{i,2},'Lark')
           numericalDATA(i,2) = 2;
    elseif strcmp(DATA{i,2}, 'Owl')
           numericalDATA(i,2) = 3;
    elseif strcmp(DATA{i,2},'Strong owl')
           numericalDATA(i,2) = 4;
    else
        numericalDATA(i,2) = 5;
    end
end

 

%% Graphs 

%% 3+4 Bar graphs
TotalWhiteGold = sum(numericalDATA(:,1) == 1); %Assigning the sum of 1's in numericalDATA(:,1) to TotalWhiteGold
TotalBlueBlack = sum(numericalDATA(:,1) == 2); %Assigning the sum of 2's in numericalDATA(:,1) to TotalBlueBlack
TotalWhiteBlack = sum(numericalDATA(:,1) == 3); %Assigning the sum of 3's in numericalDATA(:,1) to TotalWhiteBlack
TotalBlueGold = sum(numericalDATA(:,1) == 4); %Assigning the sum of 4's in numericalDATA(:,1) to TotalBlueGold
TotalSwitching = sum(numericalDATA(:,1) == 5); %Assigning the sum of 5's in numericalDATA(:,1) to TotalSwitching
TotalNaNs = sum(numericalDATA(:,1) == 6); %Assigning the sum of 4's in numericalDATA(:,1) to TotalBlueGold
y = [TotalWhiteGold TotalBlueBlack TotalWhiteBlack TotalBlueGold TotalSwitching TotalNaNs]; %Creating vector 'y' with the values of variables that summed up each category in numericalDATA(:,1)

TotalStrongOwl = sum(numericalDATA(:,2) == 1); %Assigning the sum of 1's in numericalDATA(:,2) to TotalStrongOwl
TotalOwl = sum(numericalDATA(:,2) == 2); %Assigning the sum of 2's in numericalDATA(:,2) to TotalOwl
TotalLark = sum(numericalDATA(:,2) == 3); %Assigning the sum of 3's in numericalDATA(:,2) to TotalLark
TotalStrongLark = sum(numericalDATA(:,2) == 4); %Assigning the sum of 4's in numericalDATA(:,2) to TotalStrongLark
TotalOther = sum(numericalDATA(:,2) == 5); %Assigning the sum of 5's in numericalDATA(:,2) to TotalOther
y1 = [TotalStrongOwl TotalOwl TotalLark TotalStrongLark TotalOther] %Creating vector 'y1' with the values of variables that summed up each category in numericalDATA(:,2)

figure %creating figure
subplot(2,1,1) %creating subplot and locating it at 1,1
ColorGraph = bar(y) %creating plot y (colors) and assigning it to ColorGraph
ColorLabels = {'White/Gold', 'Blue/Black', 'White/Black', 'Blue/Gold', 'Switching', 'Mistrials'} %creating cell with labels and assigning it to ColorLabels
set(gca,'Xticklabel',ColorLabels) %changing x axis labels to strings at ColorLabels
set(gca,'TickDir','out') %moving the ticks out
ylabel('Subjects') %creating label for y axis
box off %removing outer frame.
title(gca,'Self-reported Perceived Colors') %adding a title
subplot(2,1,2) %creating subplot and locating it at 1,2
CircadianType = bar(y1) %creating plot y1 (circadian types) and assigning it to CircadianType
CircadianLabels = {'Strong Owl', 'Owl', 'Lark', 'Strong Lark', 'Other'} %creating cell with labels and assigning it to CircadianLabels
set(gca,'Xticklabel',CircadianLabels) %changing x axis labels to strings at CircadianLabels
set(gca,'TickDir','out') %moving the ticks out
ylabel('Subjects') %creating label for y axis
box off %removing outer frame
title('Circadian Type') %adding a title 

