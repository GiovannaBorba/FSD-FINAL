--------------------------------------------------------------------------------
-- Temporizador decimal do cronometro de xadrez
-- Arthur Mazot, Giovanna Borba - 09/out/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
library work;
----------------------------------------------------------------------------------------------
entity temporizador is
port(
clock, reset, load, en : in std_logic;
init_time : in std_logic_vector(7 downto 0);
cont : out std_logic_vector(15 downto 0)
);
end temporizador;
----------------------------------------------------------------------------------------------
architecture a1 of temporizador is
signal segL, segH, minL, minH : std_logic_vector(3 downto 0);
signal en_count0, en_count1, en_count2, en_count3, en1, en2, en3, en4: std_logic;

----------------------------------------------------------------------------------------------
begin
en_count0 <= '1' when (segL = "0000" and segH = "0000" and minL = "0000" and minH = "0000") else
'0';

en_count1 <= '1' when (segL = "0000") else
'0';

en_count2 <= '1' when (segH = "0000") else
'0';

en_count3 <= '1' when (minL = "0000") else
'0';

en1 <= en and not en_count0;
en2 <= en1 and en_count1;
en3 <= en2 and en_count2;
en4 <= en3 and en_count3;
----------------------------------------------------------------------------------------------
sL : entity work.dec_counter port map (
first_value => x"0", limit => "1001",
------
clock => clock, reset => reset, load => load,
------
en => en1,
cont => segL
);


sH : entity work.dec_counter port map (
first_value => x"0", limit => "0101",
------
clock => clock, reset => reset, load => load,
------
en => en2,
cont => segH
);


mL : entity work.dec_counter port map (
first_value => init_time(3 downto 0), limit => "1001",
------
clock => clock, reset => reset, load => load,
------
en => en3,
cont => minL
);


mH : entity work.dec_counter port map (
first_value => init_time(7 downto 4), limit => "1001",
------
clock => clock, reset => reset, load => load,
------
en => en4,
cont => minH
);
----------------------------------------------------------------------------------------------
cont <= minH & minL & segH & segL;
----------------------------------------------------------------------------------------------
end a1;


