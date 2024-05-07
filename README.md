# Simulation

Simulation of 2.4 GHz inset fed patch antenna design using MATLAB Antenna, Symbolic Math, and Optimization Toolboxes.

![patchmicrostripinsetfed1](https://github.com/alexrice236/62300FinalProject/assets/34895971/32ba8510-aff1-4a64-b304-63c19d928194)

## Nominal Calculations

Calculated nominal values to optimize for maximum gain around:

1) Patch antenna width
2) Patch antenna length
3) Notch length

Along with some physical constraints:

1) Ground plane width
2) Ground plane length
3) Substrate thickness

## Antenna Setup

Used MATLAB 'design' feature to create a default 2.4 GHz patch antenna. Set constrained physical parameters.

![Ex67180691Example_01](https://github.com/alexrice236/62300FinalProject/assets/34895971/5aedc7e1-ee4a-4eb6-a746-5cbc1f00db03)

## Optimization

Used SADEA optimizer on width, length, and notch length paramters for 200 iterations to find maximum gain. 

## Metrics

Visualized gain, radiation pattern, impedance, and return loss using Antenna Toolbox functions.

![OptimizeENotchAntennaForGainWithGeometricConstraintsExample_04](https://github.com/alexrice236/62300FinalProject/assets/34895971/acc30615-5b37-4233-be1f-8b84b0817c57)

![CalculateAndPlotImpedanceOfAntennaExample_01](https://github.com/alexrice236/62300FinalProject/assets/34895971/b4ab33cf-6238-47ec-a8cd-4dd2a3a50baa)

![CalculateAndPlotReturnLossOfAntennaExample_01](https://github.com/alexrice236/62300FinalProject/assets/34895971/2fbbc5cd-d7fe-41a9-9d97-28ed4d699a42)

