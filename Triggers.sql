use VendasBD;

drop trigger verifica_estoque
drop trigger att_date

delimiter $$
create trigger verifica_estoque before insert on itensVendidos
for each row
begin

	declare qtd int(10);
    
    set qtd = (select quantidadeEst from produtos where codigo = new.codigoProduto);
    
    if (qtd - new.qtdVenda) < 0 then
		
        signal sqlstate '45000' set message_text = 'Estoque insuficiente.';

	else 
    
		update produtos set quantidadeEst = (qtd - new.qtdVenda) where codigo = new.codigoProduto;

	end if;

end $$
delimiter ;

delimiter $$
create trigger att_date before insert on vendas
for each row
begin

	set new.dataVenda = curdate();

	if new.isPrazo then
		
        if new.dataVencimento < new.dataVenda then
			signal sqlstate '45000' set message_text = 'Data de vencimento invalida.';
		end if;
    
    else
    
		set new.dataVencimento = curdate();
        
		set new.codigoCliente = -1;
        
    end if;

end $$
delimiter ;