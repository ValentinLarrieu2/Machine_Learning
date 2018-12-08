% Valentin Larrieu
% KMeans
K = 4;
I = 40;

%Random 2D generation
data1 = normrnd(50,3,[10,2]);
data2 = normrnd(-50,1,[10,2]);
data3 = [normrnd(50,2,[10,1]) normrnd(-50,4,[10,1])];
data4 = [normrnd(-50,5,[10,1]) normrnd(50,6,[10,1])];

data = [data1;data2;data3;data4];

%Cluster centroid random initialisation
%mu= [data(randi(I),:) ; data(randi(I),:) ; data(randi(I),:) ; data(randi(I),:)];
mu = [rand(1,2)*200-100;rand(1,2)*200-100;rand(1,2)*200-100;rand(1,2)*200-100];

y = zeros(I,1);

for cpt=1:6
  % prediction
  for i=1:I
    distance1 = norm(data(i,:) - mu(1,:));
    distance2 = norm(data(i,:) - mu(2,:));
    distance3 = norm(data(i,:) - mu(3,:));
    distance4 = norm(data(i,:) - mu(4,:));
  
    distances = [distance1; distance2; distance3; distance4];
    [argvalue, argindex] = min(distances);
    y(i) = argindex;
  end
    
  % update mu(k)
  for k=1:K
    sumOfCoordinatesX1InCluster=0;
    sumOfCoordinatesX2InCluster=0;
    for i=1:I
      if(y(i)==k)
        sumOfCoordinatesX1InCluster = sumOfCoordinatesX1InCluster + data(i,1);
        sumOfCoordinatesX2InCluster = sumOfCoordinatesX2InCluster + data(i,2);
      end
    end
    nbPointsInCluster = sum(sum(y == k));
    if nbPointsInCluster==0 
      newIndex = randi(I);
      %mu(k,1) = data(newIndex,1);
      %mu(k,2) = data(newIndex,2);
      mu(k,1) = rand*200-100;
      mu(k,2) = rand*200-100;
    else
      mu(k,1) = sumOfCoordinatesX1InCluster/nbPointsInCluster;
      mu(k,2) = sumOfCoordinatesX2InCluster/nbPointsInCluster;
    end
  end
end

clf('reset')
scatter(data(:,1),data(:,2),30,y,'filled');
hold on;
%scatter(mu(:,1),mu(:,2),600,[1 0 0],'filled','+'); % for some reason doesn't work on matlab
plot(mu(:,1),mu(:,2),'+','MarkerSize',25);
% NOTE: occasionally it might get stuck in a local minima and not find the expected answer
% but this (rare) problem can be avoided by running several times the algorithm and keeping
% the answer that minimizes the distance between a cluster centroid and its cluster points

%y
%mu

%testing with new data:
x_test = [55 55];
distance1 = norm(x_test - mu(1,:));
distance2 = norm(x_test - mu(2,:));
distance3 = norm(x_test - mu(3,:));
distance4 = norm(x_test - mu(4,:));
  
distances = [distance1; distance2; distance3; distance4];
[argvalue, argindex] = min(distances);
y_test = argindex
cluster_predicted = mu(argindex,:)

% we see that the new point is predicted to be in cluster "argindex", and this cluster hash
% the centroid "mu(argindex,:)
% we can then check on the graph if it's correct !
