% Assignment Three
% Helena Palmieri
% Pascal Scientific Coding Class
% Feburary. 21st. 2018

%% PREFACE
close all
clear all
clc

%% DATA COLLECTION PREFACE

distractor_X = 'X'; % VARIABLE
distractor_O = 'O'; % VARIABLE
stimulus_number = [4 8 12 16]; % DIFFERENT NUMBER OF STIMULI
% INTIALIZE
results = nan(10,5);
correct_trial_tally = zeros(2,2,4); % TRACKER
i = 0 

%% SETTINGS
figure
set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);

% WELCOME SCREEN ----------------------------------------------------------
welcome_screen = text(0.4,0.7,'WELCOME');
set(welcome_screen,'color','g');
set(welcome_screen,'fontsize', 40);
set(welcome_screen,'fontweight','bold')
welcome_screen_text = text(0.3,0.4,'Press ''q'' if you see a RED X and ''p'' otherwise');
set(welcome_screen_text,'color','w');
set(welcome_screen_text,'fontsize',20);
welcome_screen_next = text(0.4,0.2,'Press SPACE to start');
set(welcome_screen_next,'color','w');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold')
shg
pause
delete(welcome_screen_next)
delete(welcome_screen_text)
delete(welcome_screen)

% CONDITIONS --------------------------------------------------------------
  % POPOUT ----------------------------------------------------------------
  
