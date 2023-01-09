function hdot = StateFunction(h,udot,u,betas)
    
    beta1 = betas(1);
    beta2 = betas(2);
    beta3 = betas(3);
    beta4 = betas(4);
    beta5 = betas(5);
    beta6 = betas(6);
    Abw   = betas(7);

    
    Phi = beta1*sign( udot*h )  + beta2*sign( udot*u ) + ...
          beta3*sign( u*h ) + beta4*sign( udot ) + ...
          beta5*sign( h ) + beta6*sign( u );

    %============================ System model ============================
    %hdot
    hdot = udot*( Abw - abs(h)*Phi );


end