create database Pizzeria

create table Pizza(
CodicePizza int identity(1,1) constraint PK_Pizza primary key,
Nome nvarchar(30) not null,
Prezzo decimal(10,2) not null check(Prezzo>0)
);

create table Ingrediente(
CodiceIngrediente int identity(1,1) constraint PK_Ingrediente primary key,
Nome nvarchar(30) not null,
Costo decimal(10,2) not null check(Costo>0),
Scorte int not null check (Scorte >=0)
);

create table Pizza_Ingrediente(
CodicePizza int not null constraint FK_Pizza foreign key references Pizza(CodicePizza),
CodiceIngrediente int not null constraint FK_Ingrediente foreign key references Ingrediente(CodiceIngrediente)
constraint PK_Pizza_Ingrediente primary key(CodicePizza,CodiceIngrediente)
);

--procedure 1: Inserimento di una nuova pizza

create procedure InserisciPizza
@nome varchar(30),
@prezzo decimal(10,2)
as insert into Pizza values(@nome,@prezzo)

create procedure InserisciIngrediente
@nome varchar(30),
@costo decimal(10,2),
@scorte int
as
insert into Ingrediente values(@nome,@costo,@scorte)


--procedure 2 :assegnazione di un ingrediente ad una pizza
create procedure InserisciPizza_Ingrediente
@nomePizza varchar(30),
@nomeIngrediente varchar(30)
as
declare @CODICE_PIZZA int
declare @CODICE_INGREDIENTE int

select @CODICE_PIZZA = p.CodicePizza
from Pizza p
where p.Nome = @nomePizza

select @CODICE_INGREDIENTE = i.CodiceIngrediente
from Ingrediente i
where i.Nome =@nomeIngrediente

insert into Pizza_Ingrediente values(@CODICE_PIZZA,@CODICE_INGREDIENTE)

--Inserimento dati

execute InserisciPizza 'Margherita',5
execute InserisciPizza 'Bufala',7
execute InserisciPizza 'Diavola',6
execute InserisciPizza 'Quattro stagioni', 6.50
execute InserisciPizza 'Porcini',7
execute InserisciPizza 'Dioniso',8
execute InserisciPizza 'Ortolana',8
execute InserisciPizza 'Patate e salsiccia',6
execute InserisciPizza 'Pomodorini',6
execute InserisciPizza 'Quattro formaggi',7.50
execute InserisciPizza 'Caprese',7.50
execute InserisciPizza 'Zeus',7.50

execute InserisciIngrediente 'Pomodoro',10,50
execute InserisciIngrediente 'Mozzarella',20,40
execute InserisciIngrediente 'Mozzarella di bufala',30,70
execute InserisciIngrediente 'Spianata piccante',15,2
execute InserisciIngrediente 'Funghi',50,20
execute InserisciIngrediente 'Carciofo',15,20
execute InserisciIngrediente 'Cotto',40,20
execute InserisciIngrediente 'Oliva',30,15
execute InserisciIngrediente 'Funghi porcini',50,2
execute InserisciIngrediente 'Stracchino',20,4
execute InserisciIngrediente 'Speck',15,3
execute InserisciIngrediente 'Rucola',10,30
execute InserisciIngrediente 'Grana',30,40
execute InserisciIngrediente 'Verdure di stagione',30,15
execute InserisciIngrediente 'Patate',20,10
execute InserisciIngrediente 'Salsiccia',30,5
execute InserisciIngrediente 'Pomodorini',10,30
execute InserisciIngrediente 'Ricotta',30,15
execute InserisciIngrediente 'Provola',20,1
execute InserisciIngrediente 'Gorgonzola',25,4
execute InserisciIngrediente 'Pomodoro fresco',20,14
execute InserisciIngrediente 'Basilico',10,50
execute InserisciIngrediente 'Bresaola',35,0