while sum (sum (sum (correct_trial_tally < 10))) > 0 % CONTINUATION OF LOOP
    i = i + 1 ;
    popout = randi(2); % RANDOMIZATION (POPOUT = 2 % CONJUNCTION = 1)
    stimulus_total = randi(4);
    stimulus_trials = stimulus_number(stimulus_total); 
    if popout == 2; 
        popout_target = randi(2); % RANDOMIZATION W/ AND W/O TARGET
        target = popout_target; % ASSIGN TO COUNTER
        if popout_target == 2; % LOCATIONS (TARGET)
            location_popout_X = rand(((stimulus_trials./2)-1),2);
            location_popout_O = rand((stimulus_trials./2),2);
            location_popout_target = rand(1,2);
        else                   % LOCATIONS (NO TARGET) 
            location_popout_X = rand((stimulus_trials./2),2);
            location_popout_O = rand((stimulus_trials./2),2);
        end
        % STIMULI
        distractors_popout_X = text(location_popout_X(:,1),location_popout_X(:,2),distractor_X)
        distractors_popout_O = text(location_popout_O(:,1),location_popout_O(:,2),distractor_O)
        if popout_target == 2;
            target_popout = text(location_popout_target(:,1),location_popout_target(:,2),distractor_X)
        end
        % STIMULI APPEARANCE
        set(distractors_popout_O,'fontsize',20);
        set(distractors_popout_O,'color','g');
        set(distractors_popout_O,'fontweight','bold');
        set(distractors_popout_X,'fontsize',20);
        set(distractors_popout_X,'color','g');
        set(distractors_popout_X,'fontweight','bold');
        if popout_target == 2;
            set(target_popout,'fontsize',20);
            set(target_popout,'color','r');
            set(target_popout,'fontweight','bold');
        end
        tic;
        pause 
        reaction_time = toc; % REACTION TIME
        
        delete(distractors_popout_X)
        delete(distractors_popout_O)
        if popout_target == 2;
            delete(target_popout)
        end
        
    % CONJUNCTION ---------------------------------------------------------    
    else 
        con_target = randi(2);  % RANDOMIZATION W/ AND W/O TARGET
        target = con_target
        % LOCATIONS OF STIMULI
        if con_target == 2; % W/ TARGET
            location_con_target = rand(1,2);
            location_con_greenx = rand((stimulus_trials./4),2);
            location_con_greeno = rand((stimulus_trials./4),2);
            location_con_redo = rand(((stimulus_trials./2)-1),2);
        else                % W/O TARGET
            location_con_greenx = rand((stimulus_trials./4),2);
            location_con_greeno = rand((stimulus_trials./4),2);
            location_con_redo = rand((stimulus_trials./2),2);
        end
        % STIMULI 
        distractors_con_greenx = text(location_con_greenx(:,1),location_con_greenx(:,2),distractor_X)
        distractors_con_greeno = text(location_con_greeno(:,1),location_con_greeno(:,2),distractor_O)
        distractors_con_redo = text(location_con_redo(:,1),location_con_redo(:,2),distractor_O)
        if con_target == 2;
            target_con = text(location_con_target(:,1),location_con_target(:,2),distractor_X)
        end
        % STIMULI APPEARANCE 
        set(distractors_con_greeno,'fontsize',20);
        set(distractors_con_greeno,'color','g');
        set(distractors_con_greeno,'fontweight','bold');
        set(distractors_con_greenx,'fontsize',20);
        set(distractors_con_greenx,'color','g');
        set(distractors_con_greenx,'fontweight','bold');
        set(distractors_con_redo,'fontsize',20);
        set(distractors_con_redo,'color','r');
        set(distractors_con_redo,'fontweight','bold');
        if con_target == 2;
            set(target_con,'fontsize',20);
            set(target_con,'color','r');
            set(target_con,'fontweight','bold');
        end
        tic
        pause 
        reaction_time = toc; %REACTION TIME
       
        delete(distractors_con_redo)
        delete(distractors_con_greeno)
        delete(distractors_con_greenx)
        if con_target == 2;
            delete(target_con)
        end
    end
    % RECORDING -----------------------------------------------------------
    results(i,1) = i; 
       % CHECKING FOR CORRECTNESS -----------------------------------------
    if target == 2;
        expected_key = 'q';
    else
        expected_key = 'p';
    end
    participant_key = get(gcf,'CurrentCharacter');
    correct = strcmp(participant_key,expected_key);
    % RECORDING THE CORRECT RESPONSES -------------------------------------
    if correct == 1;
        if     popout==1 && target==1 && stimulus_total==1 && correct_trial_tally (1,1,1) < 10;
            results(i,2) = reaction_time;
        elseif popout==1 && target==1 && stimulus_total==2 && correct_trial_tally (1,1,2) < 10;
            results(i,2) = reaction_time;
        elseif popout==1 && target==1 && stimulus_total==3 && correct_trial_tally (1,1,3) < 10;
            results(i,2) = reaction_time;
        elseif popout==1 && target==1 && stimulus_total==4 && correct_trial_tally (1,1,4) < 10;
            results(i,2) = reaction_time;
            
        elseif popout==1 && target==2 && stimulus_total==1 && correct_trial_tally (1,2,1) < 10;
            results(i,2) = reaction_time;
        elseif popout==1 && target==2 && stimulus_total==2 && correct_trial_tally (1,2,2) < 10;
            results(i,2) = reaction_time;
        elseif popout==1 && target==2 && stimulus_total==3 && correct_trial_tally (1,2,3) < 10;
            results(i,2) = reaction_time;
        elseif popout==1 && target==2 && stimulus_total==4 && correct_trial_tally (1,2,4) < 10;
            results(i,2) = reaction_time;
            
        elseif popout==2 && target==1 && stimulus_total==1 && correct_trial_tally (2,1,1) < 10;
            results(i,2) = reaction_time;
        elseif popout==2 && target==1 && stimulus_total==2 && correct_trial_tally (2,1,2) < 10;
            results(i,2) = reaction_time;
        elseif popout==2 && target==1 && stimulus_total==3 && correct_trial_tally (2,1,3) < 10;
            results(i,2) = reaction_time;
        elseif popout==2 && target==1 && stimulus_total==4 && correct_trial_tally (2,1,4) < 10;
            results(i,2) = reaction_time;
            
        elseif popout==2 && target==2 && stimulus_total==1 && correct_trial_tally (2,2,1) < 10;
            results(i,2) = reaction_time;
        elseif popout==2 && target==2 && stimulus_total==2 && correct_trial_tally (2,2,2) < 10;
            results(i,2) = reaction_time;
        elseif popout==2 && target==2 && stimulus_total==3 && correct_trial_tally (2,2,3) < 10;
            results(i,2) = reaction_time;
        elseif popout==2 && target==2 && stimulus_total==4 && correct_trial_tally (2,2,4) < 10;
            results(i,2) = reaction_time;
        else
            results(i,2) = nan;
        end
    else
        results(i,2) = nan;
    end
        results(i,3) = popout; 
        results(i,4) = stimulus_trials; 
        results(i,5) = target; 
    
    correct_trial_tally(popout,target,stimulus_total) = correct_trial_tally(popout,target,stimulus_total) + correct; 
    
