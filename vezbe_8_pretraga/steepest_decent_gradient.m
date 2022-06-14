% Steepest Descend Algorithm with optimum step size computation
% Obaid Mushtaq
% Munich University of Technology, Germany

% This is a small example code for "Steepest Descent Algorithm". 
% It implements steepest descent Algorithm with optimum step size computation at each step. 
% The code uses a 2x2 correlation matrix and solves the Normal equation for Weiner filter iteratively.

clear
R=[1 1/2; 1/2 1];
p=[1/2 1/4]';

% Choose an initial step size (a random one but from the limits)
a=0;
b=2/trace(R);
steps = a + (b-a).*rand(10,1);
step=steps(ceil(10*rand(1,1)));

fprintf('-----------------------------------------------------\n');
fprintf(' Upper bound for step size: %d\n ',0);
fprintf('Lower bound for step size [ 2/trace(R) ] : %f\n ',b);
fprintf('Chosen initial step size: %f\n ',step);

% Initialize the weights
w_initial=zeros(2,1);

% Steepest Descend Algorithm with optimum step size computation on 
% each iteration
k=2;
while 1
    w_new=w_initial + step*(p-R*w_initial);
    % Stopping criterion
    if norm(p-R*w_initial) < 1e-5
        % Print the results on success!
        fprintf('Optimum Weight Vector is:\n')
        Wopt=w_new
        % Number of interations performed by algorithm
        fprintf('Number of iterations: %d\n',k-1)
        fprintf('-----------------------------------------------------\n');
        break
    else
        w_initial=w_new;
        %Update the step size by finding the optimum step size
        step=(p-R*w_initial)'*(p-R*w_initial)/((p-R*w_initial)'*R*(p-R*w_initial));
        k=k+1;
    end
end