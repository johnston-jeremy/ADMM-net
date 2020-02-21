P = 100;
Ez = zeros(P,1);
Ezz = zeros(P,1);
for p = 1:P
%     MIMO_doppler
%     MIMO
%     single_antenna_doppler
    single_antenna
    Ez(p) = e_z;
    Ezz(p) = e_zz;
end
% stem(Ez)
% hold
mean(Ez)
% mean(Ezz)