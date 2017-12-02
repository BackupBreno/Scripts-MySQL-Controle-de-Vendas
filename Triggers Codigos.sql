use VendasBD;

drop trigger att_cod_cliente
drop trigger att_cod_produto
drop trigger att_cod_venda

delimiter $$
create procedure incrementa_cod (in entidadeDesejada int(10))
begin

	update codReferencia set cod = cod + 1 where entidade = entidadeDesejada;

end $$
delimiter ;

delimiter $$
create trigger att_cod_cliente after insert on clientes
for each row
begin

	call incrementa_cod("clientes");

end $$
delimiter ;

delimiter $$
create trigger att_cod_produto after insert on produtos
for each row
begin

	call incrementa_cod("produtos");

end $$
delimiter ;

delimiter $$
create trigger att_cod_venda after insert on vendas
for each row
begin

	call incrementa_cod("vendas");

end $$
delimiter ;