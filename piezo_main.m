close all; clear; clc;

% Create a nonlinear MPC controller with one state, one output, and one input control.
nx = 1;
nu = 1;
ny = 1;
nlobj = nlmpc(nx,ny,nu);
nlobj.States(1).Name = 'h';
nlobj.MV(1).Name     = 'udot';


% Specify the sample time and horizons of the controller.
Ts = 0.005;
p  = 10;

nlobj.Ts                       = Ts;
nlobj.PredictionHorizon        = p;
nlobj.ControlHorizon           = 2;
nlobj.Model.NumberOfParameters = 2;

%Weights of the objective function
nlobj.Weights.OutputVariables = 2.0;
nlobj.Weights.ManipulatedVariablesRate = 0.0;
    

%Specify the state function for the controller
nlobj.Model.StateFcn = "StateFunction";
nlobj.Model.IsContinuousTime = true;

% Specify the output function for the controller.
nlobj.Model.OutputFcn = "OutputFunction";

%Speficy optimization paremeters.
nlobj.Optimization.CustomCostFcn = "CostFunctionSimulink";
nlobj.Optimization.ReplaceStandardCost = false;
%nlobj.Optimization.CustomIneqConFcn = "IneqConFunction";
nlobj.Optimization.SolverOptions.MaxIter = 1000;
nlobj.Optimization.UseSuboptimalSolution = true;

% Piezo parameters
beta1 = 0.0032;
beta2 = 0.0035;
beta3 = -0.0010;
beta4 = -0.0003;
beta5 = -0.0002;
beta6 = 0.0004;

tau   = 0.001;
A     = -1/tau;
B     = 1/tau; 

%==========================================================================
% dp debe ser mayor que Abw en al menos 0.4 decimales
%==========================================================================
Abw   = 0.9; % 0.40648 , 0.9 , 0.4297
dp    = 1.6; % 1.0773  , 1.6 , 10

betas = [beta1;beta2;beta3;beta4;beta5;beta6;Abw;A;B;dp];
kappa = 500;
alpha = 80; %.... amplitud de la señal deseada 0.00008 = 80 micro meter;
freq = 2*pi/10; %= 0.1Hz

%Observer params
C = [1, 0];
theta = 100;

S_inv = [  2*theta ,        -(1/B)*theta^2 ;
          -(1/B)*theta^2 ,   (1/B^2)*theta^3  ];

Aobs = [0, -B;
        0,  0];

K = [10.0, 0.0; 
     0.0, 10.0];

% Validate the prediction model functions for nominal states x0 and nominal inputs u0. 
% x0 = -15;
% u0 = -5;
% validateFcns(nlobj, x0, u0,[],{0.0,betas});
%
mdl = 'PiezoMPC2_17';
open_system(mdl);
createParameterBus(nlobj,[mdl '/Nonlinear MPC Controller'],'myBusObject',{0.0,betas});
