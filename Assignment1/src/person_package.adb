with Ada.Text_IO;
use Ada.Text_IO;

package body person_package is

   procedure InitPers(P: in out Person; Nm: persName; J: Job; E: Experience) is 
   begin
      P.Nm := Nm;
      P.Jb := J;
      P.Exp := E;
   end InitPers;
   
   function InitPers(Nm: persName; J: Job; E: Experience) return Person is 
      newP: Person;
   begin
      newP.Nm := Nm;
      newP.Jb := J;
      newP.Exp := E;
   return newP;
   end InitPers;
   
   procedure Save(P: in out Person; Months: Integer) is
    BaseSalary: Integer := GetBaseSalary(P.Jb);
    SalaryMultiplier: Integer := GetMultiplier(P.Exp);
    MonthlySalary: Integer := BaseSalary * SalaryMultiplier;
   begin
    Put_Line("Base Salary: " & Integer'Image(BaseSalary));
    Put_Line("Salary Multiplier: " & Integer'Image(SalaryMultiplier));
    Put_Line("Monthly Salary: " & Integer'Image(MonthlySalary));
    Put_Line("Months: " & Integer'Image(Months));
      
    P.Savings := P.Savings + (Months * MonthlySalary);
      
    Put_Line("New Savings: " & Integer'Image(P.Savings));
    Put_Line("---------------------------");
      
   end Save;

      
   procedure BuyStock(C: in out Company; P: in out Person; StocksToBuy: Integer) is 
      StockPrice: Integer := GetStockP(C); 
      TotalCost: Integer := StockPrice * StocksToBuy;
   begin
      if P.Savings >= TotalCost then
         ProcessP(C, P.Nm, StocksToBuy); 
         P.Savings := P.Savings - TotalCost; 
         
         Put_Line(String(P.Nm) & " bought " & Integer'Image(StocksToBuy) & " stocks");
         Put_Line("---------------------------");
         
      else
         Put_Line("Not enough Money");
         Put_Line("---------------------------");
         
      end if;
   end BuyStock;
   
   function PersNameToString(Name: persName) return String is
      Temp : String(1..Name'Length) := (others => ' ');
   begin
      for I in Name'Range loop
         Temp(I) := Name(I);
      end loop;
      return Temp;
   end PersNameToString;
   
   procedure PrintPers(P: in Person) is 
   begin
      Put_Line(PersNameToString(P.Nm));
      Put_Line(Job'Image(P.Jb));
      Put_Line(Experience'Image(P.Exp)); 
      Put_Line(P.Savings'Image);
      Put_Line("---------------------------");
      
   end PrintPers;
         
end person_package;
