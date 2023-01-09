function J = CostFunctionSimulink(X,U,e,data,u,betas)

    p = data.PredictionHorizon;
    U1 = U(1:p,data.MVIndex(1));

    a = 0.0001;
    Q = a*eye(p,p);

    J = (U1)'*Q*U1;

end