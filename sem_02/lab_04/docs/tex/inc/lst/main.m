function lab04()
    clc();
    clf();

    [debugFlg, delayS] = deal(1, 0.5);
    [a, b] = deal(0, 1);
    [eps, h] = deal(1e-2, 1e-3);

    fplot(@f, [a, b]);
    hold on;

    % newton_method(a, b, eps, h, debugFlg, delayS);

    modified_newton_method(a, b, eps, h, debugFlg, delayS);

    if debugFlg
        [x, fval] = fminbnd(@f, a, b);
        fprintf('fminbnd: x=%.10f, f(x)=%.10f\n', x, fval);
    end

    legend("off");
end

function modified_newton_method(a, b, h, eps, debugFlg, delayS)
    x = (a + b) / 2;

    [f_inc, f_x, f_dec] = deal(f(x + h), f(x), f(x - h));
    [f1, f2] = deal((f_inc - f_dec) / (2 * h), (f_inc - 2 * f_x + f_dec) / (h^2));

    i = 1;
    if debugFlg
        print_iter(i, x, f_x, f1, delayS);
    end

    while abs(f1) >= eps
        i = i + 1;

        [f_inc, f_x, f_dec] = deal(f(x + h), f(x), f(x - h));

        f1 = (f_inc - f_dec) / (2 * h);

        if debugFlg
            print_iter(i, x, f_x, f1, delayS);
        end

        x = x - f1 / f2;
    end;

    if debugFlg
        fprintf('RESULT: %2d iterations: x=%.10f, f(x)=%.10f\n', i, x, f_x);
        scatter(x, f_x, 'r', 'filled');
    end
end

function newton_method(a, b, h, eps, debugFlg, delayS)
    x = (a + b) / 2;

    i = 0;

    do
        i = i + 1;

        [f_inc, f_x, f_dec] = deal(f(x + h), f(x), f(x - h));

        [f1, f2] = deal((f_inc - f_dec) / (2 * h), (f_inc - 2 * f_x + f_dec) / (h^2));

        if debugFlg
            print_iter(i, x, f_x, f1, delayS);
        end

        x_prev = x;
        x = x_prev - f1 / f2;
    until abs(x - x_prev) < eps;

    if debugFlg
        fprintf('RESULT: %2d iterations: x=%.10f, f(x)=%.10f\n', i, x, f_x);
        scatter(x, f_x, 'r', 'filled');
    end
end

function print_iter(i, x, f_x, f1, delayS)
    fprintf("№ %2d:\t x = %.10f, f(x) = %.10f, f\'(x) = %.10f \n", i, x, f_x, f1);
    plot(x, f_x, 'xk');
    hold on;
    pause(delayS);
end

function y = f(x)
    k = power(5,1/3);

    y = sinh((3 * power(x,4) - x + sqrt(17) - 3) / 2) + sin((k * power(x, 3) - k * x + 1 - 2 * k) ./ (-power(x,3) + x + 2));
end
