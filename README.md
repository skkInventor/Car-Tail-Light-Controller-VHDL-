# Car-Tail-Light-Controller
[Digital System] 2022년 1학기 Digital System Assignemt3

# Digital System Assignment3
- This project is refered from 'Digital-System(ICE3034_41)' in SKKU University (pf. Jong Tae Kim) 
# Repository Owner  : skkInventor(장재성)  

# Enviroment
1. Vivado21.2(Using VHDL)

# Directory(FINAL_2)
1. If you need simulation on Vivado, checking the file "2018312121_JangJaeSeong_TL_tb.vhd"

# Description
- This module is for Car tail light controller
- All operations except the Reset operation operate synchronously according to the Rising Edge of the CLK.
- Reset is an activated active low where 0 is input, and operates asynchronously.
- Break, Left, and Right are Active High, which is activated when 1 is entered, and works synchronously.
- Multiple inputs may be input simultaneously at a time. (e.g., left and right can be entered at the same time)
- Description about each state
1. Reset
  
   • Reset operates regardless of CLK.
   
   • When Reset is enabled, it remains in the RESET state.
   
   • When Reset is deactivated, the state becomes Ready(s_ready) regardless of other input values.
   
2. Ready

   • When Break is input, it becomes a break state regardless of other input values except Reset.
   
   • If only the left is entered, the left state is entered, and if only the right is entered, the right state is entered.
   
   • In other cases, it remains in the Ready state.
   
3. Break

   • When Break is input, it remains in the break state regardless of other input values except Reset.
   
   • If Break is not input, it will be in Ready state regardless of other input values except Reset.
   
4. Left

   • If Break is entered, it goes to the Break state regardless of the input value except reset.
   
   • If only the Left is entered, it remains in the Left state.
   
   • In other cases, it goes to the Ready state.
   
  5. Right

   • When Break is input, it goes to the Break state regardless of the input value except Reset.
   
   • If only "Right" is entered, it remains in the Right State.
   
   • In other cases, it goes to the Ready state.
