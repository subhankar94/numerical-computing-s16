function p = bisection(f, a, b, maxit, xtol)
    for k = 0:maxit
        if abs(a-b) <= xtol
            break
        else
            fa = f(a);
            fb = f(b);
            fprintf('%2d & %7f & %7f & %7f & %7f & %7f\\\\\n', k, a, fa, b, fb, abs(a-b));
            m = (a+b)/2;
            fm = f(m);
            if fm == 0
                break
            elseif fa*fm < 0
                b = m;
            else
                a = m;
            end
        end
    end



            
