function x = nal_nbk_mcg(A,B,mcg_index)
% --------------------------------------------------------------------------------------------
% Syntax : x = nal_nbk_mcg(A,B,mcg_index) 
%
% This is modified conjugate gredient method to solve the system of  equation Ax = B,
% here we have take x = zeros(length(B),1) as our initial guess.
% --------------------------------------------------------------------------------------------

% -------------------------------- written on : Mar 12, 2018 ---------------------------------
   mcg_index_plus_one = mcg_index + 1;
   x = zeros(length(B),1);
   col_size_of_A = length(x);
   r = B - A*x;
   p = r;
   iter = 0;
   for k = 1:100 %length(B) % since modified CG generate the exact solution to linear system 
       iter = iter + 1; % variable for iteration
       Ap = A * p;
       alpha = (r(1:mcg_index)'*p(1:mcg_index) - r(mcg_index_plus_one:col_size_of_A)'*p(mcg_index_plus_one:col_size_of_A))/(p(1:mcg_index)' * Ap(1:mcg_index) - p(mcg_index_plus_one:col_size_of_A)'*Ap(mcg_index_plus_one:col_size_of_A));
       x = x + alpha * p;
%       size (alpha)
       rold = r;
        r = r - alpha * Ap;
        temp1 = max(abs(r - rold));
        if (temp1 < 1e-6)
          iter;
           break;
       end
       beta = -(r(1:mcg_index)'*Ap(1:mcg_index) -r(mcg_index_plus_one:col_size_of_A)'*Ap(mcg_index_plus_one:col_size_of_A))/(p(1:mcg_index)' * Ap(1:mcg_index) - p(mcg_index_plus_one:col_size_of_A)'*Ap(mcg_index_plus_one:col_size_of_A));
       p = r + beta * p;

   end

end

 
