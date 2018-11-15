% Pascal Coding Class
% Assignment Eight 
% April. 22nd. 2018 
% Helena Palmieri 

%% Preface 
% This code is meant to analyses the data from the Levenson Self-Report
% Psychopathy Scale (LSRP). 
clear all 
close all
clc

% Deshawn Sambrano's Code -------------
olddir = pwd; 
tmp = matlab.desktop.editor.getActive; 
newdir = fileparts(tmp.Filename); 
cd(newdir); 
% -------------------------------------

%% Loading the Data 
xlsread('LSRP')  % Loading the excel file

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
shg
pause

%% Reverse Coding 
% This section of code takes columns 6, 14, 19, 22, 24, 25, 26 and
% subtracts 6 from all the scores in the rows that correspond to that
% column. 
% For example: if the original score is a 4, it will now be a 2 (6 - 4 = 2)
data_reversed = ans; 
data_reversed (:,[6,14,19,22,24:26]) = 6 - data_reversed (:,[6,14,19,22,24:26]);   
        
%% Removing the Missing Data 
% This section of code reassigns the data to data_cleaned, I then find the
% locations of all the nans, finally I take those row positions and if there is a
% nan in that row I delete the entire row. 
data_cleaned = data_reversed;
[row,col] = find(isnan(data_cleaned));
data_cleaned(row,:) = []; 

%% Histrogram Explaination
figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
histogram_text = text(0.5,0.9,'Next you will see a histogram of the participant total scores','HorizontalAlignment','center');
set(histogram_text,'color','k');
set(histogram_text,'fontsize', 20);
set(histogram_text,'fontweight','bold');
pause

%% Histogram 
% In this section of code I am finding the summation of all the scores per
% participant across the all of the columns. 
data_summation = sum(data_cleaned,2); 

% Here I am plotting the summation data on a histogram. 
figure     
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
histogram(data_summation)
title(gca,'Summation','color','k','FontSize',16)
box off
set(gca,'TickDir','out')
xlabel('Scores')
ylabel('Number of Participants')
shg 
pause

%% PCA Explaination 
figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
pca_text = text(0.5,0.9,'Next you will see a bargraph of the PCA','HorizontalAlignment','center');
set(pca_text,'color','k');
set(pca_text,'fontsize', 20);
set(pca_text,'fontweight','bold');

%% PCA 
% In this section of code we are finding the PCA of all 31 questions. 
[eigVec, rotVal, eigVal] = pca (data_cleaned);  
% Here I am graphing the eigVal, aka how much is a particular question
% contributing to the conclusion of the LSRP, relative to the total. 
figure    
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
bar(eigVal)
title(gca,'PCA','color','k','FontSize',16)
xlabel('Factors')
ylabel('eigVal')
box off
set(gca,'TickDir','out')
% Here we are adding the Kaiser Rule to determine the amount of factors
% we have. 
l = line([0 32], [1 1], 'color','r');  
shg 
pause 

%% Explaination Screen
figure
set(gcf,'menubar','none');
set(gcf,'toolbar','none');
axis off;
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
elbow = text(0.5,0.9,'According to the Elbow Rule there are 5 factors','HorizontalAlignment','center');
set(elbow,'color','k');
set(elbow,'fontsize', 20);
set(elbow,'fontweight','bold');
kaiser = text(0.5,0.7,'According to the Kaiser Rule there are 18 factors','HorizontalAlignment','center');
set(kaiser,'color','k');
set(kaiser,'fontsize',20);
set(kaiser,'fontweight','bold');
deshawn = text(0.5,0.5,'According to what Deshawn said in recitation (.7 minimum) there are 11 factors','HorizontalAlignment','center');
set(deshawn,'color','k');
set(deshawn,'fontsize',20);
set(deshawn,'fontweight','bold');
direction = text(0.5,0.3,'Following this you will see the plotting of the Elbow Rule and the Deshawn Rule','HorizontalAlignment','center');
set(direction,'color','k');
set(direction,'fontsize',20);
set(direction,'fontweight','bold');
shg
pause

%% Kaiser Rule
% According to the Kaiser Rule there are 18 important factors that should
% be considered that account for .85 percent of the variance which is great
% but that's TOO MANY factors. 

%% Elbow Rule
% According to the Elbow Rule there are 5 important factors that should
% be considered that account for .5 percent of the variance which is a more
% reasonable amount of factors but the explained variance is LOW.
% Below I am graphing all 5 factors compared to on another. 

A = rotVal (:,1); 
B = rotVal (:,2); 
C = rotVal (:,3); 
D = rotVal (:,4); 
E = rotVal (:,5); 

figure 
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
title(gca,'Elbow Rule')
set(gca,'TickDir','out')

subplot(2,5,1)
plot(A,B, '.') 
box off
set(gca,'TickDir','out')
title (gca, '1 vs. 2','color','k','FontSize',16)
xlabel('Factor 1')
ylabel('Factor 2')
axis equal

