----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/18 14:20:54
-- Design Name: 
-- Module Name: TL_tb - Behavioral
-- Project Name: 
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

-- Declaration entity and Port.
-- There is no I/O port in Test Bench Code.
entity TL_tb is
end TL_tb;

-- Declaration architecture
architecture Behavioral of TL_tb is
  -- Declaration of component of Tail Light Controller(TAIL_LIGHT)
  component TAIL_LIGHT is
    port(
    CLK     : in STD_LOGIC;
    RESET    : in STD_LOGIC;
    BREAK    : in STD_LOGIC;
    LEFT    : in STD_LOGIC;
    RIGHT    : in STD_LOGIC;
    LED : out STD_LOGIC_VECTOR(7 downto 0)
  );
  end component;
  
  -- Declaration of internal signal for setting input signal used for simulation.
  -- All signal except LED is declared as std_logic type.
  -- LED is declared as 8bit std_logic_vector type.
  signal CLK    : STD_LOGIC;
  signal RESET   : STD_LOGIC;
  signal BREAK   : STD_LOGIC;
  signal LEFT   : STD_LOGIC;
  signal RIGHT  : STD_LOGIC;
  signal LED : STD_LOGIC_VECTOR(7 downto 0);
  
begin
  -- Port out(Instantiation) Tail Light Controller Moore machine (TAIL_LIGHT) for simulation.
  -- Connect I/O port with internal signal which is declared in Test Bench. 
  t_I : TAIL_LIGHT port map (
      CLK => CLK,
      RESET => RESET,
      BREAK => BREAK,
      LEFT => LEFT,
      RIGHT => RIGHT,
      LED => LED);
      
  -- RESET signal test process.    
  rst_t : process
  begin
    wait for 10ns;
    RESET <= '0';  -- RESET signal will be '0' at 10ns.
    wait for 15ns;
    RESET <= '1';  -- RESET signal will be '1' at 25ns.
    wait for 48ns;
    RESET <= '0';  -- RESET signal will be '0' at 73ns.
    wait for 12ns;
    RESET <= '1';  -- RESET signal will be '1' at 85ns.
    wait;
  end process;
  
  -- CLK signal test process.
  -- The CLK signal period is 10ns.
  clk_t : process
  begin
    wait for 5ns;
    clk <= '0';
    wait for 5ns;
    clk <= '1';
  end process;
  
  -- BREAK, LEFT, RIGHT(input) signal test process.
  tl_t : process
    begin
      wait for 10ns;
      BREAK <= '0';  -- BREAK signal will be '0' at 10ns.
      LEFT <= '0';   -- LEFT signal will be '0' at 10ns.
      RIGHT <= '0';  -- RIGHT signal will be '0' at 10ns.
      wait for 15ns;
      BREAK <= '1';  -- BREAK signal will be '1' at 25ns.
      wait for 10ns;
      BREAK <= '0';  -- BREAK signal will be '0' at 35ns.
      LEFT <= '1';   -- LEFT signal will be '1' at 35ns.
      wait for 10ns;
      RIGHT <= '1';  -- RIGHT signal will be '1' at 45ns.
      wait for 10ns;
      LEFT <= '0';   -- LEFT signal will be '0' at 55ns
      RIGHT <= '0';  -- RIGHT signal will be '0' at 55ns.
      wait for 10ns;
      RIGHT <= '1';  -- RIGHT signal will be '1' at 65ns.
      wait for 40ns;
      BREAK <= '1';  -- BREAK signal will be '1' at 105ns.
      wait for 10ns;
      BREAK <= '0';  -- BREAK signal will be '0' at 115ns.
      wait for 30ns;
      RIGHT <= '0';  -- RIGHT signal will be '0' at 145ns.
      wait;
  end process;    
end Behavioral;
