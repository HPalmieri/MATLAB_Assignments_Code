% Assignment Five
% Pascal Coding
% (Name)
% March. 15th. 2018

%% Description
% This code is designed to somewhat recreate the psychophysics experiment
% done by Fechner in 1860. Here we are trying to find the absolute
% threshold of the colors white, red, green, blue. We are also separating
% the experiment into two blocked conditions of parafovea and fovea to
% later compare the thresholds.

%% Preface
clear all
close all
clc
%% Intialization
% Creating the space needed for recording both conditions 
present_fovea_white = nan (800,10);
present_fovea_red = nan (800,10);
present_fovea_green = nan (800, 10);
present_fovea_blue = nan (800, 10);
present_parafovea_white = nan (800,10);
present_parafovea_red = nan (800,10);
present_parafovea_green = nan (800, 10);
present_parafovea_blue = nan (800, 10);

%% Welcome Screen Fovea
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
welcome_screen_dir = text(0.24,0.4,'Please maintain fixation, this is the FOVEA CONDITION');
set(welcome_screen_dir,'color','w');
set(welcome_screen_dir,'fontsize',20);
set(welcome_screen_dir,'fontweight','bold');
welcome_screen_next = text(0.3,0.2,'Press Q when you see a dot, press P otherwise ');
set(welcome_screen_next,'color','w');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold');
shg
pause
delete(welcome_screen_dir);
delete(welcome_screen_next);
delete(welcome_screen);

%% Randomization
brightness_type = repmat(0,800,2); % Creating a matrix with 800 rows (trials) and 2 columns 
                                   % (brightness and color)
% Here we are randomizing both the brightness levels and the colors at the
% same time as if they were pairs, and then those pairs are randomized.
% That way each brightness levels has 20 trials of each color (white, red,
% green, and blue). 

brightness_type (1:80,1) = 0;       % Level 0 Brightness
brightness_type (1:20,2) = 1;       % White
brightness_type (21:40,2) = 2;      % Red
brightness_type (41:60,2) = 3;      % Green
brightness_type (61:80,2) = 4;      % Blue
brightness_type (81:160,1) = 10;    % Level 10 Brightness
brightness_type (81:100,2) = 1;     % White
brightness_type (101:120,2) = 2;    % Red
brightness_type (121:140,2) = 3;    % Green
brightness_type (141:160,2) = 4;    % Blue
brightness_type (161:240,1) = 20;   % Level 20 Brightness
brightness_type (161:180,2) = 1;    % White
brightness_type (181:200,2) = 2;    % Red
brightness_type (201:220,2) = 3;    % Green 
brightness_type (221:240,2) = 4;    % Blue 
brightness_type (241:320,1) = 30;   % Level 30 Brightness
brightness_type (241:260,2) = 1;    % White 
brightness_type (261:280,2) = 2;    % Red
brightness_type (281:300,2) = 3;    % Green
brightness_type (301:320,2) = 4;    % Blue
brightness_type (321:400,1) = 40;   % Level 40 Brightness
brightness_type (321:340,2) = 1;    % White
brightness_type (341:360,2) = 2;    % Red
brightness_type (361:380,2) = 3;    % Green
brightness_type (381:400,2) = 4;    % Blue
brightness_type (401:480,1) = 50;   % Level 50 Brightness
brightness_type (401:420,2) = 1;    % White
brightness_type (421:440,2) = 2;    % Red
brightness_type (441:460,2) = 3;    % Green
brightness_type (461:480,2) = 4;    % Blue 
brightness_type (481:560,1) = 60;   % Level 60 Brightness
brightness_type (481:500,2) = 1;    % White 
brightness_type (501:520,2) = 2;    % Red
brightness_type (521:540,2) = 3;    % Green
brightness_type (541:560,2) = 4;    % Blue 
brightness_type (561:640,1) = 70;   % Level 70 Brightness
brightness_type (561:580,2) = 1;    % White
brightness_type (581:600,2) = 2;    % Red  
brightness_type (601:620,2) = 3;    % Green 
brightness_type (621:640,2) = 4;    % Blue
brightness_type (641:720,1) = 80;   % Level 80 Brightness
brightness_type (641:660,2) = 1;    % White
brightness_type (661:680,2) = 2;    % Red
brightness_type (681:700,2) = 3;    % Green
brightness_type (701:720,2) = 4;    % Blue
brightness_type (721:800,1) = 90;   % Level 90 Brightness
brightness_type (721:740,2) = 1;    % White
brightness_type (741:760,2) = 2;    % Red
brightness_type (761:780,2) = 3;    % Green
brightness_type (781:800,2) = 4;    % Blue

