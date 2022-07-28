----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jang Jae Seong
-- 
-- Create Date: 2022/05/18 14:12:33
-- Design Name: 
-- Module Name: TAIL_LIGHT - Behavioral
-- Project Name: Tail Light controller
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Declaratrion of "IEEE" Library and "IEEE.STD_LOGIC_1164" Package.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaraition entity and Port
-- CLK, RESET, BREAK, LEFT, RIGHT should be declared as std_logic since they are 1 bit.
-- LED should be declared as std_logic_vector since it is 8 bit.
-- Input : CLK, RESET, BREAK, LEFT, RIGHT / Output : LED
entity TAIL_LIGHT is
    port(
      CLK   : in STD_LOGIC;
      RESET  : in STD_LOGIC;
      BREAK  : in STD_LOGIC;
      LEFT  : in STD_LOGIC;
      RIGHT  : in STD_LOGIC;
      LED : out STD_LOGIC_VECTOR(7 downto 0)
    );
end TAIL_LIGHT;

-- Declaration architecture
architecture Behavioral of TAIL_LIGHT is
    -- Declaration 5 states for implementing Tail Light Controller using Moore machine
    -- Refer to Tail Light Controller State diagram from 2018312121_JangJaeSeong_HW3.docx
    type states is (s_reset, s_ready, s_break, s_left, s_right);
    
    -- Declaration of internal signal state and next_state which is used for expressing states.
    signal state, next_state : states;
begin
  -- state transition
  -- Below part is about current state decision which is sequential logic circuit part. (CLK is in the process sensitivity list)
  -- When Reset signal is '0'(active), state is changed to Reset state.(s_reset). Reset operation is asynchronous.
  -- When Reset signal is '1'(Deactive) and the CLK is rising edge, state is changed to next state.
  process(CLK, RESET)
    begin
      if(RESET = '0') then
        state <= s_reset;
      elsif(CLK = '1' and CLK'event) then
        state <= next_state;
      end if;
  end process;
  
  -- led out (outputs)
  -- Below part is about output decision which is combinational logic circuit part. (CLK is not in the process sensitivity list)
  -- Describe the output(value) of each states of moore state machine. (Refer to State diagram from 2018312121_JangJaeSeong_HW3.docx)
  process(state)
    begin
      case state is
        when s_reset => LED <= "00000000"; -- The value of s_reset is "00000000".
        when s_ready => LED <= "10000001"; -- The value of s_ready is "10000001".
        when s_break => LED <= "11111111"; -- The value of s_break is "11111111".
        when s_left => LED <= "11110000";  -- The value of s_left is "11110000".
        when s_right => LED <= "00001111"; -- The value of s_right is "00001111".
      end case;
  end process;
  
  -- next state
  -- Below part is about Next state decision which is combinational logic circuit part. (CLK is not in the process sensitivity list)
  -- Describe the next state of each states of moore state machine. (Refer to State diagram from 2018312121_JangJaeSeong_HW3.docx)
  process(state, BREAK, LEFT, RIGHT)
    begin
      case state is
        -- s_reset(RESET state) : next state will be s_ready when RESET deactivates and CLK is trigger edge.
        when s_reset =>
          next_state <= s_ready;
          
        -- s_reset(RESET state) : 
        -- when BREAK = '1'(BREAK activates), next state will be s_break(BREAK state) regardless of other input values except RESET.
        -- when LEFT = '1' and RIGHT = '0'(Only Left activates), next state will be s_left(LEFT state).
        -- when LEFT = '0' and RIGHT = '1'(Only Right activates), next state will be s_right(RIGHT state).
        -- In other cases, next state will be s_ready(Ready state). (Maintaining s_ready(READY state))
        when s_ready =>
          if(Break = '1') then next_state <= s_break;
          elsif(LEFT = '1' and RIGHT = '0') then next_state <= s_left;
          elsif(LEFT = '0' and RIGHT = '1') then next_state <= s_right;
          else next_state <= s_ready;
          end if;
        
        -- s_break(BREAK state) : 
        -- when BREAK = '1'(BREAK activates), next state will be s_break(BREAK state) regardless of other input values except RESET.(Maintaining s_break(BREAK state))
        -- when BREAK = '0'(BREAK deactivates), next state will be s_ready(READY state) regardless of other input values except RESET.
        when s_break =>
          if(Break = '1') then next_state <= s_break;
          else next_state <= s_ready;
          end if;
        
        -- s_left(LEFT state) : 
        -- when BREAK = '1'(BREAK activates), next state will be s_break(BREAK state) regardless of other input values except RESET.
        -- when LEFT = '1' and RIGHT = '0'(Only Left activates), next state will be s_left(LEFT state).(Maintaining s_left(LEFT state))
        -- In other cases, next state will be s_ready(Ready state).
        when s_left =>
          if(Break = '1') then next_state <= s_break;
          elsif(LEFT = '1' and RIGHT = '0') then next_state <= s_left;
          else next_state <= s_ready;
          end if;
          
        -- s_right(RIGHT state) : 
        -- when BREAK = '1'(BREAK activates), next state will be s_break(BREAK state) regardless of other input values except RESET.
        -- when LEFT = '0' and RIGHT = '1'(Only RIght activates), next state will be s_right(RIGHT state).(Maintaining s_right(RIGHT state))
        -- In other cases, next state will be s_ready(Ready state).
        when s_right =>
          if(Break = '1') then next_state <= s_break;
          elsif(LEFT = '0' and RIGHT = '1') then next_state <= s_right;
          else next_state <= s_ready;
          end if;
      end case;
  end process;
  
end Behavioral;
