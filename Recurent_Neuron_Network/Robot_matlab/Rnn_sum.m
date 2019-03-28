function [y,y_predicted] = Rnn_sum
choix = 2;

rng(123);
T = 8;
N = 1;
I = 30;
K = 1;
J = 9; % J number of possible outcomes (sum is between 0 and 8 -> 9)
one_column=ones([I,1]);
F = rand([I,K]);    %f is random values btw 0 and 1 on a I size vector for the moment

X = randi([0 1],I,T);    %inputs
y = sum(X,2)      %ouput : sum of each line
y_predicted = randi([0 8],I,1);
Vs = rand();
Vx = rand();
S_current = randi([0 8],I,1);
S_previous = randi([0 8],I,1);
S_temp = S_current;

dE_dVx_prev = 1;
dE_dVx_curr = 1;
deltaX = 0.001;

dE_dVs_prev = 1;
dE_dVs_curr = 1;
deltaS = 0.001;

alpha_one = 0.1;
alpha_two = 0.2;

if( (choix~=1) && (choix~=2) )
    print('Error in choice');
else
    for cpt = 1:10000
        %Loop to compute S
        % S(t) = S(t-1)*Vs + Vx * x(i)t
        
        for i = 1:I
            for t = 1:T
                S_current(i) = S_previous(i)*Vs + Vx*X(i,t);
                S_previous(i) = S_temp(i);
                S_temp(i) = S_current(i);
            end
        end
        %We set the Y predicted
        y_predicted = S_current;
        
        % The computation of dE / dVx
        calc_one = transpose(y_predicted - y)*X;
        dE_dVx_curr = 0;
        for t = 1:T
            dE_dVx_curr = dE_dVx_curr + calc_one(t)*Vs^(T-t);
        end
        
  %      dE_dVx_curr = sum((((y_predicted - Y).*x).*Vx.^(N-(1-N)))); (:)
        
        
        % The computation o dE / dVs
        calc_two= transpose(y_predicted-y);
        for t=1:T
            calc_two(t)=calc_two(t)*Vs^(T-t);
        end
        dE_dVs_curr=calc_two*S_current;
        
 %       dE_dVs_curr = sum((((Y_pred - Y).*S_previous*Vs.^(T-(1-T))))); (:)
        
        %BACKWARD PROPAGATION
        if(choix==1)
            Vx = Vx - alpha_one*dE_dVx_curr;
            Vs = Vs - alpha_two*dE_dVs_curr;
        end
        
        %RESILIENT PROPAGATION
        if(choix==2)
            %Pour Vx
            if( sign(dE_dVx_curr) == sign(dE_dVx_prev) )
                deltaX = deltaX*1.2;
            else
                deltaX = deltaX*0.5;
            end
            
            Vx = Vx - sign(dE_dVx_curr)*deltaX;
            dE_dVx_prev = dE_dVx_curr;
            
            %¨Pour Vs
            if( sign(dE_dVs_curr) == sign(dE_dVs_prev) )
                deltaS = deltaS*1.2;
            else
                deltaS = deltaS*0.5;
            end
            Vs = Vs - sign(dE_dVs_curr)*deltaS;
            dE_dVs_prev = dE_dVs_curr;
        end
    end
    
    y_predicted = int32(y_predicted);
end