brightness_type = brightness_type (randperm(size(brightness_type,1)),:); % Randomizes the pairs

stimulus = uint8(zeros(400,400,3)); % Creates dark stimulus matrix 

%% Fovea Block
for ii = 1:800                                           % 800 trials of the fovea condition
    if brightness_type(ii,1) == 0                        % Level 0 Brightness         
        if brightness_type(ii,2) == 1                    % Level 0 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 2                % Level 0 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 3                % Level 0 Brightness + Green 
            stimulus(200,200,2) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 4                % Level 0 Brightness + Blue
            stimulus(200,200,3) = brightness_type(ii,1); 
        end
    elseif brightness_type(ii,1) == 10                   % Level 10 Brightness
        if brightness_type(ii,2) == 1                    % Level 10 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2                % Level 10 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 10 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 10 Brightness + Blue
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 20                   % Level 20 Brightness
        if brightness_type(ii,2) == 1                    % Level 20 Brightness + White 
            stimulus(200,200,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2                % Level 20 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 20 Brightness + Green   
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 20 Brightness + Blue 
            stimulus(200,200,3) = brightness_type(ii,1); 
        end
    elseif brightness_type(ii,1) == 30                   % Level 30 Brightness 
        if brightness_type(ii,2) == 1                    % Level 30 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2                % Level 30 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 30 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 30 Brightness + Blue
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 40                   % Level 40 Brightness
        if brightness_type(ii,2) == 1                    % Level 40 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2                % Level 40 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 40 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 40 Brightness + Blue 
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 50                   % Level 50 Brightness  
        if brightness_type(ii,2) == 1                    % Level 50 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 2                % Level 50 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 3                % Level 50 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 4                % Level 50 Brightness + Blue 
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 60                   % Level 60 Brightness
        if brightness_type(ii,2) == 1                    % Level 60 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 2                % Level 60 Brightness + Red 
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 60 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 4                % Level 60 Brightness + Blue 
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 70                   % Level 70 Brightness 
        if brightness_type(ii,2) == 1                    % Level 70 Brightness + White 
            stimulus(200,200,:) = brightness_type(ii,1); 
        elseif brightness_type(ii,2) == 2                % Level 70 Brightness + Red 
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 70 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 70 Brightness + Blue
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 80                   % Level 80 Brightness 
        if brightness_type(ii,2) == 1                    % Level 80 Brightness + White  
            stimulus(200,200,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2                % Level 80 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 80 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 80 Brightness + Blue
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 90                   % Level 90 Brightness 
        if brightness_type(ii,2) == 1                    % Level 90 Brightness + White
            stimulus(200,200,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2                % Level 90 Brightness + Red
            stimulus(200,200,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3                % Level 90 Brightness + Green
            stimulus(200,200,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4                % Level 90 Brightness + Blue
            stimulus(200,200,3) = brightness_type(ii,1);
        end
    end
    image(stimulus)          % Show the stimulus
    pause (0.3)              
    stimulus(200,200,:) = 0; % Back to black 
    image(stimulus)          % Show the stimulus
    pause
    
    % Key Responses ---------------------------------------------------
    participant_key = get(gcf,'CurrentCharacter'); 
    present = strcmp('q',participant_key);          % If present the participant will hit ''q''
    
    if brightness_type (ii,1) == 0                  % Brightness Level 0 
        if brightness_type (ii,2) == 1              % Brightness Level 0 + White
            present_fovea_white (ii,1) = present;   % If these are true store it here, first column
        elseif brightness_type (ii,2) == 2          % Brightness Level 0 + Red
            present_fovea_red (ii,1) = present;     % If these are true store it here, first column
        elseif brightness_type (ii,2) == 3          % Brightness Level 0 + Green
            present_fovea_green (ii,1) = present;   % If these are true store it here, first column
        elseif brightness_type (ii,2) == 4          % Brightness Level 0 + Blue
            present_fovea_blue (ii,1) = present;    % If these are true store it here, first column                     
        end
    end
    if brightness_type (ii,1) == 10                 % Brightness Level 10
        if brightness_type (ii,2) == 1              % Brightness Level 10 + White 
            present_fovea_white (ii,2) = present;   % If these are true store it here, second column
        elseif brightness_type (ii,2) == 2          % Brightness Level 10 + Red
            present_fovea_red (ii,2) = present;     % If these are true store it here, second column
        elseif brightness_type (ii,2) == 3          % Brightness Level 10 + Green
            present_fovea_green (ii,2) = present;   % If these are true store it here, second column
        elseif brightness_type (ii,2) == 4          % Brightness Level 10 + Blue
            present_fovea_blue (ii,2) = present;    % If these are true store it here, second column                     
        end
    end 
    if brightness_type (ii,1) == 20                 % Brightness Level 20          
        if brightness_type (ii,2) == 1              % Brightness Level 20 + White
            present_fovea_white (ii,3) = present;   % If these are true store it here, third column
        elseif brightness_type (ii,2) == 2          % Brightness Level 20 + Red 
            present_fovea_red (ii,3) = present;     % If these are true store it here, third column
        elseif brightness_type (ii,2) == 3          % Brightness Level 20 + Green
            present_fovea_green (ii,3) = present;   % If these are true store it here, third column
        elseif brightness_type (ii,2) == 4          % Brightness Level 20 + Blue
            present_fovea_blue (ii,3) = present;    % If these are true store it here, third column        
        end
    end
    if brightness_type (ii,1) == 30                 % Brightness Level 30 
        if brightness_type (ii,2) == 1              % Brightness Level 30 + White
            present_fovea_white (ii,4) = present;   % If these are true store it here, fourth column
        elseif brightness_type (ii,2) == 2          % Brightness Level 30 + Red 
            present_fovea_red (ii,4) = present;     % If these are true store it here, fourth column
        elseif brightness_type (ii,2) == 3          % Brightness Level 30 + Green
            present_fovea_green (ii,4) = present;   % If these are true store it here, fourth column
        elseif brightness_type (ii,2) == 4          % Brightness Level 30 + Blue
            present_fovea_blue (ii,4) = present;    % If these are true store it here, fourth column                        
        end
    end
    if brightness_type (ii,1) == 40                 % Brightness Level 40
        if brightness_type (ii,2) == 1              % Brightness Level 40 + White 
            present_fovea_white (ii,5) = present;   % If these are true store it here, fifth column
        elseif brightness_type (ii,2) == 2          % Brightness Level 40 + Red 
            present_fovea_red (ii,5) = present;     % If these are true store it here, fifth column
        elseif brightness_type (ii,2) == 3          % Brightness Level 40 + Green
            present_fovea_green (ii,5) = present;   % If these are true store it here, fifth column
        elseif brightness_type (ii,2) == 4          % Brightness Level 40 + Blue
            present_fovea_blue (ii,5) = present;    % If these are true store it here, fifth column      
        end
    end 
    if brightness_type (ii,1) == 50                 % Brightness Level 50
        if brightness_type (ii,2) == 1              % Brightness Level 50 + White
            present_fovea_white (ii,6) = present;   % If these are true store it here, sixth column
        elseif brightness_type (ii,2) == 2          % Brightness Level 50 + Red 
            present_fovea_red (ii,6) = present;     % If these are true store it here, sixth column
        elseif brightness_type (ii,2) == 3          % Brightness Level 50 + Green
            present_fovea_green (ii,6) = present;   % If these are true store it here, sixth column
        elseif brightness_type (ii,2) == 4          % Brightness Level 50 + Blue
            present_fovea_blue (ii,6) = present;    % If these are true store it here, sixth column          
        end
    end 
    if brightness_type (ii,1) == 60                 % Brightness Level 60
        if brightness_type (ii,2) == 1              % Brightness Level 60 + White
            present_fovea_white (ii,7) = present;   % If these are true store it here, seventh column
        elseif brightness_type (ii,2) == 2          % Brightness Level 60 + Red
            present_fovea_red (ii,7) = present;     % If these are true store it here, seventh column
        elseif brightness_type (ii,2) == 3          % Brightness Level 60 + Green
            present_fovea_green (ii,7) = present;   % If these are true store it here, seventh column
        elseif brightness_type (ii,2) == 4          % Brightness Level 60 + Blue
            present_fovea_blue (ii,7) = present;    % If these are true store it here, seventh column       
        end
    end
    if brightness_type (ii,1) == 70                 % Brightness Level 70
        if brightness_type (ii,2) == 1              % Brightness Level 70 + White
            present_fovea_white (ii,8) = present;   % If these are true store it here, eigth column
        elseif brightness_type (ii,2) == 2          % Brightness Level 70 + Red
            present_fovea_red (ii,8) = present;     % If these are true store it here, eigth column
        elseif brightness_type (ii,2) == 3          % Brightness Level 70 + Green
            present_fovea_green (ii,8) = present;   % If these are true store it here, eigth column
        elseif brightness_type (ii,2) == 4          % Brightness Level 70 + Blue
            present_fovea_blue (ii,8) = present;    % If these are true store it here, eigth column  
        end
    end
    if brightness_type (ii,1) == 80                 % Brightness Level 80     
        if brightness_type (ii,2) == 1              % Brightness Level 80 + White 
            present_fovea_white (ii,9) = present;   % If these are true store it here, ninth column
        elseif brightness_type (ii,2) == 2          % Brightness Level 80 + Red 
            present_fovea_red (ii,9) = present;     % If these are true store it here, ninth column
        elseif brightness_type (ii,2) == 3          % Brightness Level 80 + Green 
            present_fovea_green (ii,9) = present;   % If these are true store it here, ninth column
        elseif brightness_type (ii,2) == 4          % Brightness Level 80 + Blue
            present_fovea_blue (ii,9) = present;    % If these are true store it here, ninth column   
        end
    end 
    if brightness_type (ii,1) == 90                 % Brightness Level 90
        if brightness_type (ii,2) == 1              % Brightness Level 90 + White  
            present_fovea_white (ii,10) = present;  % If these are true store it here, tenth column
        elseif brightness_type (ii,2) == 2          % Brightness Level 90 + Red
            present_fovea_red (ii,10) = present;    % If these are true store it here, tenth column
        elseif brightness_type (ii,2) == 3          % Brightness Level 90 + Green 
            present_fovea_green (ii,10) = present;  % If these are true store it here, tenth column
        elseif brightness_type (ii,2) == 4          % Brightness Level 90 + Blue
            present_fovea_blue (ii,10) = present;   % If these are true store it here, tenth column      
        end
    end
end

% %% Summation of Fovea
% sum_FW = sum(present_fovea_white, 'omitnan'); % Summation of the white fovea ''q'' presses, excluding nan's
% sum_FR = sum(present_fovea_red, 'omitnan');   % Summation of the red fovea ''q'' presses, excluding nan's
% sum_FG = sum(present_fovea_green, 'omitnan'); % Summation of the green fovea ''q'' presses, excluding nan's
% sum_FB = sum(present_fovea_blue, 'omitnan');  % Summation of the blue fovea ''q'' presses, excluding nan's

%% Welcome Screen Parafovea 
set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
welcome_screen = text(200,100,'HELLO AGAIN');
set(welcome_screen,'color','w');
set(welcome_screen,'fontsize', 40);
set(welcome_screen,'fontweight','bold');
welcome_screen_dir = text(200,150,'Please maintain fixation, this is the PARAFOVEA CONDITION');
set(welcome_screen_dir,'color','w');
set(welcome_screen_dir,'fontsize',20);
set(welcome_screen_dir,'fontweight','bold');
welcome_screen_next = text(200,200,'Press Q when you see a dot, press P otherwise ');
set(welcome_screen_next,'color','w');
set(welcome_screen_next,'fontsize',20);
set(welcome_screen_next,'fontweight','bold');
shg
pause
delete(welcome_screen_dir);
delete(welcome_screen_next);
delete(welcome_screen);

%% Parafovea Block
% For the parafovea condition the reasoning and organization is EXACTLY THE SAME, the only part that 
% is different is that the point move 40 pixels to the right, so if you are
% confused please look at the foveal condition.  
    stimulus(200,200,:) = 255;
    image(stimulus) 
    box off
    axis off
for ii = 1:800
    if brightness_type(ii,1) == 0
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 10
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 20
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 30
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 40
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 50
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 60
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 70
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 80
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    elseif brightness_type(ii,1) == 90
        if brightness_type(ii,2) == 1
            stimulus(200,240,:) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 2
            stimulus(200,240,1) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 3
            stimulus(200,240,2) = brightness_type(ii,1);
        elseif brightness_type(ii,2) == 4
            stimulus(200,240,3) = brightness_type(ii,1);
        end
    end
    image(stimulus)
    pause (0.3)
    stimulus(200,240,:) = 0;
    image(stimulus)
    pause 
    
    % Key Responses --------------------------------------------------------
    participant_key = get(gcf,'CurrentCharacter');
    present = strcmp('q',participant_key);
    
    if brightness_type (ii,1) == 0
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,1) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,1) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,1) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,1) = present;  
        end
    end
    if brightness_type (ii,1) == 10
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,2) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,2) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,2) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,2) = present;    
        end
    end
    if brightness_type (ii,1) == 20
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,3) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,3) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,3) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,3) = present;  
        end
    end
    if brightness_type (ii,1) == 30
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,4) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,4) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,4) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,4) = present; 
        end
    end
    if brightness_type (ii,1) == 40
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,5) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,5) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,5) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,5) = present;   
        end
    end
    if brightness_type (ii,1) == 50
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,6) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,6) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,6) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,6) = present;    
        end
    end
    if brightness_type (ii,1) == 60
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,7) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,7) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,7) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,7) = present; 
        end
    end
    if brightness_type (ii,1) == 70
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,8) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,8) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,8) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,8) = present;  
        end
    end
    if brightness_type (ii,1) == 80
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,9) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,9) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,9) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,9) = present;  
        end
    end
    if brightness_type (ii,1) == 90
        if brightness_type (ii,2) == 1
            present_parafovea_white (ii,10) = present;
        elseif brightness_type (ii,2) == 2
            present_parafovea_red (ii,10) = present;
        elseif brightness_type (ii,2) == 3
            present_parafovea_green (ii,10) = present;
        elseif brightness_type (ii,2) == 4
            present_parafovea_blue (ii,10) = present;    
        end
    end
