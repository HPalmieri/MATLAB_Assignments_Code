% Pascal Scientific Coding 
% Assignment Six
% (Name) 
% March. 28th. 2018 

%% Preface 
% The goal of this code is to clean the data from a qualitative diary of an
% individual suffering from bipolar disorder over a year. 
% Once the data is pruned basic statisical tests will be administered to
% make conclusions. 

%% Loading Data
% Deshawn Code
olddir = pwd; 
tmp = matlab.desktop.editor.getActive; 
newdir = fileparts(tmp.Filename); 
cd(newdir); 

raw_data = xlsread('timeseries2015.xlsx'); % Loading the excel file

%% Data Pruning 
% If there is a NaN present in the new_data set, the whole day is removed. 
clean_data = raw_data;
clean_data(isnan(raw_data(:,7)),:) = [];  

%% Convolution 
% In this section we are smoothing the data by a kernel length of seven (seven days
% in a week) makes sense. ¯\_('_')_/¯
kernel_length = 7;
kernel = ones(kernel_length,1);
kernal_weight = sum(kernel); 

% Smoothing Sleep
smoothed_sleep = conv(clean_data(:,2), kernel, 'valid')./kernel_length;
% Smoothing Mood
smoothed_mood = conv(clean_data(:,3), kernel, 'valid')./kernel_length;
% Smoothing Energy
smoothed_energy = conv(clean_data(:,4), kernel, 'valid')./kernel_length;
% Smoothing Inspiration 
smoothed_inspiration = conv(clean_data(:,5), kernel, 'valid')./kernel_length;
% Smoothing Work
smoothed_work = conv(clean_data(:,6), kernel, 'valid')./kernel_length;
% Smoothing REM
smoothed_REM = conv(clean_data(:,7), kernel, 'valid')./kernel_length;
% Smoothing Deep
smoothed_deep = conv(clean_data(:,8), kernel, 'valid')./kernel_length;

%% Welcome Screen
% Basic welcome screen commands like making the figure black, adding text,
% aesthics - nothing really that interesting in this part. 
figure
set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
welcome_screen = text(0.4,0.7,'WELCOME');
set(welcome_screen,'color','w');
set(welcome_screen,'fontsize', 40);
set(welcome_screen,'fontweight','bold');
welcome_screen_dir = text(0.24,0.4,'Please press ENTER to move through all the figures');
set(welcome_screen_dir,'color','w');
set(welcome_screen_dir,'fontsize',20);
set(welcome_screen_dir,'fontweight','bold');
welcome_screen_next = text(0.45,0.2,'Thanks!');
set(welcome_screen_next,'color','w');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold');
shg
pause

%% Figure  
% In this section we graphed the clean_data 
figure
set(gcf,'color','k')
set(gcf,'menubar','none')
set(gcf,'toolbar','none')
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
set(gca,'TickDir','out')

% Graphing Sleep & Work
subplot(2,3,1)
plot(smoothed_sleep, 'linewidth',2)
plot(smoothed_sleep,'color','r')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Number of Hours', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Sleep & Work','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on
plot(smoothed_work, 'linewidth',.7)
plot(smoothed_work,'color','m')

% Graphing Mood
subplot(2,3,2)
plot(smoothed_mood, 'linewidth',2)
plot(smoothed_mood,'color','w')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Daily Mood Scale', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w';
title (gca, 'Mood','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on

% Graphing Energy 
subplot(2,3,3)
plot(smoothed_energy, 'linewidth',2)
plot(smoothed_energy,'color','y')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Energy Level Scale', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Energy','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on

% Graphing Inspiration
subplot(2,3,4)
plot(smoothed_inspiration, 'linewidth',2)
plot(smoothed_inspiration,'color','g')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Inspiration Level Scale', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Inspiration','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on

% Graphing REM
subplot(2,3,5)
plot(smoothed_REM, 'linewidth',2)
plot(smoothed_REM,'color','c')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Number of Hours', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'REM','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on

% Graphing Deep Sleep
subplot(2,3,6)
plot(smoothed_deep, 'linewidth',2)
plot(smoothed_deep,'color','b')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Minutes of Deep Sleep', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Deep','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on
pause

%% Correlation  
% In this section we are correlating EVERYTHING 

clean_data(:,1) = []; % Deleting the first column with the dates
all_correlations = corr(clean_data); % Correlating the clean data

figure 
set(gcf,'color','k')
set(gcf,'menubar','none')
set(gcf,'toolbar','none')
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
set(gca,'TickDir','out')

% Correlation between Sleep and Work
X = smoothed_sleep;
Y = smoothed_work; 
corr(X,Y)
subplot(4,6,1) 
scatter(X,Y)
set(gca,'color','w')
xlabel('r = -0.4416', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Sleep vs. Work Correlation','color','w')
hold on

% Correlation between Sleep and Mood
X = smoothed_sleep;
Y = smoothed_mood; 
corr(X,Y)
subplot(4,6,2) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.3231', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Sleep vs. Mood Correlation','color','w')
hold on

% Correlation between Sleep and Energy
X = smoothed_sleep;
Y = smoothed_energy; 
corr(X,Y)
subplot(4,6,3) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.3418', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Sleep vs. Energy Correlation','color','w')
hold on

