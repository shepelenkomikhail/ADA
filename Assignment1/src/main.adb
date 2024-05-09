with Ada.Text_IO; use Ada.Text_IO;
with company_package; use company_package;
with persName_package; use persName_package;
with person_package;

procedure Main is
   type Job is (Doctor, Engineer, Businessman);
   type Experience is (Junior, Medior, Senior);

   function MyGetBaseSalary(J: Job) return Integer is
   begin
      case J is
         when Doctor => return 300;
         when Engineer => return 400;
         when Businessman => return 500;
         when others => return 0;
      end case;
   end MyGetBaseSalary;

   function MyGetMultiplier(E: Experience) return Integer is
   begin
      case E is
         when Junior => return 1;
         when Medior => return 2;
         when Senior => return 3;
         when others => return 0;
      end case;
   end MyGetMultiplier;

   package MyPerson is new person_package(Job => Job, Experience => Experience,
                                          GetBaseSalary => MyGetBaseSalary, GetMultiplier => MyGetMultiplier);
   use MyPerson;

   newPerson : Person;
   newCompany : Company;

   procedure MyBuyStock is new MyPerson.BuyStock(Company, GetStockPrice, ProcessPurchase);

begin
   InitCompany(newCompany, 1, 5, 200, 5);
   InitPers(newPerson, "John Doewe", Businessman, Medior);

   Put_Line("---------------------------");
   Put_Line("Initialized person: ");
   PrintPers(newPerson);

   Save(newPerson, 3);
   Put_Line("Person after saving: ");
   PrintPers(newPerson);

   Put_Line("Initialized company: ");
   PrintCmp(newCompany);

   MyBuyStock(newCompany, newPerson, 2);
   MyBuyStock(newCompany, newPerson, 2);
   MyBuyStock(newCompany, newPerson, 100);

   Put_Line("Company after buying 2 stocks: ");
   PrintCmp(newCompany);

   Put_Line("Final Person and Company: ");
   Put_Line("---------------------------");
   PrintPers(newPerson);
   Put_Line(" ");
   PrintCmp(newCompany);
end Main;
