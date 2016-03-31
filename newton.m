function q = newton(f, fp, x_0, ftol, maxit, x_star)
    x_k = x_0;
    for k = 0:maxit
        fx = f(x_k);
        if fx == 0
            break
        end
        fpx = fp(x_k);
        if fx < ftol
            break
        else 
            fprintf('%2d & %7f & %7f & %7f & %7f\\\\\n', k, x_k, fx, fpx, x_k-x_star);
            x_k = x_k - ((fx)/(fpx));
        end
    end