% Correlation between Sleep and Inspiration
X = smoothed_sleep;
Y = smoothed_inspiration;
corr(X,Y)
subplot(4,6,4) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.1935', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Sleep vs. Inspiration Correlation','color','w')
hold on

% Correlation between Sleep and REM
X = smoothed_sleep;
Y = smoothed_REM;
corr(X,Y)
subplot(4,6,5) 
scatter(X,Y)
set(gca,'color','c')
xlabel('r = 0.9144', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Sleep vs. REM Correlation','color','w')
hold on

% Correlation between Sleep and Deep Sleep
X = smoothed_sleep;
Y = smoothed_deep;
corr(X,Y)
subplot(4,6,6) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.5709', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Sleep vs. Deep Sleep Correlation','color','w')
hold on

% Correlation between Work and Mood
X = smoothed_work;
Y = smoothed_mood;
corr(X,Y)
subplot(4,6,7) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.2251', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Work vs. Mood Correlation','color','w')
hold on

% Correlation between Work and Energy
X = smoothed_work;
Y = smoothed_energy;
corr(X,Y)
subplot(4,6,8) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.3892', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Work vs. Energy Correlation','color','w')
hold on

% Correlation between Work and Inspiration
X = smoothed_work;
Y = smoothed_inspiration;
corr(X,Y)
subplot(4,6,9) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.0634', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Work vs. Inspiration Correlation','color','w')
hold on

% Correlation between Work and REM Sleep
X = smoothed_work;
Y = smoothed_REM;
corr(X,Y)
subplot(4,6,10) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.4202', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Work vs. REM Sleep Correlation','color','w')
hold on

% Correlation between Work and Deep Sleep
X = smoothed_work;
Y = smoothed_deep;
corr(X,Y)
subplot(4,6,11) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.2835', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Work vs. Deep Sleep Correlation','color','w')
hold on

% Correlation between Mood and Energy
X = smoothed_mood;
Y = smoothed_energy;
corr(X,Y)
subplot(4,6,12) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.3624', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Mood vs. Energy Correlation','color','w')
hold on

% Correlation between Mood and Inspiration
X = smoothed_mood;
Y = smoothed_inspiration;
corr(X,Y)
subplot(4,6,13) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.2945', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Mood vs. Inspiration Correlation','color','w')
hold on

% Correlation between Mood and REM Sleep
X = smoothed_mood;
Y = smoothed_REM;
corr(X,Y)
subplot(4,6,14) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.3090', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Mood vs. REM Sleep Correlation','color','w')
hold on

% Correlation between Mood and Deep Sleep
X = smoothed_mood;
Y = smoothed_deep;
corr(X,Y)
subplot(4,6,15) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.0369', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Mood vs. Deep Sleep Correlation','color','w')
hold on

% Correlation between Energy and Inspiration
X = smoothed_energy;
Y = smoothed_inspiration;
corr(X,Y)
subplot(4,6,16) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.2709', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Energy vs. Inspiration Correlation','color','w')
hold on

% Correlation between Energy and REM
X = smoothed_energy;
Y = smoothed_REM;
corr(X,Y)
subplot(4,6,17) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.2685', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Energy vs. REM Correlation','color','w')
hold on

