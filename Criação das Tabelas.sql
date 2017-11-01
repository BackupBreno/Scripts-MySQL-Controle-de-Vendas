drop schema VendasBD;

create schema VendasBD;

use VendasBD;


create table clientes (
codigo			int(10)			not null,
nome			varchar(45)		not null,
endereco		varchar(45)		not null,
primary key (codigo));


create table vendas (
numero			int(10)			not null,
dataVenda		date			not null,
dataVencimento	date			not null,
isPrazo			boolean			not null,
codigoCliente	int(10)			not null,
primary key (numero),
foreign key (codigoCliente) references clientes(codigo));


create table produtos (
codigo			int(10)			not null,
descricao		varchar(45)		not null,
valorCompra		decimal(10, 2)	not null,
valorVenda		decimal(10, 2)	not null,
quantidadeEst	int(10)			not null,
estMin			int(10)			not	null,
primary key (codigo));


create table itensVendidos (
numeroVenda		int(10)			not null,
codigoProduto	int(10)			not null,
qtdVenda		int(10)			not null,
precoPago		decimal(10, 2)	not null,
primary key (numeroVenda, codigoProduto),
foreign key (numeroVenda)	references vendas(numero),
foreign key (codigoProduto) references produtos(codigo));