execute InserisciPizza_Ingrediente 'Margherita','Pomodoro'
execute InserisciPizza_Ingrediente 'Margherita','Mozzarella'
execute InserisciPizza_Ingrediente 'Bufala','Pomodoro'
execute InserisciPizza_Ingrediente 'Bufala','Mozzarella di bufala'
execute InserisciPizza_Ingrediente 'Diavola','Pomodoro'
execute InserisciPizza_Ingrediente 'Diavola','Mozzarella'
execute InserisciPizza_Ingrediente 'Diavola','Spianata piccante'
execute InserisciPizza_Ingrediente 'Quattro stagioni','Pomodoro'
execute InserisciPizza_Ingrediente 'Quattro stagioni','Mozzarella'
execute InserisciPizza_Ingrediente 'Quattro stagioni','Funghi'
execute InserisciPizza_Ingrediente 'Quattro stagioni', 'Carciofo'
execute InserisciPizza_Ingrediente 'Quattro stagioni','Cotto'
execute InserisciPizza_Ingrediente 'Quattro stagioni','Oliva'
execute InserisciPizza_Ingrediente 'Porcini','Mozzarella'
execute InserisciPizza_Ingrediente 'Porcini', 'Funghi porcini'
execute InserisciPizza_Ingrediente 'Porcini','Pomodoro'
execute InserisciPizza_Ingrediente 'Dioniso','Pomodoro'
execute InserisciPizza_Ingrediente 'Dioniso','Mozzarella'
execute InserisciPizza_Ingrediente 'Dioniso','Stracchino'
execute InserisciPizza_Ingrediente 'Dioniso','Speck'
execute InserisciPizza_Ingrediente 'Dioniso','Rucola'
execute InserisciPizza_Ingrediente 'Dioniso','Grana'
execute InserisciPizza_Ingrediente 'Ortolana','Pomodoro'
execute InserisciPizza_Ingrediente 'Ortolana','Mozzarella'
execute InserisciPizza_Ingrediente 'Ortolana','Verdure di stagione'
execute InserisciPizza_Ingrediente 'Patate e salsiccia','Mozzarella'
execute InserisciPizza_Ingrediente 'Patate e salsiccia','Patate'
execute InserisciPizza_Ingrediente 'Patate e salsiccia','Salsiccia'
execute InserisciPizza_Ingrediente 'Pomodorini','Mozzarella'
execute InserisciPizza_Ingrediente 'Pomodorini','Pomodorini'
execute InserisciPizza_Ingrediente 'Pomodorini','Ricotta'
execute InserisciPizza_Ingrediente 'Quattro formaggi','Mozzarella'
execute InserisciPizza_Ingrediente 'Quattro formaggi','Provola'
execute InserisciPizza_Ingrediente 'Quattro formaggi','Gorgonzola'
execute InserisciPizza_Ingrediente 'Quattro formaggi','Grana'
execute InserisciPizza_Ingrediente 'Caprese','Mozzarella'
execute InserisciPizza_Ingrediente 'Caprese','Pomodoro fresco'
execute InserisciPizza_Ingrediente 'Caprese','Basilico'
execute InserisciPizza_Ingrediente 'Zeus','Mozzarella'
execute InserisciPizza_Ingrediente 'Zeus','Bresaola'
execute InserisciPizza_Ingrediente 'Zeus', 'Rucola'

