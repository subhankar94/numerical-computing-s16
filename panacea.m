function h = find_interval(f, x0, varargin)
% This function takes a function f
%   and an initial x_0 value, and then
%   steps left and right from x_0
%   looking for an interval where the
%   sign of f changes. Step size increases
%   with succesive step. The method keeps
%   track of the slope between left side
%   and right side steps and alerts for
%   a change in sign of the slope and 
%   therefore a potential interval.

% set up variables
tol = 1e-16;
if nargin < 3
    maxiter = 4000;
else
    maxiter = varargin{1};
end
iter = 0;
l1 = 0; l2 = 0;
fl1 = 0; fl2 = 0;
r1 = 0; r2 = 0;
fr1 = 0; fr2 = 0;
lslope1 = 0; lslope2 = 0; rslope1 =0; rslope2 = 0;
step = 0;

if x0 == 0
    step = 0.5;
else
    step = max(log(abs(x0))/log(10), tol);
end

l1 = x0 - step;
fl1 = f(l1);
r1 = x0 + step;
fr1 = f(r1);

if fl1*fr1<0
    fprintf('Left: %.7e, Right: %.7e', l1, r1);
    h = 1;
    return
end

step = step*2;

l2 = l1;
fl2 = fl1;
l1 = l1 - step;
fl1 = f(l1);
lslope1 = fl2-fl1;
if fl1*fl2 < 0
    fprintf('Left: %.16e, Right: %.16e', l1, l2)
    h = 1;
    return
end

r2 = r1;
fr2 = fr1;
r1 = r1 + step;
fr1 = f(r1);
rslope1 = fr1-fr2;
if fr1*fr2 < 0
    fprintf('Left: %.7e, Right: %.7e', r2, r1)
    h = 1;
    return
end

while iter<maxiter 
    iter = iter + 1;
    if step > 1
        step = step^2;
    else
        step = step*100;
    end
    
    l2 = l1;
    fl2 = fl1;
    l1 = l1 - step;
    fl1 = f(l1);
    if ~isnumeric(fl1) || isnan(fl1) || isinf(fl1)
        break
    end
    if fl1*fl2 < 0
        fprintf('Left: %.7e, Right: %.7e', l1, l2)
        h = 1;
        return
    end
    lslope2 = lslope1;
    lslope1 = fl2-fl1;
    
    if lslope1*lslope2 < 0
        % sign of slope changed
        % potential zero in between
        fprintf('Sign of slope changes in %.7e unit vicinity around %.7e\n', step, l2);
    end
    
    r2 = r1;
    fr2 = fr1;
    r1 = r1 + step;
    fr1 = f(r1);
    if ~isnumeric(fr1) || isnan(fr1) || isinf(fr1)
        break
    end
    if fr1*fr2 < 0
        fprintf('Left: %.7e, Right: %.7e', r2, r1)
        h = 1;
        return
    end
    rslope2 = rslope1;
    rslope1 = fr1-fr2;
    
    if rslope1*rslope2 < 0
        % sign of slope changed
        % potential zero in between
        fprintf('\nSign of slope changes in %.7e unit vicinity around %.7e\n\n', step, r2);
    end
end 

if fl1*fr1<0
    fprintf('Left: %.7e, Right: %.7e', l1, r1);
    h = 1;
    return
end

h = 0;
fprintf('Could not find a suitable interval');
return 
