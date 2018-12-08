% il faudrait aussi tester quelle valeur de K donne la meilleure précision (erreur minimale)
% il faudrait aussi diviser notre dataset en training_set et test_set

my_data=load('./Files/data.txt')
N=2;
K=5;
J=2;
y= my_data(:,3);
x= my_data(:,1:2);
v = rand([3,5]);
w = rand([6,2]);
I = 51;

one_column=ones([51,1]);

x_bar= [one_column x];
x_bar_bar= x_bar*v;

F=1./(ones([51,5])+exp(-1*x_bar_bar));
F_bar = [one_column F];
F_bar_bar = F_bar* w;

G=1./(ones([51,2])+exp(-1*F_bar_bar));
alpha1 = 0.0001;
alpha2 = 0.0001;

Yg = [~y,y];

% optimisation loop (we "fit" the data model)
% we want to optimise v and w to minimize the error
for cpt = 1:100000
  %compute w 
  a = transpose ((G-Yg) .* G .* (1-G));
  b = a * F_bar;
  w = w - alpha1 * transpose(b);
  %compute v
  a = (G-Yg) .* G .* (1-G);
  w_moins_ligne = w(2:6,:);
  b = a * transpose(w_moins_ligne) .* F .* (1-F);
  c = transpose(b) * x_bar;
  v = v - alpha2 * transpose(c);
end

% we print our model
v
w

% We give as an entry all the x and we see what the model predicts
x_bar= [one_column x];
x_bar_bar= x_bar*v;
F=1./(ones([51,5])+exp(-1*x_bar_bar));
F_bar = [one_column F];
F_bar_bar = F_bar* w;
% We compute and print G the probability of each entry class
G=1./(ones([51,2])+exp(-1*F_bar_bar))

% code to print the most probable class
%for i = 1:I 
 % i
  %[argvalue, argmax] = max(G(i,:));
  %result = argmax - 1
%end