--procedure 3 aggiornamento del prezzo di una pizza(paramentri nome pizza e nuovo prezzo

create procedure AggiornaPrezzo
@nomePizza varchar(30),
@nuovoPrezzo decimal(10,2)
as
declare @CODICE_PIZZA int

select @CODICE_PIZZA = p.CodicePizza
from Pizza p
where p.Nome = @nomePizza

update Pizza
set Prezzo=@nuovoPrezzo
where CodicePizza = @CODICE_PIZZA
go

execute AggiornaPrezzo 'Margherita',4.50

-- procedure 4: Eliminazione di un ingrediente da una pizza ( parametri: nome pizza nome ingrediente)
 
create procedure EliminaIngredienteDaPizza
@nomePizza varchar(30),
@nomeIngrediente varchar(30)
as
declare @CODICE_PIZZA int
declare @CODICE_INGREDIENTE int

select @CODICE_PIZZA = p.CodicePizza
from Pizza p
where p.Nome = @nomePizza

select @CODICE_INGREDIENTE = i.CodiceIngrediente
from Ingrediente i
where i.Nome =@nomeIngrediente

delete from Pizza_Ingrediente where CodiceIngrediente= @CODICE_INGREDIENTE and CodicePizza= @CODICE_PIZZA
go
 
execute EliminaIngredienteDaPizza 'Margherita','Mozzarella'

-- procedure 5 : Incremento del 10%  del prezzo delle pizze contenenti un ingrediente (paramentro = ingrediente)

create procedure AumentaPrezzo
@nomeIngrediente varchar(30)
as 
begin 
begin try

declare @CODICE_PIZZA int
declare @CODICE_INGREDIENTE int

select @CODICE_INGREDIENTE = i.CodiceIngrediente
from Ingrediente i
where i.Nome =@nomeIngrediente

select @CODICE_PIZZA= p_i.CodicePizza
from Pizza_Ingrediente p_i
where p_i.CodiceIngrediente = @CODICE_INGREDIENTE

update Pizza
set Prezzo = Prezzo*(1.1)
from Pizza join Pizza_Ingrediente on Pizza.CodicePizza=Pizza_Ingrediente.CodicePizza
where Pizza_Ingrediente.CodiceIngrediente = @CODICE_INGREDIENTE

end try
begin catch
	select ERROR_LINE() as [Riga], ERROR_MESSAGE()
	end catch
end

execute AumentaPrezzo 'Pomodoro'

select * from Pizza

--query
--1 Estrarre tutte le pizze con prezzo superiore a 6 euro.

select p.Nome, p.Prezzo
from Pizza p
where p.Prezzo>6

--2 Estrarre la pizza/le pizze più costosa/e

select p.Nome, p.Prezzo
from Pizza p
where p.Prezzo = ( select max(p.Prezzo)
                   from Pizza p)

--3 Estrarre le pizze «bianche»
select p.Nome
from Pizza p 
where p.Nome not in (select p.Nome
                     from Pizza p join Pizza_Ingrediente p_i on p.CodicePizza=p_i.CodicePizza
                                  join Ingrediente i on i.CodiceIngrediente=p_i.CodiceIngrediente
                     where i.Nome='Pomodoro')

--4 Estrarre le pizze che contengono funghi (di qualsiasi tipo)

select p.Nome
from Pizza p join Pizza_Ingrediente p_i on p.CodicePizza=p_i.CodicePizza
             join Ingrediente i on i.CodiceIngrediente=p_i.CodiceIngrediente
where i.Nome like 'Funghi%'

--Funzioni
--1 Tabella listino pizze (nome, prezzo) (parametri: nessuno)create function ListinoPrezziGenerico()returns tableas return select p.Nome, p.Prezzofrom Pizza p select * from ListinoPrezziGenerico()--2 Tabella listino pizze (nome, prezzo) contenenti un ingrediente (parametri: nome ingrediente)
create function ListinoPrezziConIngrediente(@nomeIngrediente varchar(30))returns tableasreturnselect p.Nome, p.Prezzofrom Pizza p join Pizza_Ingrediente p_i on p.CodicePizza = p_i.CodicePizzawhere p_i.CodiceIngrediente = (select i.CodiceIngrediente
from Ingrediente i
where i.Nome =@nomeIngrediente)select* from ListinoPrezziConIngrediente('Bresaola')--3 Tabella listino pizze (nome, prezzo) che non contengono un certo ingrediente(parametri: nome ingrediente)create function ListinoPrezziPizzeSenzaIngrediente(@nomeIngrediente varchar(30))returns tableasreturnselect p.Nome, p.Prezzofrom Pizza p where p.Nome not in (select p.Nome
                     from Pizza p join Pizza_Ingrediente p_i on p.CodicePizza=p_i.CodicePizza
                     where p_i.CodiceIngrediente = (select i.CodiceIngrediente
                                                  from Ingrediente i
                                                  where i.Nome =@nomeIngrediente))select * from ListinoPrezziPizzeSenzaIngrediente('Pomodoro')--4  Calcolo numero pizze contenenti un ingrediente (parametri: nome ingrediente)
create function CalcolaNumeroPizzeConIngrediente(@nomeIngrediente varchar(30))returns intas begindeclare @numeroPizze intselect @numeroPizze = count(*)from Pizza p join Pizza_Ingrediente p_i on p.CodicePizza=p_i.CodicePizza
where p_i.CodiceIngrediente = (select i.CodiceIngrediente
                               from Ingrediente i
                               where i.Nome =@nomeIngrediente)return @numeroPizzeendselect dbo.CalcolaNumeroPizzeConIngrediente ('Pomodoro') as[Numero pizze con questo ingrediente]--5 Calcolo numero pizze che non contengono un ingrediente (parametri: codice ingrediente)create function CalcolaNumeroPizzeSenzaIngrediente(@codiceIngrediente int)returns intas begindeclare @numeroPizze intselect @numeroPizze = count(*)from Pizza p where p.Nome not in (select p.Nome                     from Pizza p join Pizza_Ingrediente p_i on p_i.CodicePizza=p.CodicePizza					 where p_i.CodiceIngrediente = @codiceIngrediente)return @numeroPizzeendselect dbo.CalcolaNumeroPizzeSenzaIngrediente(2) as [Numero pizze senza questo ingrediente]--6 Calcolo numero ingredienti contenuti in una pizza (parametri: nome pizza)create function CalcolaNumeroIngrediente(@nomePizza varchar(30))returns intas begindeclare @numeroPizze intselect @numeroPizze = count(i.CodiceIngrediente)from Pizza p join Pizza_Ingrediente p_i on p_i.CodicePizza=p.CodicePizza             join Ingrediente i on i.CodiceIngrediente=p_i.CodiceIngredientewhere p.Nome= @nomePizzagroup by p.Nomereturn @numeroPizzeendselect dbo.CalcolaNumeroIngrediente('Margherita') as [Numero ingredienti]--Esercizio vistacreate view Menu as(select p.Nome as [Nome pizza] ,p.Prezzofrom Pizza p)select * from Menu--Esercizio vista opzionale: : la vista deve restituire una tabella con prima colonna
--contenente il nome della pizza, seconda colonna il prezzo e terza
--colonna la lista unica di tutti gli ingredienti separati da virgolacreate view MenuConIngredienti as(select p.Nome as [Pizza],p.Prezzo, STRING_AGG (i.Nome, ',') AS [Ingredienti]from Pizza p join Pizza_Ingrediente p_i on p_i.CodicePizza=p.CodicePizzajoin Ingrediente i on i.CodiceIngrediente=p_i.CodiceIngredientegroup by p.Nome, p.Prezzo)select * from MenuConIngredienti