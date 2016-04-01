function h = wheeler2(f, x0, x1, ftol, maxit, x_star)
    i = 0;
    xkm = 0;
    xk = x0;
    xkp = x1;
    fkm = 0;
    fk = f(xk);
    fkp = f(xkp);
    if fk*fkp>0
        fprintf(1, 'Choose x_0, x_1 such that f(x_0)*f(x_1) < 0');
        return
    end
    k = 1;
    kbar = 0;
    xkbar = xk;
    fkbar = fk;
    u = 1;
    fprintf('%2d & %.7e & %.7e & %.7e & %.7e & %.7e & %.7e\\\\\n', i, xk, fk, xkp, fkp, u, xkp - x_star);
    for i = 1:maxit
        if fk == fkp || fk == 0 || fkp == 0
            break
        else
            xkm = xk;
            fkm = fk;
            xk = xkp;
            fk = fkp;
            xkp = xk - fk*((xk - xkbar)/(fk - u*fkbar));
            fkp = f(xkp);
            fprintf('%2d & %.7e & %.7e & %.7e & %.7e & %.7e & %.7e\\\\\n', i, xk, fk, xkp, fkp, u, xkp - x_star);
        end
        if fkp*fk < 0
            u = 1;
            kbar = i;
        else
            u = u/2;
        end
    end