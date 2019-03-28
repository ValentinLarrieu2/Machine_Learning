gamma = 0.99;
v = zeros([5,6]);
pi = zeros([5,6]);
%v_prec = ones([5,6]);
Rs = 0;

%Value iteration

%while abs(sum(sum(v),2) - sum(sum(v_prec),2)) > 2 
for i=1:10
  for lig=2:4
    for col=2:5 
      if ~(lig==3 && col==3) % If we are not on the obstacle
        if(lig==2 && col==5)
          Rs=1;
        elseif(lig==3 && col==5)
          Rs=-1;
        else
          Rs=-0.02;
        end
        left = 0.8*v(lig,col-1) + 0.1*v(lig-1,col) + 0.1*v(lig+1,col);
        right = 0.8*v(lig,col+1) + 0.1*v(lig-1,col) + 0.1*v(lig+1,col);
        down = 0.8*v(lig-1,col) + 0.1*v(lig,col-1) + 0.1*v(lig,col+1);
        up = 0.8*v(lig+1,col) + 0.1*v(lig,col-1) + 0.1*v(lig,col+1);
        v(lig,col) = Rs + gamma * max([left right up down]);
      end
    end
  end 
  %v
  %v_prec
  %abs(sum(sum(v),2) - sum(sum(v_prec),2))
  %v_prec = v;
end  

%Policy iteration


%for i=1:10
    for lig=2:4
      for col=2:5
        left = 0.8*v(lig,col-1) + 0.1*v(lig-1,col) + 0.1*v(lig+1,col);
        right = 0.8*v(lig,col+1) + 0.1*v(lig-1,col) + 0.1*v(lig+1,col);
        up = 0.8*v(lig-1,col) + 0.1*v(lig,col-1) + 0.1*v(lig,col+1);
        down = 0.8*v(lig+1,col) + 0.1*v(lig,col-1) + 0.1*v(lig,col+1);
        [maxvalue, maxindex] = max([left right up down]);
        if ~(lig==2 && col==5) && ~(lig==3 && col==5) && ~(lig==3 && col==3) 
            pi(lig,col) = maxindex;
        end
      end
    end
%end


pi