end
%% SETTING UP PLOTTING VARIABLES

% INTIALIZING 
reaction_time_con4 = nan(350,1)
reaction_time_con8 = nan(350,1)
reaction_time_con12 = nan(350,1)
reaction_time_con16 = nan(350,1)
reaction_time_pop4 = nan(350,1)
reaction_time_pop8 = nan(350,1)
reaction_time_pop12 = nan(350,1)
reaction_time_pop16 = nan(350,1)
reaction_time_tar4 = nan(350,1)
reaction_time_tar8 = nan(350,1)
reaction_time_tar12 = nan(350,1)
reaction_time_tar16 = nan(350,1)
reaction_time_no_tar4 = nan(350,1)
reaction_time_no_tar8 = nan(350,1)
reaction_time_no_tar12 = nan(350,1)
reaction_time_no_tar16 = nan(350,1)

% POPOUT V. CONJUNCTION
i = 0
for i = 1:length(results);
    if results(i,3)==1;
        if results(i,4)==4;
            reaction_time_con4(i,1) = results(i,2);
        elseif results(i,4)==8;
            reaction_time_con8(i,1) = results(i,2);
        elseif results(i,4)==12;
            reaction_time_con12(i,1) = results(i,2);
        elseif results(i,4)==16;
            reaction_time_con16(i,1) = results(i,2);
        end
    elseif results(i,3)==2;
        if results(i,4)==4;
            reaction_time_pop4(i,1) = results(i,2);
        elseif results(i,4)==8;
            reaction_time_pop8(i,1) = results(i,2);
        elseif results(i,4)==12;
            reaction_time_pop12(i,1) = results(i,2);
        elseif results(i,4)==16;
            reaction_time_pop16(i,1) = results(i,2);
        end
    end
end
reaction_time_con4_mean = mean(reaction_time_con4,'omitnan');
reaction_time_con8_mean = mean(reaction_time_con8,'omitnan');
reaction_time_con12_mean = mean(reaction_time_con12,'omitnan');
reaction_time_con16_mean = mean(reaction_time_con16,'omitnan');
reaction_time_pop4_mean = mean(reaction_time_pop4,'omitnan');
reaction_time_pop8_mean = mean(reaction_time_pop8,'omitnan');
reaction_time_pop12_mean = mean(reaction_time_pop12,'omitnan');
reaction_time_pop16_mean = mean(reaction_time_pop16,'omitnan');
conjunction_Y = [reaction_time_con4_mean reaction_time_con8_mean reaction_time_con12_mean reaction_time_con16_mean];
popout_Y = [reaction_time_pop4_mean reaction_time_pop8_mean reaction_time_pop12_mean reaction_time_pop16_mean];
X = [4 8 12 16];

% TARGET V. NO TARGET 
i = 0
for i = 1:length(results)
    if results(i,5)==1;
        if  results(i,4)==4;
            reaction_time_no_tar4(i,1) = results(i,2);
        elseif results(i,4)==8;
            reaction_time_no_tar8(i,1) = results(i,2);
        elseif results(i,4)==12;
            reaction_time_no_tar12(i,1) = results(i,2);
        elseif results(i,4)==16;
            reaction_time_no_tar16(i,1) = results(i,2);
        end
    elseif results(i,5)==2;
        if  results(i,4)==4;
            reaction_time_tar4(i,1) = results(i,2);
        elseif results(i,4)==8;
            reaction_time_tar8(i,1) = results(i,2);
        elseif results(i,4)==12;
            reaction_time_tar12(i,1) = results(i,2);
        elseif results(i,4)==16;
            reaction_time_tar16(i,1) = results(i,2);
        end
    end
