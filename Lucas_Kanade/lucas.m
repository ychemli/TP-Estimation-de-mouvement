function [ u, v ] = lucas( I1, I2, n )

    [Ix, Iy, It] = gradhorn (I1, I2);

    w = size(I1, 2);
    h = size(I1, 1);
    
    u = zeros(h,w);
    v = zeros(h,w);
    
    for i= 1+n/2 : h-n/2
        for j= 1+n/2 : w-n/2
            r1 = i - n/2; % lower row index of window
            r2 = i + n/2; % upper row index of window
            c1 = j - n/2; % lower column index of window
            c2 = j + n/2; % upper column index of window
            
            win = I1( (r1 : r2) , (c1 : c2) );
            
            B = - It( (r1 : r2) , (c1 : c2) );
            B = B(:);
            
            Ax = Ix( (r1 : r2) , (c1 : c2) );
            Ax = Ax(:);
            Ay = Iy( (r1 : r2) , (c1 : c2) );
            Ay = Ay(:);
            A = [Ax  Ay];

            R = pinv( A'*A)* A'*B;
            
            u(i,j) = R(1);
            v(i,j) = R(2);            
        end
    end

end

