clear all
clc

% Fisher's iris data consists of measurements on the 
% sepal length, sepal width, petal length, and petal width for 150 iris specimens. 
% There are 50 specimens from each of three species.
load fisheriris

% visualisation
f = figure;
gscatter(meas(:,1), meas(:,2), species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');
N = size(meas,1);

%naive bayes
X = meas(:,3:4);
Y = species;

tabulate(Y)
Mdl = fitcnb(X,Y,...
    'ClassNames',{'setosa','versicolor','virginica'})

setosaIndex = strcmp(Mdl.ClassNames,'setosa');
estimates = Mdl.DistributionParameters{setosaIndex,1}

% plot the Gaussian contours
figure
gscatter(X(:,1),X(:,2),Y);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on
Params = cell2mat(Mdl.DistributionParameters); 
Mu = Params(2*(1:3)-1,1:2); % Extract the means
Sigma = zeros(2,2,3);

for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)).^2; % Create diagonal covariance matrix
    xlim = Mu(j,1) + 4*[-1 1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[-1 1]*sqrt(Sigma(2,2,j));
    f = @(x1,x2)reshape(mvnpdf([x1(:),x2(:)],Mu(j,:),Sigma(:,:,j)),size(x1));
    fcontour(f,[xlim ylim]) % Draw contours for the multivariate normal distributions 
end
h.XLim = cxlim;
h.YLim = cylim;
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
legend('setosa','versicolor','virginica')
hold off