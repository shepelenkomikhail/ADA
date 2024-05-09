with persName_package; use persName_package;

generic
   type Job is (<>);
   type Experience is (<>);
   with function GetBaseSalary(J: Job) return Integer;
   with function GetMultiplier(E: Experience) return Integer;
package person_package is
   
   type Person is private;
   
   procedure InitPers(P: in out Person; Nm: persName; J: Job; E: Experience);
   function InitPers(Nm: persName; J: Job; E: Experience) return Person;
   procedure Save(P: in out Person; Months: Integer);
   function PersNameToString(Name: persName) return String;
   
   generic
      type Company is limited private;
      with function GetStockP(C: Company) return Integer;
      with procedure ProcessP(C: in out Company; Nm: persName; AmountStocks: Integer);
   procedure BuyStock(C: in out Company; P: in out Person; StocksToBuy: Integer);

   procedure PrintPers(P: in Person);

private
   
   
   type Person is record
      Nm : persName;
      Jb : Job;
      Exp : Experience;
      Savings : Integer := 0;
   end record;

end person_package;
