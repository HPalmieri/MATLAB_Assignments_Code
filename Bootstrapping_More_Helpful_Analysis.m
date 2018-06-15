% Assignment Nine 
% Pascal Coding 
% (Name) 
% April. 26th. 2018 

%% Preface 

% This code is meant to analysis New York prisoners are we are interested in 
% different treatments and causes for psychosis.

% Basic 
close all
clear all
clc

% Deshawn's Code 
olddir = pwd; 
tmp = matlab.desktop.editor.getActive; 
newdir = fileparts(tmp.Filename); 
cd(newdir); 

%% Load Data 
load ('psychopathy.mat') 

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
warning = text(0.5,0.3,'These graphs take a while to appear since we are sampling millions of times so please be patient','HorizontalAlignment','center'); 
set(warning,'color','k');
set(warning,'fontsize',20);
set(warning,'fontweight','bold');
shg
pause

%% Bootstrapping 
    
control = DATA(DATA(:,3) == 0, :);   % Here we are separating the participants that serve as the control (0)
treatment = DATA(DATA(:,3) == 1, :); % Here we are separating the participants that recieveed the treatment (1)

ratio_treatment = @(X) mean(X(X(:,3) == 1,1)); % Grabbing the 1's from the third column and getting the mean
sampling = 1e6 ;                               % Sampling WITH replacement one million times
bootci (sampling,ratio_treatment, DATA)        % Getting the confidence intervals
CI_treatment = ans ;                           % Setting the ans to CI_treatment for later use
    
ratio_control = @(X) mean(X(X(:,3) == 0,1));   % Grabbing the 1's from the third column and getting the mean
sampling = 1e6 ;                               % Sampling WITH replacement one million times
bootci (sampling,ratio_control, DATA)          % Getting the confidence intervals
CI_control = ans ;                             % Setting the ans to CI_control for later use

figure
set(gcf,'menubar','none');                                 % Remove Menubar
set(gcf,'toolbar','none');                                 % Remove Toolbar
axis off;                                                  % Remove Axis
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);   % Full Screen

subplot (2,1,1)                                                                      % First Subplot                           
title(gca,'Confidence Intervals of Treatment Later and Treatment Now','color','k','FontSize',16) % Title
set(gca,'TickDir','out')                                                             % Get those ticks outta here

mean_treatment = mean(treatment(:,1));                                                                               % Getting the mean of the first column in the treatment group
mean_t_handle = line([mean_treatment(1,1) mean_treatment(1,1)],[min(ylim) max(ylim)], 'color', 'r', 'linewidth', 5); % Plotting the mean
h1 = line([CI_treatment(1,1) CI_treatment(1,1)], [min(ylim) max(ylim)], 'color', 'r', 'linewidth', .5);              % Plotting the confidence interval (lower)
h2 = line([CI_treatment(2,1) CI_treatment(2,1)], [min(ylim) max(ylim)], 'color', 'r', 'linewidth', .5);              % Plotting the confidence interval (upper)
set([h1 h2], 'Color','r','LineWidth',.5)
treatment_patch = patch([-1.3950 -0.6706 -0.6706 -1.3950] , [0 0 1 1], 'r' ) % Shading in the space between the lines
alpha(0.2) % Change the opacity of the color 

mean_control = mean(control(:,1));                                                                               % Getting the mean of the first column in the control group
mean_c_handle = line([mean_control(1,1) mean_control(1,1)],[min(ylim) max(ylim)], 'color', 'b', 'linewidth', 5); % Plotting the mean
h3 = line([CI_control(1,1) CI_control(1,1)], [min(ylim) max(ylim)], 'color', 'b', 'linewidth', .5);              % Plotting the confidence interval (lower)
h4 = line([CI_control(2,1) CI_control(2,1)], [min(ylim) max(ylim)], 'color', 'b', 'linewidth', .5);              % Plotting the confidence interval (upper)
set([h3 h4], 'Color','b','LineWidth',.5)
control_patch = patch([-1.0733 -0.1467 -0.1467 -1.0733] , [0 0 1 1], 'b' )                                       % Shading in the space between the lines
alpha(0.2)                                                                                                       % Change the opacity of the shading
legend ([mean_t_handle mean_c_handle treatment_patch control_patch], {'Mean Treatment Now','Mean Treatment Later','Confidence Inverval of Treatment Now','Confidence Interval of Treatment Later'}); 

% Made a subplot to explain whats going on in the above plot and
% conclusions one should make. 
subplot (2,1,2)
box off
axis off
set(gca,'TickDir','out')
explaination = text(0.5,0.7,'These confidence intervals overlap greatly.','HorizontalAlignment','center');
set(explaination,'color','k');
set(explaination,'fontsize', 40);
set(explaination,'fontweight','bold');
statistic = text(0.5,0.5,'This is great! This means that the random assignment worked.','HorizontalAlignment','center');
set(statistic,'color','k');
set(statistic,'fontsize',20);
set(statistic,'fontweight','bold');
shg
pause

