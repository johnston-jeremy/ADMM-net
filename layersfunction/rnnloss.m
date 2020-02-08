function Y = rnnloss(x, b, DzDy )
%% rnnloss: calculate the NMSE of restored image and original image
%% x: reconstructed image of size m;
%% b: ground-truth image of size m;

b_norm = norm(b);

if nargin == 2
 s = x - b ;
 Y = norm(s) / b_norm ;
elseif nargin ==3
 s = x - b ;
 Y1 = norm(s) ;   
 Y = s /(b_norm*Y1);
else
    error('Input arguments number not proper.');
end
end