% Valentin Larrieu
%PCA

% data generation
% we are going to generate data following a 2D linear model: y = ax+b
% we have decided to use a=2 and b=5
% we will use a noise "r" in [-10% ; +10%]
I = 100;
x = 100+(rand(I,1))*100; % x between 100 and 200
y = zeros(I,1);
a = 2;
b = 5;

for i=1:I
  r = (rand - 0.5)/5; % r in [-0.1;+0,1]
  y(i) = (a*x(i)+b) * (1+r);
end
data = [x y];

%scatter(data(:,1),data(:,2),50,[1 0 0]);
%hold on;
figure
ax1 = subplot(3,1,1);
scatter(ax1,data(:,1),data(:,2),50,[1 0 0],'filled');
title(ax1,'Input Data')

% Pre-processing
mu = mean(data);
for i=1:I
  data(i,:) = data(i,:) - mu;
end
%scatter(data(:,1),data(:,2),50,[0 0 1]);
ax2 = subplot(3,1,2);
scatter(ax2,data(:,1),data(:,2),50,[0 0 1],'filled');
title(ax2,'Pre-processed Data')

%compute sigma
sigma = cov(data);

% compute eigenvectors of sigma
[U S V] = eig(sigma); % EIG and not SVD because we want eigenvectors and not singular vectors !

% build vector "u" using the K most significant eigenvectors of sigma
u = U(:,2) % most important is the last one with eig
% u is the main axis

% project pre-processed data onto U
output = zeros(I,1);
for i=1:I
  output(i) = data(i,:) * u;
end

% post-processing
newMu = mu * u;
for i=1:I
  output(i) = output(i) + newMu;
end

ax3 = subplot(3,1,3);
%scatter(ax3,output(:,1),zeros(I,1),50,[0 0 1],'filled','+');
plot(ax3,output(:,1),zeros(I,1),'+');
title(ax3,'Reduced Data')

%we can see that the "order" of the values is conserved after PCA (good!)
%[minValueInput,index] = min(data(:,2))
%[maxValueInput,indexx] = max(data(:,2))
%[minValueOutput,indexxx] = min(output)
%[maxValueOutput,indexxxx] = max(output)

stats_output = [ min(output) mean(output) max(output) ]

%output

% TESTING with new data:
x_test1 = [150 305];
x_reduced1 = x_test1 * u % should be predicted around the mean of the reduced dataset 

x_test2 = [200 405];
x_reduced2 = x_test2 * u % should be predicted around the max of the reduced dataset
% note: when we say "around" it's because of the noise in the initial dataset
% which caused the dataset not to be exactly between x = 100 and x = 200


