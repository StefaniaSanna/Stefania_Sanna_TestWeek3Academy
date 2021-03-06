USE [master]
GO
/****** Object:  Database [Pizzeria]    Script Date: 12/17/2021 3:08:25 PM ******/
CREATE DATABASE [Pizzeria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pizzeria', FILENAME = N'C:\Users\Stefania.sanna\Pizzeria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pizzeria_log', FILENAME = N'C:\Users\Stefania.sanna\Pizzeria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Pizzeria] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pizzeria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pizzeria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pizzeria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pizzeria] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pizzeria] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Pizzeria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pizzeria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pizzeria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pizzeria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pizzeria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pizzeria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pizzeria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pizzeria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pizzeria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Pizzeria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pizzeria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pizzeria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pizzeria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pizzeria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pizzeria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pizzeria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pizzeria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Pizzeria] SET  MULTI_USER 
GO
ALTER DATABASE [Pizzeria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pizzeria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pizzeria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pizzeria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pizzeria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pizzeria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Pizzeria] SET QUERY_STORE = OFF
GO
USE [Pizzeria]
GO
/****** Object:  UserDefinedFunction [dbo].[CalcolaNumeroIngrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CalcolaNumeroIngrediente](@nomePizza varchar(30))returns intas begindeclare @numeroPizze intselect @numeroPizze = count(i.CodiceIngrediente)from Pizza p join Pizza_Ingrediente p_i on p_i.CodicePizza=p.CodicePizza             join Ingrediente i on i.CodiceIngrediente=p_i.CodiceIngredientewhere p.Nome= @nomePizzagroup by p.Nomereturn @numeroPizzeend
GO
/****** Object:  UserDefinedFunction [dbo].[CalcolaNumeroPizzeConIngrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CalcolaNumeroPizzeConIngrediente](@nomeIngrediente varchar(30))returns intas begindeclare @numeroPizze intselect @numeroPizze = count(*)from Pizza p join Pizza_Ingrediente p_i on p.CodicePizza=p_i.CodicePizza
where p_i.CodiceIngrediente = (select i.CodiceIngrediente
                               from Ingrediente i
                               where i.Nome =@nomeIngrediente)return @numeroPizzeend
GO
/****** Object:  UserDefinedFunction [dbo].[CalcolaNumeroPizzeSenzaIngrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CalcolaNumeroPizzeSenzaIngrediente](@codiceIngrediente int)returns intas begindeclare @numeroPizze intselect @numeroPizze = count(*)from Pizza p where p.Nome not in (select p.Nome                     from Pizza p join Pizza_Ingrediente p_i on p_i.CodicePizza=p.CodicePizza					 where p_i.CodiceIngrediente = @codiceIngrediente)return @numeroPizzeend
GO
/****** Object:  Table [dbo].[Pizza]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza](
	[CodicePizza] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Prezzo] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Pizza] PRIMARY KEY CLUSTERED 
(
	[CodicePizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPrezziGenerico]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ListinoPrezziGenerico]()returns tableas return select p.Nome, p.Prezzofrom Pizza p
GO
/****** Object:  Table [dbo].[Ingrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingrediente](
	[CodiceIngrediente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Costo] [decimal](10, 2) NOT NULL,
	[Scorte] [int] NOT NULL,
 CONSTRAINT [PK_Ingrediente] PRIMARY KEY CLUSTERED 
(
	[CodiceIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pizza_Ingrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza_Ingrediente](
	[CodicePizza] [int] NOT NULL,
	[CodiceIngrediente] [int] NOT NULL,
 CONSTRAINT [PK_Pizza_Ingrediente] PRIMARY KEY CLUSTERED 
(
	[CodicePizza] ASC,
	[CodiceIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPrezziConIngrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ListinoPrezziConIngrediente](@nomeIngrediente varchar(30))returns tableasreturnselect p.Nome, p.Prezzofrom Pizza p join Pizza_Ingrediente p_i on p.CodicePizza = p_i.CodicePizzawhere p_i.CodiceIngrediente = (select  i.CodiceIngrediente
from Ingrediente i
where i.Nome =@nomeIngrediente)
GO
/****** Object:  UserDefinedFunction [dbo].[ListinoPrezziPizzeSenzaIngrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ListinoPrezziPizzeSenzaIngrediente](@nomeIngrediente varchar(30))returns tableasreturnselect p.Nome, p.Prezzofrom Pizza p where p.Nome not in (select p.Nome
                     from Pizza p join Pizza_Ingrediente p_i on p.CodicePizza=p_i.CodicePizza
                     where p_i.CodiceIngrediente = (select i.CodiceIngrediente
                                                  from Ingrediente i
                                                  where i.Nome =@nomeIngrediente))
GO
/****** Object:  View [dbo].[Menu]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Menu] as(select p.Nome as [Nome pizza] ,p.Prezzofrom Pizza p)
GO
/****** Object:  View [dbo].[MenuConIngredienti]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[MenuConIngredienti] as(select p.Nome as [Pizza],p.Prezzo, STRING_AGG (i.Nome, ',') AS [Ingredienti]from Pizza p join Pizza_Ingrediente p_i on p_i.CodicePizza=p.CodicePizzajoin Ingrediente i on i.CodiceIngrediente=p_i.CodiceIngredientegroup by p.Nome, p.Prezzo)
GO
SET IDENTITY_INSERT [dbo].[Ingrediente] ON 

INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (2, N'Pomodoro', CAST(10.00 AS Decimal(10, 2)), 50)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (3, N'Mozzarella', CAST(20.00 AS Decimal(10, 2)), 40)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (4, N'Mozzarella di bufala', CAST(30.00 AS Decimal(10, 2)), 70)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (5, N'Spianata piccante', CAST(15.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (6, N'Funghi', CAST(50.00 AS Decimal(10, 2)), 20)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (7, N'Carciofo', CAST(15.00 AS Decimal(10, 2)), 20)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (8, N'Cotto', CAST(40.00 AS Decimal(10, 2)), 20)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (9, N'Oliva', CAST(30.00 AS Decimal(10, 2)), 15)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (10, N'Funghi porcini', CAST(50.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (11, N'Stracchino', CAST(20.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (12, N'Speck', CAST(15.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (13, N'Rucola', CAST(10.00 AS Decimal(10, 2)), 30)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (14, N'Grana', CAST(30.00 AS Decimal(10, 2)), 40)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (15, N'Verdure di stagione', CAST(30.00 AS Decimal(10, 2)), 15)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (16, N'Patate', CAST(20.00 AS Decimal(10, 2)), 10)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (17, N'Salsiccia', CAST(30.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (18, N'Pomodorini', CAST(10.00 AS Decimal(10, 2)), 30)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (19, N'Ricotta', CAST(30.00 AS Decimal(10, 2)), 15)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (20, N'Provola', CAST(20.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (21, N'Gorgonzola', CAST(25.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (22, N'Pomodoro fresco', CAST(20.00 AS Decimal(10, 2)), 14)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (23, N'Basilico', CAST(10.00 AS Decimal(10, 2)), 50)
INSERT [dbo].[Ingrediente] ([CodiceIngrediente], [Nome], [Costo], [Scorte]) VALUES (24, N'Bresaola', CAST(35.00 AS Decimal(10, 2)), 0)
SET IDENTITY_INSERT [dbo].[Ingrediente] OFF
GO
SET IDENTITY_INSERT [dbo].[Pizza] ON 

INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (1, N'Margherita', CAST(6.60 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (2, N'Bufala', CAST(9.32 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (3, N'Diavola', CAST(7.99 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (4, N'Quattro stagioni', CAST(8.66 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (5, N'Porcini', CAST(9.32 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (6, N'Dioniso', CAST(12.89 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (7, N'Ortolana', CAST(11.72 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (8, N'Patate e salsiccia', CAST(6.00 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (9, N'Pomodorini', CAST(6.60 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (10, N'Quattro formaggi', CAST(8.25 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (11, N'Caprese', CAST(9.08 AS Decimal(10, 2)))
INSERT [dbo].[Pizza] ([CodicePizza], [Nome], [Prezzo]) VALUES (13, N'Zeus', CAST(9.08 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Pizza] OFF
GO
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (1, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (1, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (2, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (2, 4)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (3, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (3, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (3, 5)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (4, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (4, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (4, 6)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (4, 7)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (4, 8)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (4, 9)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (5, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (5, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (5, 10)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (6, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (6, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (6, 11)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (6, 12)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (6, 13)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (6, 14)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (7, 2)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (7, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (7, 15)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (8, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (8, 16)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (8, 17)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (9, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (9, 18)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (9, 19)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (10, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (10, 14)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (10, 20)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (10, 21)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (11, 22)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (11, 23)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (13, 3)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (13, 13)
INSERT [dbo].[Pizza_Ingrediente] ([CodicePizza], [CodiceIngrediente]) VALUES (13, 24)
GO
ALTER TABLE [dbo].[Pizza_Ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_Ingrediente] FOREIGN KEY([CodiceIngrediente])
REFERENCES [dbo].[Ingrediente] ([CodiceIngrediente])
GO
ALTER TABLE [dbo].[Pizza_Ingrediente] CHECK CONSTRAINT [FK_Ingrediente]
GO
ALTER TABLE [dbo].[Pizza_Ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_Pizza] FOREIGN KEY([CodicePizza])
REFERENCES [dbo].[Pizza] ([CodicePizza])
GO
ALTER TABLE [dbo].[Pizza_Ingrediente] CHECK CONSTRAINT [FK_Pizza]
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD CHECK  (([Costo]>(0)))
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD CHECK  (([Scorte]>=(0)))
GO
ALTER TABLE [dbo].[Pizza]  WITH CHECK ADD CHECK  (([Prezzo]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[AggiornaPrezzo]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AggiornaPrezzo]
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
GO
/****** Object:  StoredProcedure [dbo].[AumentaPrezzo]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AumentaPrezzo]
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
GO
/****** Object:  StoredProcedure [dbo].[EliminaIngredienteDaPizza]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[EliminaIngredienteDaPizza]
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
GO
/****** Object:  StoredProcedure [dbo].[InserisciIngrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InserisciIngrediente]
@nome varchar(30),
@costo decimal(10,2),
@scorte int
as
insert into Ingrediente values(@nome,@costo,@scorte)
GO
/****** Object:  StoredProcedure [dbo].[InserisciPizza]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InserisciPizza]
@nome varchar(30),
@prezzo decimal(10,2)
as insert into Pizza values(@nome,@prezzo)
GO
/****** Object:  StoredProcedure [dbo].[InserisciPizza_Ingrediente]    Script Date: 12/17/2021 3:08:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InserisciPizza_Ingrediente]
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
GO
USE [master]
GO
ALTER DATABASE [Pizzeria] SET  READ_WRITE 
GO