end

%% End Screen
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

%% Data Loading
% olddir = pwd; 
% tmp = matlab.desktop.editor.getActive; 
% newdir = fileparts(tmp.Filename);  
% dc(newdir); 
load('AssignmentFiveDataToLoad.mat')

%% Summation of Parafovea
sum_PFW = sum(present_parafovea_white, 'omitnan'); % Summation of the white parafovea ''q'' presses, excluding nan's
sum_PFR = sum(present_parafovea_red, 'omitnan');   % Summation of the red parafovea ''q'' presses, excluding nan's
sum_PFG = sum(present_parafovea_green, 'omitnan'); % Summation of the green parafovea ''q'' presses, excluding nan's
sum_PFB = sum(present_parafovea_blue, 'omitnan');  % Summation of the white fovea ''q'' presses, excluding nan's

%% Summation of Fovea
sum_FW = sum(present_fovea_white, 'omitnan'); % Summation of the white fovea ''q'' presses, excluding nan's
sum_FR = sum(present_fovea_red, 'omitnan');   % Summation of the red fovea ''q'' presses, excluding nan's
sum_FG = sum(present_fovea_green, 'omitnan'); % Summation of the green fovea ''q'' presses, excluding nan's
sum_FB = sum(present_fovea_blue, 'omitnan');  % Summation of the blue fovea ''q'' presses, excluding nan's

