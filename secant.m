function h = secant(f, x0, x1, ftol, maxit, x_star)
    i = 0;
    xkm = 0;
    xk = x0;
    xkp = x1;
    fkm = 0;
    fk = f(xk);
    fkp = f(xkp);
    fprintf('%2d & %7f & %7f & %7f & %7f & %7f & %7f\\\\\n', i, xk, fk, xkp, fkp, xkp - x_star, abs(xkp - x_star)/abs(xk - x_star));
    for i = 1:maxit
        if fk == fkp || fk == 0 || fkp == 0
            break
        else
            xkm = xk;
            fkm = fk;
            xk = xkp;
            fk = fkp;
            xkp = xk - fk*((xk - xkm)/(fk - fkm));
            fkp = f(xkp);
            fprintf('%2d & %7f & %7f & %7f & %7f & %7f & %7f\\\\\n', i, xk, fk, xkp, fkp, xkp - x_star, abs(xkp - x_star)/abs(xk - x_star));
        end
    end
    
