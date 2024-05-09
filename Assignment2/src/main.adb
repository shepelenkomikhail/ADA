with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Float_Random;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;
with float_rand_package; use float_rand_package;

procedure Main is
--------------------------------------------------------------------------------
   protected type PrinterType is
      procedure Print(stringToPrint: in String);
   end PrinterType;

   protected body PrinterType is
      procedure Print(stringToPrint: in String) is
      begin
         Put_Line(stringToPrint);
      end Print;
   end PrinterType;
--------------------------------------------------------------------------------
   type StockType is (TSLA, NFLX, APPL);
   type PriceChart is array(StockType) of Float;
   type FloatArray is array(StockType) of Float;

   MyPrinter : PrinterType;
   stringToPrint : Unbounded_String;
   prices : FloatArray;
   package Float_IO is new Ada.Text_IO.Float_IO(Float);
--------------------------------------------------------------------------------
   protected Market is
      procedure InitPrices(prices: FloatArray);
      procedure Report;
      entry PlaceOrder(stock : StockType; mode : Integer);
   private
      chart : PriceChart;
      start : Time := Clock;
   end Market;

   protected body Market is
      procedure InitPrices(prices: FloatArray) is
      begin
        for I in chart'Range loop
           chart(I) := prices(I);
        end loop;
      end InitPrices;

      entry PlaceOrder(stock : StockType; mode : Integer)
        when To_Duration(Clock - start) < Duration(3.0) or
        (To_Duration(Clock - start) >= Duration(4.0) and
         To_Duration(Clock - start) - Duration(4.0) *
         Integer(Float(To_Duration(Clock - start)) / 4.0) < Duration(3.0))
      is
      begin
         MyPrinter.Print("Order is processing..");
         for I in chart'Range loop
            if stock = I then
               chart(I) := chart(I) + Float(mode) * 0.01;
               MyPrinter.Print("Order is done!");
            end if;
         end loop;
      end PlaceOrder;


      procedure Report is
         begin
         for I in chart'Range loop
            Put("# " & StockType'Image(I) & " : ");
            Float_IO.Put(Item => chart(I), Fore => 1, Aft => 2, Exp => 0);
            New_Line;
         end loop;
      end Report;
   end Market;
--------------------------------------------------------------------------------
   floatGenerator : Ada.Numerics.Float_Random.Generator;
   Min_Float : constant Float := 1.5;
   Max_Float : constant Float := 2.0;

   task type Person is
      entry Stop;
   end Person;


   task body Person is
      randomDelayFloat : Float;
      randomDelayDuration : Duration;

      subtype Stock_Index is Integer range 0 .. 2;
      package Random_Stock is new Ada.Numerics.Discrete_Random(Stock_Index);
      generator : Random_Stock.Generator;
      random_stock_var : StockType;

      randomMode : Float;
      mode : Integer;
   begin
      Ada.Numerics.Float_Random.Reset(floatGenerator);
      randomDelayFloat := Ada.Numerics.Float_Random.Random(floatGenerator) * (Max_Float - Min_Float) + Min_Float;
      randomDelayDuration := Duration(randomDelayFloat);

      delay randomDelayDuration;

      loop

         Random_Stock.Reset(generator);
         random_stock_var := StockType'Val(Random_Stock.Random(generator));

         randomMode := Ada.Numerics.Float_Random.Random(floatGenerator);
         if randomMode < 0.5 then mode := -1;
         else mode := 1;
         end if;

         select
            delay 0.5;
            Market.PlaceOrder(random_stock_var, mode);
            MyPrinter.Print("Order Placed!");
         or
            accept Stop;
            exit;
         end select;
      end loop;
   end Person;

   type People is array(1..5) of Person;
--------------------------------------------------------------------------------
   task Monitor;

   task body Monitor is
      myPeopleArray : People;
   begin
      prices := (TSLA => 183.28, NFLX => 550.64, APPL => 170.33);
      Market.InitPrices(prices);
      MyPrinter.Print("Initial Prices:");
      Market.Report;
      delay 0.5;

      for I in 1..8 loop
         delay 1.0;
         if I mod 4 = 0 then
            Market.Report;
         end if;
      end loop;

      for P of myPeopleArray loop
         P.Stop;
      end loop;

   end Monitor;
--------------------------------------------------------------------------------
begin
 null;
end Main;
