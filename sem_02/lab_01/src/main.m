function lab01()
    clc();
    clf();

    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-2;

    fplot(@f, [a, b]);
    hold on;

    [xStar, fStar] = bitwiseSearch(a, b, eps, debugFlg, delayS);

    scatter(xStar, fStar, 'r', 'filled');

    legend("off");
end

function [x0, f0] = bitwiseSearch(a, b, eps, debugFlg, delayS)
    i = 0;
    delta = (b - a) / 4;
    x0 = a;
    f0 = f(x0);

    plot_x = [];
    plot_f = [];

    while 1
        i = i + 1;
        x1 = x0 + delta;
        f1 = f(x1);

        if debugFlg
            fprintf('№ %2d x*=%.10f f(x*)=%.10f\n', i, x1, f1);

            plot_x(end + 1) = x1;
            plot_f(end + 1) = f1;

            plot(plot_x, plot_f, 'xk');

            plot(x1, f1, 'xr');
            hold on;
            pause(delayS);
        end

        if f0 > f1
            x0 = x1;
            f0 = f1;

            if a < x0 && x0 < b
                continue
            else
                if abs(delta) <= eps
                    break;
                else
                    x0 = x1;
                    f0 = f1;
                    delta = -delta / 4;
                end
            end
        else
            if abs(delta) <= eps
                break;
            else
                x0 = x1;
                f0 = f1;
                delta = -delta / 4;
            end
        end
    end

    i = i + 1;
    if debugFlg
        fprintf('№ %2d x*=%.10f f(x*)=%.10f\n', i, x0, f0);
        fprintf('RESULT: x*=%.10f f(x*)=%.10f\n', x0, f0);
        plot(plot_x, plot_f, 'xk');
    end
end

function y = f(x)
    k = power(5,1/3);

    y = sinh((3 * power(x,4) - x + sqrt(17) - 3) / 2) + sin((k * power(x, 3) - k * x + 1 - 2 * k) ./ (-power(x,3) + x + 2));
end

