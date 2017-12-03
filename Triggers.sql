use VendasBD;

drop trigger verifica_estoque
drop trigger att_date

delimiter $$
create procedure valida_estoque (in cod int(10), in qtdVendida int(10), out valido boolean, out newQtd int(10))
begin
    
    set newQtd = (select quantidadeEst from produtos where codigo = cod);
    
    if (newQtd - qtdVendida) < 0 then
		
        set valido = false;

	else 
    
		set valido = true;

	end if;

end $$
delimiter ;

delimiter $$
create trigger verifica_estoque before insert on itensVendidos
for each row
begin
    
    declare qtd int(10);
    
    declare valido boolean;
    
	call valida_estoque(new.codigoProduto, new.qtdVenda, valido, qtd);

    if not valido then
		
        signal sqlstate '45000' set message_text = 'Estoque insuficiente.';

	else 
    
		update produtos set quantidadeEst = (qtd - new.qtdVenda) where codigo = new.codigoProduto;

	end if;

end $$
delimiter ;

delimiter $$
create procedure valida_data (in dataVencimento date, in dataVenda date, out valido boolean)
begin
    
    if dataVencimento < dataVenda then
		
        set valido = false;

	else 
    
		set valido = true;

	end if;

end $$
delimiter ;

delimiter $$
create trigger att_date before insert on vendas
for each row
begin

declare valido boolean;

	set new.dataVenda = curdate();

	if new.isPrazo then
		
	    call valida_data(new.dataVencimento, new.dataVenda, valido);
        
        if not valido then
        
			signal sqlstate '45000' set message_text = 'Data de vencimento invalida.';
            
		end if;
    
    else
    
		set new.dataVencimento = curdate();
        
		set new.codigoCliente = -1;
        
    end if;

end $$
delimiter ;