%% Plotting 
brightness_level = [ 0 10 20 30 40 50 60 70 80 90] 

% FOVEA -------------------------------------------------
figure
set(gcf,'color','k');
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
subplot(2,1,1)
white_fovea_plot = plot(sum_FW,'color','w');
hold on
red_fovea_plot = plot(sum_FR,'color','r'); 
green_fovea_plot = plot(sum_FG,'color','g');
blue_fovea_plot = plot(sum_FB,'color','b'); 
set(gca,'color','k')
box off
xlabel('Brightness Level', 'color', 'w')
ylabel('Number of Stimuli Percieved', 'color', 'w')
set(gca, 'Xticklabel', brightness_level)
ax = gca 
ax.Color = 'w' 
ax.Color = 'w' 
lgd = legend ('Red Light' , 'Green Light', 'Blue Light', 'White Light') 
lgd.TextColor = 'w' 
title (gca, 'FOVEAL CONDITION','color','w','FontSize',16)
set(lgd,'location','southeast') 

% PARAFOVEA ----------------------------------------------------------
subplot(2,1,2)
white_parafovea_plot = plot(sum_PFW,'color','w');
hold on
red_parafovea_plot = plot(sum_PFR,'color','r'); 
green_parafovea_plot = plot(sum_PFG,'color','g');
blue_parafovea_plot = plot(sum_PFB,'color','b'); 
set(gca,'color','k')
box off
xlabel('Brightness Level', 'color', 'w')
ylabel('Number of Stimuli Percieved', 'color', 'w')
set(gca, 'Xticklabel', brightness_level)
ax = gca 
ax.XAxis.Color = 'w' 
ax.YAxis.Color = 'w' 
lgd = legend ('Red Light' , 'Green Light', 'Blue Light', 'White Light') 
lgd.TextColor = 'w' 
title (gca, 'PARAFOVEAL CONDITION','color','w','FontSize',16)
set(lgd,'location','northwest') 

%END


