function [ u, v ] = horn( I1, I2, alpha, N )

    [Ix, Iy, It] = gradhorn (I1, I2);

    w = size(I1, 2);
    h = size(I1, 1);
    
    u = zeros(h,w);
    v = zeros(h,w);
    
    A = [1/12 1/6 1/12;  1/6 0 1/6; 1/12 1/6 1/12];
    
    alphaMat = ones(h,w) * alpha;
    
    for iter=1:N
        u_tilde = imfilter(u,A);
        v_tilde = imfilter(v,A);
      
        u = u_tilde - Ix .* ( Ix.*u_tilde + Iy.*v_tilde + It) ./ (alphaMat + Ix .* Ix + Iy .* Iy);
        v = v_tilde - Iy .* ( Ix.*u_tilde + Iy.*v_tilde + It) ./ (alphaMat + Ix .* Ix + Iy .* Iy);   
    end

end

