with persName_package; use persName_package;

package company_package is

   type Company is private;

   procedure ProcessPurchase(C: in out Company; Nm: persName; AmountStocks: Integer);
   function GetStockPrice(C: Company) return Integer;
   procedure InitCompany(C: out Company; ID: Integer; Max_Owner: Integer; Stock_Price: Integer; Max_Stock: Integer);
   procedure PrintCmp(C: Company);

private
   max : constant := 10;
   type Owners_Arr is array(1..max) of persName;

   type Company is record
      ID : Integer;
      max_owner : Integer := max;
      stock_price : Integer;
      max_stock : Integer;
      fundings : Integer := 0;
      owners : Owners_Arr;
      current_owner_count : Integer := 0;
   end record;

end company_package;
