with Ada.Text_IO, Ada.Characters.Latin_1; use Ada.Text_IO, Ada.Characters.Latin_1;
with person_package;
package body company_package is

   procedure InitCompany(C: out Company; ID: Integer; Max_Owner: Integer; Stock_Price: Integer; Max_Stock: Integer) is
   begin
      C.ID := ID;
      C.max_owner := Max_Owner;
      C.stock_price := Stock_Price;
      C.max_stock := Max_Stock;
   end InitCompany;

   function GetStockPrice(C: Company) return Integer is
   begin
      return C.stock_price;
   end GetStockPrice;

   procedure ProcessPurchase(C: in out Company; Nm: persName; AmountStocks: Integer) is
   TotalCost: Integer := AmountStocks * C.stock_price;
   begin

      declare
      AlreadyOwner: Boolean := False;
   begin
      for I in 1 .. C.current_owner_count loop
         if C.owners(I) = Nm then
            AlreadyOwner := True;
            exit;
         end if;
         end loop;

      if not AlreadyOwner and C.current_owner_count < C.max_owner then
         C.current_owner_count := C.current_owner_count + 1;
         C.owners(C.current_owner_count) := Nm;
         Put_Line("Purchaser added as an owner.");
      elsif AlreadyOwner then
         Put_Line("Purchaser is already an owner.");
      else
         Put_Line("Owner limit reached.");
      end if;
   end;

      C.fundings := C.fundings + TotalCost;
      Put_Line("Increased fundings by " & Integer'Image(TotalCost));
   end ProcessPurchase;


   procedure PrintPersName(Nm : persName) is
      S: String(1..persName'Length);
      Len: Natural := 0;
   begin
    for I in Nm'Range loop
        exit when Nm(I) = Ada.Characters.Latin_1.NUL;
        S(I) := Nm(I);
        Len := Len + 1;
    end loop;
      Ada.Text_IO.Put(S(1..Len));
      Ada.Text_IO.New_Line;
   end PrintPersName;

   procedure PrintCmp(C: Company) is
   begin
        Put_Line("Company's ID: " & C.ID'Image);
        Put_Line("Company's max owner: " & C.max_owner'Image);
        Put_Line("Company's stock price: " & C.stock_price'Image);
        Put_Line("Company's max stock: " & C.max_stock'Image);
        Put_Line("Company's fundings: " &C.fundings'Image);
      Put_Line("Owners: ");

      for I in 1..C.current_owner_count loop
         PrintPersName(C.owners(I));
      end loop;

      Put_Line("---------------------------");

   end PrintCmp;

end company_package;
