function lab02()
    clc();
    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-2;

    fplot(@f, [a, b]);
    hold on;

    [xStar, fStar] = goldenRatio(a, b, eps, debugFlg, delayS);

    scatter(xStar, fStar, 'r', 'filled');

    legend("off");
end

function [xStar, fStar] = goldenRatio(a, b, eps, debugFlg, delayS)
    tau = (sqrt(5) - 1) / 2;
    l = b - a;

    x1 = b - tau * l;
    x2 = a + tau * l;
    f1 = f(x1);
    f2 = f(x2);

    i = 0;
    while 1
        i = i + 1;

        if debugFlg
            fprintf('№ %2d ai=%.10f bi=%.10f\n', i, a, b);
            line([a b], [f(a) f(b)], 'color', 'b');
            %plot(a, f(a), 'xm', b, f(b), 'xb');
            hold on;
            pause(delayS);
        end

        if l > 2 * eps
            if f1 <= f2
                b = x2;
                l = b - a;

                x2 = x1;
                f2 = f1;

                x1 = b - tau * l;
                f1 = f(x1);
            else
                a = x1;
                l = b - a;

                x1 = x2;
                f1 = f2;

                x2 = a + tau * l;
                f2 = f(x2);
            end
        else
            xStar = (a + b) / 2;
            fStar= f(xStar);
            break
        end
    end

    i = i + 1;
    if debugFlg
        fprintf('№ %2d ai=%.10f bi=%.10f\n', i, a, b);
        fprintf('RESULT: x*=%.10f f(x*)=%.10f\n', xStar, fStar);

        line([a b], [f(a) f(b)], 'color', 'r');
    end
end

function y = f(x)
    k = power(5,1/3);

    y = sinh((3 * power(x,4) - x + sqrt(17) - 3) / 2) + sin((k * power(x, 3) - k * x + 1 - 2 * k) ./ (-power(x,3) + x + 2));
end
