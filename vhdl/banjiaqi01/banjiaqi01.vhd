library ieee;
use ieee.std_logic_1164.all;

entity banjiaqi01 is
	port(a,b:in std_logic;
			s,c:out std_logic);
end banjiaqi01;

architecture one of banjiaqi01 is
begin
	s<=(a xor b);
	c<=(a and b);
end one;

architecture tow of banjiaqi01 is
begin 
		s<='0' when a='0' and b='0' else 
			'1' when a='1' and b='0' else
			'1' when a='0' and b='1' else
			'0' ;
		c<='0' when a='0' and b='0' else 
			'0' when a='1' and b='0' else
			'0' when a='0' and b='1' else
			'1' ;
			
end tow;

configuration banjiaqi of banjiaqi01 is
	for one
	end for ;
	end banjiaqi;
	

