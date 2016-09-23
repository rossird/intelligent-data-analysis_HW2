function HW2
clear all; clc; close all;
% Homework 2 for Intelligent Data Analysis
% Ricky Rossi
% September 21, 2016
% Columns 1-4 are attribute data.
% Column 5 is assigned class value.

%% Read in data
d1 = xlsread('data_banknote_authentication.xlsx');

%% Calculate covariance
cm = cov(d1);

%% Pull out the classes
D10=d1(d1(:,5)==0,:);   % Class 0
D11=d1(d1(:,5)==1,:);   % Class 1

%% Scatter plot attributes 1,2
hold on;
scatter(D10(:,1),D10(:,2),'k')  % Class 0, attribute 1, attribute 2
scatter(D11(:,1),D11(:,2),'r')  % Class 1, attribute 1, attribute 2
legend('Class 0','Class 1')
title('Attributes 1 and 2')

%% Scatter plot attributes 2,4
figure
hold on;
scatter(D10(:,2),D10(:,4),'k')  % Class 0, attribute 2, attribute 4
scatter(D11(:,2),D11(:,4),'r')  % Class 1, attribute 2, attribute 4
legend('Class 0','Class 1')
title('Attributes 2 and 4')

%% Scatter plot attribute 3 and class label
figure
hold on;
scatter(D10(:,3),D10(:,5),'k')  % Class 0, attribute 3, class label
scatter(D11(:,3),D11(:,5),'r')  % Class 1, attribute 3, class label
legend('Class 0','Class 1')
title('Attribute 3 and class label')

%% Get random training data
train_idx = randperm(length(d1)); % Random permutation of 1 to length(d1)
train_idx = train_idx(1:1000);    % Pull out first 1000 random integers
test_idx = setdiff(1:length(d1), train_idx);
training_set = d1(train_idx,:);
testing_set = d1(test_idx, :);

% Make decision tree - min leaf = 5
tree_5 = ClassificationTree.fit(training_set(:,1:4), training_set(:,5), 'MinLeaf', 5);
view(tree_5, 'Mode', 'Graph')
predict_5 = tree_5.predict(testing_set(:,1:4));
confMat_5 = confusionmat(predict_5, testing_set(:,5));
[acc_5, prec_5, recall_5] = ProcessConfusionMat(confMat_5);
disp('Confusion matrix for MinLeaf=5')
disp(confMat_5);
fprintf('Accuracy: %0.2f\tPrecision: %0.2f\tRecall: %0.2f\n\n',acc_5, prec_5, recall_5);

% Make decision tree - min leaf = 25
tree_25 = ClassificationTree.fit(training_set(:,1:4), training_set(:,5), 'MinLeaf', 25);
view(tree_25, 'Mode', 'Graph')
predict_25 = tree_25.predict(testing_set(:,1:4));
confMat_25 = confusionmat(predict_25, testing_set(:,5));
[acc_25, prec_25, recall_25] = ProcessConfusionMat(confMat_25);
disp('Confusion matrix for MinLeaf=25')
disp(confMat_25);
fprintf('Accuracy: %0.2f\tPrecision: %0.2f\tRecall: %0.2f\n\n',acc_25, prec_25, recall_25);

% Make decision tree - min leaf = 50
tree_50 = ClassificationTree.fit(training_set(:,1:4), training_set(:,5), 'MinLeaf', 50);
view(tree_50, 'Mode', 'Graph')
predict_50 = tree_50.predict(testing_set(:,1:4));
confMat_50 = confusionmat(predict_50, testing_set(:,5));
[acc_50, prec_05, recall_50] = ProcessConfusionMat(confMat_50);
disp('Confusion matrix for MinLeaf=50')
disp(confMat_50);
fprintf('Accuracy: %0.2f\tPrecision: %0.2f\tRecall: %0.2f\n', acc_50, prec_05, recall_50);

end

function [accuracy, precision, recall] = ProcessConfusionMat(confusionMat)
    TP = confusionMat(1,1);
    FP = confusionMat(2,1);
    TN = confusionMat(2,2);
    FN = confusionMat(1,2);
    accuracy = (TP+TN)/(TP+TN+FP+FN);
    precision = TP/(TP+FP);
    recall = TP/(TP+FN);
end