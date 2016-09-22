clear all; clc; close all;
% Homework 2 for Intelligent Data Analysis
% Ricky Rossi
% September 21, 2016

% Read in data
d1 = xlsread('data_banknote_authentication.xlsx');

% Calculate covariance
cm = cov(d1);

% Pull out the classes
D10=d1(d1(:,5)==0,:);   % Class 0
D11=d1(d1(:,5)==1,:);   % Class 1

% Scatter plot attributes 1,2
hold on;
scatter(D10(:,1),D10(:,2),'k')  % Class 0, attribute 1, attribute 2
scatter(D11(:,1),D11(:,2),'r')  % Class 1, attribute 1, attribute 2
legend('Class 0','Class 1')
title('Attributes 1 and 2')

% Scatter plot attributes 2,4
figure
hold on;
scatter(D10(:,2),D10(:,4),'k')  % Class 0, attribute 2, attribute 4
scatter(D11(:,2),D11(:,4),'r')  % Class 1, attribute 2, attribute 4
legend('Class 0','Class 1')
title('Attributes 2 and 4')

% Scatter plot attribute 3 and class label
figure
hold on;
scatter(D10(:,3),D10(:,5),'k')  % Class 0, attribute 3, class label
scatter(D11(:,3),D11(:,5),'r')  % Class 1, attribute 3, class label
legend('Class 0','Class 1')
title('Attribute 3 and class label')

% Train data
rand_idx = randi(length(d1),1000,1);
training_set = d1(rand_idx,:);
