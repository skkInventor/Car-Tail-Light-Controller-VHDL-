SKKU_TermProject
This project is licensed under the terms of the GPL license.
Repository Owner : sg05060(박상현)
Collaborator
gju06051(최보열)
skklnventor(장재성)
nakyung0305(홍나경)
Version
First version : SKKU_TermProject/RTL - 2022/05/24
Second version : SKKU_TermProject/FINAL - 2022/05/26 (Verification finished)
Recent version : SKKU-TermProject/FINAL_2 - 2022/06/03 (Verification finished)
Enviroment
Github/Git(Collaboration, https://github.com/sg05060/SKKU_TermProject)
Vivado21.2(Simulation, Synthesis, FPGA porting, https://www.xilinx.com/products/design-tools/vivado.html)
Diagrams.net(Block diagram, https://app.diagrams.net/)
Vscode(Verilog code editor, https://code.visualstudio.com/)
Directory(FINAL_2)
If you need simulation on Vivado, checking directory :SKKU_TERMPROJECT/FINAL_2/SIM/
If you want to check some block diagram, checking directory : SKKU_TERMPROJECT/FINAL_2/DOC/
If you need to check some discussion, checking Github open/closed issue
If you need to check control signal from each data_loader of computation mode, check report & doc file, if you need detail, check decoder module
Description
This module is for accelerated convolution operation in DNN model
Module divided by four part
Memory & Memory Interface
Controller
Computation
Serial mode
Systolic mode
Custom mode
Display
Each computation mode is semi controlled by each 'Data-Loader'
Data-Loader is module that generate control signal sync with scalable counter
All module except 'controller', designed by gatelevel, structural modeling
We finished activation with Vivado Simulator and FPGA porting
Display module is based on basys3 FPGA board 7segment display from 'FPGA4students' site
All other basic module(SPRAM, Basic_gate, Flipflop, etc.) refered from 'Logic-Design-Laboratory(ICE2005)' in SKKU University (pf. Yunho Oh)
Increment
PE module rebuilding(we use serial, systolic type series module, but PE just need one multiplier and one accumulator for activation)
Custom module address control signal rebuilding(weight and feature get from series, if using two counter each domain feature and weight, we can delete much signal)
Parameterizing(There are many state in moore machine, we can parameterize it for resource saving)
Adder, multiplier modify(We use basic adder-ripple, basic multiplier-adder tree, we can increament these with many algorithm)
We need to check LUT/flipflop checking for resource efficeint
We can replace memory which designed by verilog HDL coding, using BRAM in FPGA device
