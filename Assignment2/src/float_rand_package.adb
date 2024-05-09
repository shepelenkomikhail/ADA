with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

package body float_rand_package is
    procedure Init is 
    begin 
        Ada.Numerics.Float_Random.Reset(G);
    end Init;

    function GetRandom return Float is
    begin
       return Ada.Numerics.Float_Random.Random(G);   
    end GetRandom;
end float_rand_package;
