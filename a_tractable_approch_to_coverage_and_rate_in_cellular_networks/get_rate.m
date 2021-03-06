function [ rate ] = get_rate( lambda, alpha, mu, sigma )
%get_rate return the average achievable rate
%   Input:
%   lambda, intensity of PPP
%   alpha, path loss exponent
%   SNR, no noise if SNR = 0 else other constants
%   SNR =  1 / ( mu * sigma)
%   Output:
%   rate, the average achievable rate

if abs(sigma) <= 1e-9    % No Noise
    syms x; syms t;
    rate = double(int(1 / (1 + (exp(t) - 1)^(2/alpha) * int(1 / (1 + x^(alpha/2)), x, (exp(t) - 1)^(-2/alpha), inf)), t, 0, inf));
elseif alpha == 4        % alpha = 4
    syms t;
    at = 1 + sqrt(exp(t) - 1) * (pi/2 - atan(1/sqrt(exp(t) - 1)));
    bt = sigma^2 * mu * (exp(t) - 1) / (pi * lambda)^2;
    rate = double(int(sqrt(pi / bt) * exp(at^2 / (4 * bt)) * qfunc(at / sqrt(2 * bt)), t, 0, inf));
else    % General Case
    syms r; syms t; syms x;
    L = exp(-pi * lambda * r^2  * (exp(t) - 1)^(2/alpha) * int(1 / (1 + x^(alpha/2)), x, (exp(t) - 1)^(-2/alpha), inf));
    rate = double(int(exp(-pi * lambda * r^2) * 2 * pi * lambda * r * int(exp(- sigma^2 * mu * r^alpha * (exp(t) - 1)) * L, t, 0, inf), r, 0, inf));
end

