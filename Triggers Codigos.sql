drop trigger att_cod_cliente

delimiter $$
create trigger att_cod_cliente after insert on clientes
for each row
begin

	update codReferencia set cod = cod + 1 where entidade = "clientes";

end $$
delimiter ;

drop trigger att_cod_produto

delimiter $$
create trigger att_cod_produto after insert on produtos
for each row
begin

	update codReferencia set cod = cod + 1 where entidade = "produtos";

end $$
delimiter ;

drop trigger att_cod_venda

delimiter $$
create trigger att_cod_venda after insert on vendas
for each row
begin

	update codReferencia set cod = cod + 1 where entidade = "vendas";

end $$
delimiter ;