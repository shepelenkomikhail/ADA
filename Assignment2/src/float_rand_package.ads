with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;

package float_rand_package is 
   procedure Init;
   function GetRandom return Float;
private 
   G : Ada.Numerics.Float_Random.Generator;
end float_rand_package;