% Correlation between Energy and Deep Sleep
X = smoothed_energy;
Y = smoothed_deep;
corr(X,Y)
subplot(4,6,18) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.1257', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Energy vs. Deep Sleep Correlation','color','w')
hold on

% Correlation between Inspiration and REM Sleep
X = smoothed_inspiration;
Y = smoothed_REM;
corr(X,Y)
subplot(4,6,19) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.2243', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Inspiration vs. REM Correlation','color','w')
hold on

% Correlation between Inspiration and Deep Sleep
X = smoothed_inspiration;
Y = smoothed_deep;
corr(X,Y)
subplot(4,6,20) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = -0.0375', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'Inspiration vs. Deep Sleep Correlation','color','w')
hold on

% Correlation between REM and Deep Sleep
X = smoothed_REM;
Y = smoothed_deep;
corr(X,Y)
subplot(4,6,21) 
scatter(X,Y)
set(gca,'color','k')
xlabel('r = 0.3753', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
box off
set(gca,'TickDir','out')
title(gca,'REM vs. Deep Sleep Correlation','color','w')
hold on

% Makeshift legend for this MASSIVE figure in one of the subplots
subplot(4,6,22) 
axis off
box off
neg_correlation_explanation = text(0.8,0.7,'Highest Negative Correlation');
set(neg_correlation_explanation,'color','w','FontSize',16)
pos_correlation_explanation = text(0.8,0.2,'Highest Positive Correlation');
set(pos_correlation_explanation,'color','c','FontSize',16)
hold on
pause

%% Normalization
% Normalizing the already smoothed data (finding the z scores using the
% normalizer function that was provided on NYU Classes). 

% Normalizing Sleep
[ normalized_sleep ] = normalizer(smoothed_sleep);

% Normalizing WERK
[ normalized_work ] = normalizer(smoothed_work);

% Normalizing Mood
[ normalized_mood ] = normalizer(smoothed_mood);

% Normalizing Energy
[ normalized_energy ] = normalizer(smoothed_energy);

% Normalizing Inspiration
[ normalized_inspiration ] = normalizer(smoothed_inspiration);

% Normalizing REM Sleep
[ normalized_REM ] = normalizer(smoothed_REM);

% Normalizing Deep Sleep
[ normalized_deep ] = normalizer(smoothed_deep);


% Plotting all the normalized data together in the same graph
figure
set(gcf,'color','k')
set(gcf,'menubar','none')
set(gcf,'toolbar','none')
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
set(gca,'TickDir','out')
hold on
plot(normalized_sleep,'color','r')
hold on
plot(normalized_work,'color','m')
hold on
plot(normalized_mood,'color','w')
hold on
plot(normalized_energy,'color','y')
hold on
plot(normalized_inspiration,'color','g')
hold on
plot(normalized_REM,'color','c')
hold on
plot(normalized_deep,'color','b')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Z Scores', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Normalized Data','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
lgd = legend('\color{white} Sleep','\color{white} Work','\color{white}Mood','\color{white}Energy','\color{white}Inspiration','\color{white}REM','\color{white}Deep' );
set(lgd,'location','north');
hold on
pause

% Plotting just the normalized data of REM Sleep and Mood
figure
set(gcf,'color','k')
set(gcf,'menubar','none')
set(gcf,'toolbar','none')
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
set(gca,'TickDir','out')
hold on
plot(normalized_REM,'color','c')
hold on
plot(normalized_mood,'color','w')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Z Scores', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Normalized Data (REM & Mood)','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
lgd = legend('\color{white}Mood','\color{white}REM');
set(lgd,'location','north');
hold on
pause 

% Plotting just the normalized data of Deep Sleep and Mood
figure
set(gcf,'color','k')
set(gcf,'menubar','none')
set(gcf,'toolbar','none')
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
set(gca,'TickDir','out')
hold on
plot(normalized_deep,'color','b')
hold on
plot(normalized_mood,'color','w')
set(gca,'color','k')
xlabel('Recorded Days', 'color', 'w')
ylabel('Z Scores', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Normalized Data (Deep Sleep & Mood)','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
lgd = legend('\color{white}Mood','\color{white}Deep Sleep');
set(lgd,'location','north');
hold on
pause 

%% Averaging 

% Intializing matrices for sleep, mood, and work
sleep_total = nan(365,7); 
mood_total = nan(365,7); 
work_total = nan(365,7);
i = 0; % Start counting from zero

% Made this part into a for loop that divides by seven and the remainder is
% then parsed into the different days of the week. 
% In english if a week (aka seven days) is divided by seven then the
% remainder will be zero and that day will be considered Sunday, etc. 

for i = 1:length(raw_data) % Making a for loop the length of the data
    if mod(raw_data(i,1),7) == 1;     % Sunday
        sleep_total(i,1) = raw_data(i,2); % Column 2
        mood_total(i,1) = raw_data(i,3);  % Column 3 
        work_total(i,1) = raw_data(i,6);  % Column 6
    elseif mod(raw_data(i,1),7) == 2; % Monday
        sleep_total(i,2) = raw_data(i,2); 
        mood_total(i,2) = raw_data(i,3);  
        work_total(i,2) = raw_data(i,6);  
    elseif mod(raw_data(i,1),7) == 3; % Tuesday
        sleep_total(i,3) = raw_data(i,2); 
        mood_total(i,3) = raw_data(i,3); 
        work_total(i,3) = raw_data(i,6);  
    elseif mod(raw_data(i,1),7) == 4; % Wednesday
        sleep_total(i,4) = raw_data(i,2); 
        mood_total(i,4) = raw_data(i,3);  
        work_total(i,4) = raw_data(i,6);  
    elseif mod(raw_data(i,1),7) == 5; % Thursday
        sleep_total(i,5) = raw_data(i,2); 
        mood_total(i,5) = raw_data(i,3); 
        work_total(i,5) = raw_data(i,6); 
    elseif mod(raw_data(i,1),7) == 6; % Friday
        sleep_total(i,6) = raw_data(i,2); 
        mood_total(i,6) = raw_data(i,3);  
        work_total(i,6) = raw_data(i,6);  
    elseif mod(raw_data(i,1),7) == 0; % Saturday
        sleep_total(i,7) = raw_data(i,2);  
        mood_total(i,7) = raw_data(i,3);  
        work_total(i,7) = raw_data(i,6);   
    end
end

% Finding the means and omiting the NaNs that are in the matrix, so that it
% doesn't stop for effect the calculation of the mean.
sleep_mean = mean(sleep_total,'omitnan');
mood_mean = mean(mood_total,'omitnan');
work_mean = mean(work_total,'omitnan');

% Making a bar graph of the means that compares Sleep and Work 
figure
set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
subplot (1,2,1)
A = [sleep_mean ; work_mean]; 
bar(A')
set(gca,'color','k')
xlabel('Sunday     Monday     Tuesday     Wednesday     Thursday     Friday     Saturday', 'color', 'w')
ylabel('Z Scores', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Mean Comparison of Weekdays (Sleep and Work)','color','w','FontSize',16)
box off
lgd = legend('\color{white} Sleep','\color{white} Work');
set(lgd,'location','north');
set(gca,'TickDir','out')


% Making a bar graph of the Mood alone
subplot (1,2,2)
bar(mood_mean)
set(gca,'color','k')
xlabel('Sunday     Monday     Tuesday     Wednesday     Thursday     Friday     Saturday', 'color', 'w')
ylabel('Z Scores', 'color', 'w')
ax = gca;
ax.XAxis.Color = 'w'; 
ax.YAxis.Color = 'w'; 
title (gca, 'Mean Comparison of Weekdays (Mood)','color','w','FontSize',16)
box off
set(gca,'TickDir','out')
hold on

%% End Screen
% Adding the end screen so that the user knows when everything has been
% presented. 

figure
set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
welcome_screen = text(0.4,0.7,'DONE');
set(welcome_screen,'color','w');
set(welcome_screen,'fontsize', 40);
set(welcome_screen,'fontweight','bold');
welcome_screen_dir = text(0.24,0.4,'Should be 8 figures in total (including the welcome and end screen)');
set(welcome_screen_dir,'color','w');
set(welcome_screen_dir,'fontsize',20);
set(welcome_screen_dir,'fontweight','bold');
welcome_screen_next = text(0.45,0.2,'Bye!');
set(welcome_screen_next,'color','w');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold');
shg
pause

%END





