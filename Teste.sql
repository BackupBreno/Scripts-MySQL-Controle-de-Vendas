insert into clientes values (0, "Breno", "Fortaleza");
insert into produtos values (0, "Produto Teste", 10.0, 15.0, 20, 5);

insert into vendas values (0, CURDATE(), CURDATE(), true, 0);
insert into itensVendidos values (0, 0, 2, 20.0);

delete from produtos where codigo = 0;