%% t - Test 
x = treatment(:,2);           % Calling the second column of the treatment and setting that to x 
y = control(:,2);             % Calling the second column of the control and setting that to x 
[h,p,ci,stats] = ttest2(x,y); % Two - Sample t Test
tstat = -1.7283;              % Test Statistic that I got from the above test (if you open up the structure in the workspace called stats you can see the tstat value)
      
figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);

subplot (2,1,1)                                                                       % First Subplot  
title(gca,'Two Sample t-Test (Test Statistic = - 1.7283)','color','k','FontSize',16)  % Title
set(gca,'TickDir','out')                                                              % Get those ticks outta here
line([tstat tstat],[min(ylim) max(ylim)], 'color', 'k', 'linewidth', 3)               % Plotting the tstat line
mean_treatment = mean(treatment(:,1));                                                % Getting the mean of the first column in the treatment group

ttest_cid_handle = line ([ci(1,1) ci(1,1)],[min(ylim) max(ylim)], 'color', 'r', 'linewidth', 5); % Plotting the confidence interval (lower)
ttest_ciu_handle = line ([ci(2,1) ci(2,1)],[min(ylim) max(ylim)], 'color', 'r', 'linewidth', 5); % Plotting the conficence interval (upper)
set([ttest_cid_handle ttest_ciu_handle], 'Color','r','LineWidth',2)
patch([-6.9562 0.4990 0.4990 -6.9562] , [0 0 1 1], 'r' )                                         % Shading in the space between the lines
alpha(0.2)                                                                                       % Changing the ocapity of the shading

% Made a subplot to explain whats going on in the above plot and
% conclusions one should make. 
subplot (2,1,2)
box off
axis off
set(gca,'TickDir','out')
explaination = text(0.5,0.7,'Here the test statistic is in the confidence interval','HorizontalAlignment','center');
set(explaination,'color','k');
set(explaination,'fontsize', 40);
set(explaination,'fontweight','bold');
statistic = text(0.5,0.5,'This data suggests that there is no statistical significance found','HorizontalAlignment','center');
set(statistic,'color','k');
set(statistic,'fontsize',20);
set(statistic,'fontweight','bold');
ntt = text(0.5,0.3,'Since a t-Test assumes normality we should not have done this analysis anyway','HorizontalAlignment','center');
set(ntt,'color','k');
set(ntt,'fontsize',20);
set(ntt,'fontweight','bold');
next = text(0.5,0.1,'Therefore, let us move on to permutation ','HorizontalAlignment','center');
set(ntt,'color','k');
set(next,'fontsize',20);
set(next,'fontweight','bold');
shg
pause

%% Permutation Test
sampling_wo_replacement = 1e6 ;                           % Sampling one million times WITHOUT replacement
num_treatment = length(treatment);
num_control = length(control);
test_statistic = sum(treatment(:,2)) - sum(control(:,2)); % Getting the difference between the sums
all_DATA = [treatment(:,2) control(:,2)];                 % Stacking the data 

dTS = nan(sampling_wo_replacement,1); % Intializing

for i = 1:sampling_wo_replacement
    tempIndices = randperm(num_treatment+num_control); % randperm does sampling without replacement
    tempDATA = all_DATA(tempIndices);
    virtualGroup1 = tempDATA(1:num_treatment);
    tempDATA(:,1:num_treatment) = []; 
    virtualGroup2 = tempDATA;
    dTS(i) = sum(virtualGroup1) - sum(virtualGroup2);  % Getting the difference between the sums
end

% Finding all the values that are above my test statistic and all the
% values below my test statistic
exact_pvalue = (sum(dTS<=test_statistic) + sum(dTS>=-test_statistic))./length(dTS); % Getting the exact p value
CRLI = ceil(length(dTS) *.025);
CRUI = length(dTS) - CRLI;
sorted = sort(dTS);
CRL =  sorted(CRLI);
CRU =  sorted(CRUI);

figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);

subplot (2,1,1) % First subplot 
histogram(dTS)  % Histogram
set(gca,'TickDir','out')
box off
line([CRL CRL], [min(ylim) max(ylim)], 'color', 'r', 'linewidth', .5)                      % Plotting the lower alpha cutoff line
line([CRU CRU], [min(ylim) max(ylim)], 'color', 'r', 'linewidth', .5)                      % Plotting the upper alpha cutoff line
line([test_statistic test_statistic], [min(ylim) max(ylim)], 'color', 'k', 'linewidth', 3) % Plotting the line of the test statistic
title(['Distribution of test statistic. Exact p Value =', num2str(exact_pvalue,'%1.3f')])

% Made a subplot to explain whats going on in the above plot and
% conclusions one should make. 
subplot (2,1,2)
box off
axis off
set(gca,'TickDir','out')
statistic = text(0.5,0.5,'This data analysis suggests that there is no statistical significance found','HorizontalAlignment','center');
set(statistic,'color','k');
set(statistic,'fontsize',40);
set(statistic,'fontweight','bold');
shg
pause

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
shg
pause

% END - THANK YOU

