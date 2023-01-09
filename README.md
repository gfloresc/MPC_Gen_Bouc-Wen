# MPC_Gen_Bouc-Wen
This repository includes the MATLAB Simulink simulation files for the paper "Model Predictive Control Based on the Generalized Bouc-Wen Model for PiezoelectricActuators in Robotic Hand WithOnly Position Measurements"

Requirments: matlab 2017b or higher

Steps to run the simulation:

1. Run the file: piezo_main.m
2. Run PiezoMPC2_17.slx simulation

Whenever you change the system parameters shown in the paper, please retune the control gains to get robustness against exogenous disturbances.

To cite this work please use:

<pre>
  <code>
@article{MPC2022_Bouc-Wen,
  author={Gerardo Flores and Micky Rakotondrabe},
  journal={IEEE Control Systems Letters},
  title={Model Predictive Control Based on the Generalized Bouc-Wen Model for Piezoelectric Actuators in Robotic Hand With Only Position Measurements}, 
  year={2022},
  volume={6},
  number={},
  pages={2186--2191},
  doi={10.1109/LCSYS.2021.3136456}
  }
  </code>
</pre>