subplot(2,5,2) 
plot(A,C, '.') 
box off
set(gca,'TickDir','out')
title (gca, '1 vs. 3','color','k','FontSize',16)
xlabel('Factor 1')
ylabel('Factor 3')
axis equal

subplot(2,5,3) 
plot(A,D, '.')
box off
set(gca,'TickDir','out')
title (gca, '1 vs. 4','color','k','FontSize',16)
xlabel('Factor 1')
ylabel('Factor 4')
axis equal

subplot(2,5,4)
plot(A,E, '.')
box off
set(gca,'TickDir','out')
title (gca, '1 vs. 5','color','k','FontSize',16)
xlabel('Factor 1')
ylabel('Factor 5')
axis equal

subplot(2,5,5)
plot(B,C, '.') 
box off
set(gca,'TickDir','out')
title (gca, '2 vs. 3','color','k','FontSize',16)
xlabel('Factor 2')
ylabel('Factor 3')
axis equal

subplot(2,5,6)
plot(B,D, '.')
box off
set(gca,'TickDir','out')
title (gca, '2 vs. 4','color','k','FontSize',16) 
xlabel('Factor 2')
ylabel('Factor 4')
axis equal

subplot(2,5,7)
plot(B,E, '.')
box off
set(gca,'TickDir','out')
title (gca, '2 vs. 5','color','k','FontSize',16)
xlabel('Factor 2')
ylabel('Factor 5')
axis equal

subplot(2,5,8)
plot(C,D, '.') 
box off
set(gca,'TickDir','out')
title (gca, '3 vs. 4','color','k','FontSize',16)
xlabel('Factor 3')
ylabel('Factor 4')
axis equal

subplot(2,5,9) 
plot(C,E, '.')
box off
set(gca,'TickDir','out')
title (gca, '3 vs. 5','color','k','FontSize',16)
xlabel('Factor 3')
ylabel('Factor 5')
axis equal

subplot(2,5,10)
plot(D,E, '.') 
box off
set(gca,'TickDir','out')
title (gca, '4 vs. 5','color','k','FontSize',16)
xlabel('Factor 4')
ylabel('Factor 5')
axis equal
shg 
pause

%% Deshawn's Rule
% According to Deshawn in recitation the minimal explained variance that is
% acceptable is .7 and if that is our rule there are 11 factors. 

% This "for" loop below will add the explained variance until it reaches .7

total_variance = nan(31,1);
i = 1;
while (sum(total_variance,'omitnan')./sum(eigVal)) < 0.7
        total_variance(i) = eigVal(i);
        i = i + 1;
end
variance_accounted = sum(total_variance,'omitnan')./sum(eigVal);
total_components_sevenity = i - 1;

%% Plotting Deshawn's Rule
figure
set(gcf,'menubar','none'); 
set(gcf,'toolbar','none'); 
axis off; 
axis square; 
axis equal; 
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
title(gca,'Elbow Rule')
box off
set(gca,'TickDir','out')

% The "for" loops below are for plotting the 66 subplots for the 11 factors
% if we are following Deshawn's Rule of .7 being the minimum acceptable
% answer. 

j = 1;
for i = 1:10;
    one1 = 1;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,one1),rotVal(:,j),'.')
    title([num2str(one1),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 2;
i = 0;
for i = 11:19;
    two2 = 2;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,two2),rotVal(:,j),'.')
    title([num2str(two2),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 3;
i = 0;
for i = 20:27;
    three3 = 3;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,three3),rotVal(:,j),'.')
    title([num2str(three3),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 4;
i = 0;
for i = 28:34;
    four4 = 4;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,four4),rotVal(:,j),'.')
    title([num2str(four4),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 5;
i = 0;
for i = 35:40;
    five5 = 5;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,five5),rotVal(:,j),'.')
    title([num2str(five5),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 5;
i = 0;
for i = 35:40;
    five5 = 5;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,five5),rotVal(:,j),'.')
    title([num2str(five5),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 6;
i = 0;
for i = 41:45;
    six6 = 6;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,six6),rotVal(:,j),'.')
    title([num2str(six6),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 7;
i = 0;
for i = 46:49;
    seven7 = 7;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,seven7),rotVal(:,j),'.')
    title([num2str(seven7),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 8;
i = 0;
for i = 50:52;
    eight8 = 8;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,eight8),rotVal(:,j),'.')
    title([num2str(eight8),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 9;
i = 0;
for i = 53:54;
    nine9 = 9;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,nine9),rotVal(:,j),'.')
    title([num2str(nine9),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
j = 10;
i = 0;
for i = 55;
    ten10 = 10;
    j = j + 1;
    subplot(5,11,i)
    plot(rotVal(:,ten10),rotVal(:,j),'.')
    title([num2str(ten10),' vs. ',num2str(j)],'color','k')
    box off
    axis equal
end
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
end_screen_next = text(0.5,0.3,'In the end 11 factors might be the best answer','HorizontalAlignment','center');
set(end_screen_next,'color','k');
set(end_screen_next,'fontsize',20);
set(end_screen_next,'fontweight','bold');
shg
pause