end
reaction_time_no_tar4_mean = mean(reaction_time_no_tar4,'omitnan');
reaction_time_no_tar8_mean = mean(reaction_time_no_tar8,'omitnan');
reaction_time_no_tar12_mean = mean(reaction_time_no_tar12,'omitnan');
reaction_time_no_tar16_mean = mean(reaction_time_no_tar16,'omitnan');
reaction_time_tar4_mean = mean(reaction_time_tar4,'omitnan');
reaction_time_tar8_mean = mean(reaction_time_tar8,'omitnan');
reaction_time_tar12_mean = mean(reaction_time_tar12,'omitnan');
reaction_time_tar16_mean = mean(reaction_time_tar16,'omitnan');
target_Y = [reaction_time_tar4_mean reaction_time_tar8_mean reaction_time_tar12_mean reaction_time_tar16_mean];
no_target_Y = [reaction_time_no_tar4_mean reaction_time_no_tar8_mean reaction_time_no_tar12_mean reaction_time_no_tar16_mean];
%% PLOT SETTINGS

set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);

% CONJUNCTION VS. POPOUT --------------------------------------------------
subplot(2,1,1)
con_plot = plot(X,conjunction_Y);
hold on;
popout_plot = plot(X,popout_Y);
hold on; 
shg
ylim([0.0 2.0]);
xticks([4 8 12 16]);
set(gca,'Xticklabels',[4 8 12 16]);
ylabel('Reaction Time','color','w');
xlabel('Number of Stimuli','color','w');
popout_plot.LineWidth = 2;
con_plot.LineWidth = 2;
set(popout_plot,'color','y');
set(con_plot,'color','w');
set(gca,'color','k');
box off
lgd= legend('\color{white} Conjunction','\color{yellow} Pop-Out','location','NorthWest')
lgd.FontSize = 16;

% TARGET VS. NO TARGET ----------------------------------------------------
subplot(2,1,2)
no_tar_plot = plot(X,no_target_Y);
hold on;
tar_plot = plot(X,target_Y);
hold on;
shg
ylim([0.0 2.0]);
xticks([4 8 12 16]);
set(gca,'Xticklabels',[4 8 12 16]);
ylabel('Reaction Time','color','w');
xlabel('Number of Stimuli','color','w');
tar_plot.LineWidth = 2;
no_tar_plot.LineWidth = 2;
set(tar_plot,'color','y');
set(no_tar_plot,'color','w');
set(gca,'color','k');
box off
lgd= legend('\color{white} No-Target','\color{yellow} Target','location','SouthWest')
lgd.FontSize = 16;


% MEANS -------------------------------------------------------------------
mean_no_target = (reactiontime_no_tar4_mean + reactiontime_no_tar8_mean + reactiontime_no_tar12_mean + reactiontime_no_tar16_mean)./4
mean_target = (reaction_time_tar4_mean + reaction_time_tar8_mean + reaction_time_tar12_mean + reaction_time_tar16_mean)./4
mean_popout = (reaction_time_pop4_mean + reaction_time_pop8_mean + reaction_time_pop12_mean + reaction_time_pop16_mean)./4
mean_conjunction = (reaction_time_con4_mean + reaction_time_con8_mean + reaction_time_con12_mean + reaction_time_con16_mean)./4
mean_target_variable = [mean_target mean_no_target]

target_mean_text = text(6.2,1.06,['Mean:', num2str(mean_target)])
no_target_mean_text = text(6.2,1.13,['Mean:' num2str(mean_no_target)])
set(target_mean_text,'color','y','FontSize',17)
set(no_target_mean_text,'color','w','FontSize',17)
conjunction_mean_text = text(6.2,1.961,['Mean:', num2str(mean_conjunction)])
popout_mean_text = text(6.2,1.891,['Mean:' num2str(mean_popout)])
set(conjunction_mean_text,'color','w','FontSize',17)
set(popout_mean_text,'color','y','FontSize',17)

% END
