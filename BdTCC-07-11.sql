create database bdTccJogos;
use bdTccJogos;

CREATE TABLE tbFuncionario (
    IdFunc INT PRIMARY KEY auto_increment,
    NomeFunc Varchar(150) not null,
    DataNasc DATETIME not null,
    CPF Varchar(20) not null,
    Senha Varchar(50) not null,
    Cargo Varchar(50) not null
);

CREATE TABLE tbProduto (
    CodProd INT PRIMARY KEY auto_increment,
    ProdNome Varchar(150) not null unique,
    ProdTipo Varchar(50) not null,
    ProdQtnEstoque INT not null,
    ProdDesc text not null,
    ProdAnoLanc Varchar(4) not null,
    ProdFaixaEtaria Varchar(50) not null,
    ProdValor decimal(15,2) not null,
    ImgCapa varchar(500) not null,
    fk_Funcionario_IdFunc INT
);
create table tbImagem (
	CodImg INT primary key auto_increment,
    LinkImg varchar(500) not null,
    CatImg varchar(50) not null,
    fk_tbProduto_CodProd INT
);

CREATE TABLE tbCupons (
    CodCupom INT PRIMARY KEY auto_increment,
    CupomTxt Varchar(15) not null unique,
    ValorCupom int not null,
    NumLimiteCompras INT not null
);

CREATE TABLE tbCarrinho (
    CodCarrinho INT PRIMARY KEY auto_increment,
    ValorTotal decimal(15,2) not null,
    Cupom Varchar(15) null,
    fk_Cupons_CodCupom INT,
    fk_Clinte_CPF Varchar(20)
);

CREATE TABLE tbItemCarrinho (
    QtnProd INT not null,
    ValorUnit decimal(15,2) not null,
    ValorTotal decimal(15,2) not null,
    fk_Produto_CodProd INT,
    fk_Carrinho_CodCarrinho INT,
    primary key(fk_Produto_CodProd,fk_Carrinho_CodCarrinho)
);

CREATE TABLE tbCliente (
    CPF Varchar(20) PRIMARY KEY not null,
    NomeCliente Varchar(150) not null,
    DataNasc DATETIME not null,
    Senha Varchar(50) not null,
    EmailCli Varchar(150) not null,
    telCli varchar(15) not null
);

CREATE TABLE tbVenda (
    CodVenda INT PRIMARY KEY auto_increment,
    FormaPag Varchar(50) not null,
    Parcela INT not null,
    Total decimal(15,2) not null, 
    fk_Carrinho_CodCarrinho INT,
    fk_Clinte_CPF Varchar(20)
);

CREATE TABLE tbComentarios (
    CodComentario Int PRIMARY KEY auto_increment,
    TxtComentario varchar(300) not null,
    Fk_CodProd INT,
    Fk_CpfCli Varchar(20)
);
 
ALTER TABLE tbProduto ADD CONSTRAINT FK_Produto_2
    FOREIGN KEY (fk_Funcionario_IdFunc)
    REFERENCES tbFuncionario (IdFunc)
    ON DELETE CASCADE;
    
 
ALTER TABLE tbCarrinho ADD CONSTRAINT FK_Carrinho_2
    FOREIGN KEY (fk_Cupons_CodCupom)
    REFERENCES tbCupons (CodCupom)
    ON DELETE CASCADE;
 
ALTER TABLE tbCarrinho ADD CONSTRAINT FK_Carrinho_3
    FOREIGN KEY (fk_Clinte_CPF)
    REFERENCES tbCliente (CPF)
    ON DELETE RESTRICT;
 
ALTER TABLE tbItemCarrinho ADD CONSTRAINT FK_ItemCarrinho_2
    FOREIGN KEY (fk_Produto_CodProd)
    REFERENCES tbProduto (CodProd)
    ON DELETE CASCADE;
 
ALTER TABLE tbItemCarrinho ADD CONSTRAINT FK_ItemCarrinho_3
    FOREIGN KEY (fk_Carrinho_CodCarrinho)
    REFERENCES tbCarrinho (CodCarrinho)
    ON DELETE CASCADE;
 
ALTER TABLE tbVenda ADD CONSTRAINT FK_Venda_2
    FOREIGN KEY (fk_Carrinho_CodCarrinho)
    REFERENCES tbCarrinho (CodCarrinho)
    ON DELETE CASCADE;
 
ALTER TABLE tbVenda ADD CONSTRAINT FK_Venda_3
    FOREIGN KEY (fk_Clinte_CPF)
    REFERENCES tbCliente (CPF)
    ON DELETE CASCADE;
 
ALTER TABLE tbComentarios ADD CONSTRAINT FK_Cometarios_2
    FOREIGN KEY (Fk_CpfCli)
    REFERENCES tbCliente (CPF);
 
ALTER TABLE tbComentarios ADD CONSTRAINT FK_Cometarios_3
    FOREIGN KEY (Fk_CodProd)
    REFERENCES tbProduto (CodProd);
    
ALTER TABLE tbImagem ADD CONSTRAINT fk_tbProduto_CodProd
    FOREIGN KEY (fk_tbProduto_CodProd)
    REFERENCES tbProduto (CodProd);
    
#####################################
#									#
#				Inserts				#
#			   Procedure			#
#####################################
##add cliente 
delimiter $$    
create procedure spInsertCliente(spCPF varchar(20), spNome varchar(150), spData datetime, spSenha varchar(50), spEmail varchar(150), sptelCli varchar(15))
begin
	insert into tbcliente values(spCPF, spNome, spData, spSenha, spEmail, spTelCli );
    
    insert into tbCarrinho (ValorTotal,Cupom,fk_Clinte_CPF) value(00.00,"",spCPF);
end $$

##Add funcionario
delimiter $$    
create procedure spInsertFuncionario(spNome varchar(150), spData datetime, spCPF varchar(50), spSenha varchar(50), spCargo varchar(50))
begin
	insert into tbfuncionario(NomeFunc, DataNasc, CPF, Senha, Cargo) values(spNome, spData, spCPF, spSenha, spCargo);
end $$

##AddProduto
delimiter $$    
create procedure spInsertProduto(spProdNome varchar(150), spTipoProd varchar(50), spQtnEstoqueProd int, spDescProd varchar(250), spAnoLancProd varchar(4), spFaixaEtaraia varchar(50),
spProdValor decimal(15,2), spImgCapa varchar(500),FkIdFunc int)
begin
	insert into tbProduto(ProdNome , ProdTipo , ProdQtnEstoque, ProdDesc , ProdAnoLanc , ProdFaixaEtaria , ProdValor, ImgCapa,fk_Funcionario_IdFunc) 
		values(spProdNome, spTipoProd, spQtnEstoqueProd, spDescProd, spAnoLancProd, spFaixaEtaraia, spProdValor,spImgCapa, FkIdFunc);
end $$

##AddCupom
delimiter $$    
create procedure spInsertCupom(spCupomTxt varchar(15), spValorCupom int, spNumLimiteCompras INT)
begin
	insert into tbCupons (CupomTxt , ValorCupom , NumLimiteCompras) 
		values(spCupomTxt, spValorCupom, spNumLimiteCompras);
end $$

##AddComent??rio
delimiter $$    
create procedure spInsertComentarios(spTxt varchar(300), fk_codprod int, fk_cpfcli varchar(20))
begin
	insert into tbcomentarios (TxtComentario , Fk_CodProd , Fk_CpfCli) 
		values(spTxt, fk_codprod, fk_cpfcli);
end $$

##AddImagem
delimiter $$    
create procedure spInsertImg(spLink varchar(500), spCatImg varchar(50), spfk_tbProduto_CodProd int)
begin
	insert into tbImagem (LinkImg, CatImg,fk_tbProduto_CodProd) 
		values(spLink, spCatImg, spfk_tbProduto_CodProd);
end $$


##AtualizaCarrinho
delimiter $$    
create procedure spInsertCarrinho(spCupom varchar(15), spfkCliCpf varchar(20))
begin
select CodCarrinho into @Codcarrinho from tbCarrinho where fk_Clinte_CPF=spfkCliCpf;
select sum(ValorTotal) into @Var_ValorTotal from tbItemCarrinho where fk_Carrinho_CodCarrinho =@Codcarrinho;
##adicinar funcao de se ja existir item soma qtn
if(spCupom="") then
	update tbCarrinho set ValorTotal= @Var_ValorTotal, Cupom= "",fk_Cupons_CodCupom=null where fk_Clinte_CPF=spfkCliCpf;
    
else 
update tbCarrinho set ValorTotal=(@Var_ValorTotal-((select ValorCupom from tbCupons where cupomTxt=spCupom)* @Var_ValorTotal/100)), 
        Cupom= spCupom, fk_Cupons_CodCupom= (select codCupom from tbCupons where cupomTxt=spCupom) where fk_Clinte_CPF=spfkCliCpf;
        end if;
end $$


##AddItemCarrinho
delimiter $$    
create procedure spInsertItemCarrinho(spQtnProd INT, spfk_Produto_CodProd INT, spfkCliCpf varchar(20))
begin
select CodCarrinho into @Codcarrinho from tbCarrinho where fk_Clinte_CPF= spfkCliCpf;
select ProdValor into @PrecoProd from tbProduto where CodProd=spfk_Produto_CodProd;

##se ja tiver um item apenas aciona mais uma qtn nele
if exists(select fk_Produto_CodProd from tbItemCarrinho where fk_Carrinho_CodCarrinho =@Codcarrinho AND fk_Produto_CodProd=spfk_Produto_CodProd)then
select QtnProd into @QtnProd from tbItemCarrinho where fk_Carrinho_CodCarrinho=@Codcarrinho AND fk_Produto_CodProd=spfk_Produto_CodProd ;
	update tbItemCarrinho set QtnProd=(@QtnProd+1), ValorTotal=((@QtnProd+1)*@PrecoProd) where fk_Carrinho_CodCarrinho=@Codcarrinho AND fk_Produto_CodProd=spfk_Produto_CodProd;
else 
	insert into tbItemCarrinho
 values(spQtnProd, @PrecoProd, (@PrecoProd*spQtnProd), spfk_Produto_CodProd, @Codcarrinho);
end if;

 call spInsertCarrinho("",  spfkCliCpf);
end $$

##venda feita
delimiter $$    
create procedure spInsertVenda(VFormaPag Varchar(50), VParcela INT, vfk_Clinte_CPF Varchar(20))
begin
select CodCarrinho into @Codcarrinho from tbCarrinho where fk_Clinte_CPF=vfk_Clinte_CPF;

	insert into tbVenda(FormaPag, Parcela, Total, fk_Carrinho_CodCarrinho, fk_Clinte_CPF)
 values(VFormaPag, VParcela ,(SELECT ValorTotal FROM tbCarrinho WHERE fk_Clinte_CPF =vfk_Clinte_CPF), @Codcarrinho, vfk_Clinte_CPF);
 
 delete from tbItemCarrinho where fk_Carrinho_CodCarrinho =  @Codcarrinho;
 
 select CodVenda, FormaPag, Parcela, Total, fk_Clinte_CPF, NomeCliente from tbVenda inner join tbcliente on tbVenda.fk_Clinte_CPF = tbcliente.CPF where fk_Clinte_CPF= vfk_Clinte_CPF order by CodVenda DESC limit 1;
end $$

#####################################
#									#
#				Select				#
#									#
#####################################

##cliente
delimiter $$    
create procedure spDadosCliente(spCPF varchar(20))
begin
	select CPF, NomeCliente, DataNasc, EmailCli, TelCli from tbcliente where CPF=spCPF;
end $$

##cliente
delimiter $$    
create procedure spLoginCliente(spEmail varchar(150),spSenha varchar(50))
begin
	select CPF from tbcliente where EmailCli=spEmail AND Senha=spSenha;
end $$

##dados func
delimiter $$    
create procedure spDadosFunc(SpIdFunc INT)
begin
	select IdFunc, NomeFunc, DataNasc, CPF, Cargo from tbFuncionario where IdFunc=SpIdFunc;
end $$

##itens do carrinho
delimiter $$    
create procedure spMostraItens(spCPF varchar(20))
begin
select CodCarrinho into @Codcarrinho from tbCarrinho where fk_Clinte_CPF=spCPF;
	select ValorUnit, QtnProd,ValorTotal,ProdNome, CodProd, ImgCapa from tbItemCarrinho 
			inner join tbProduto on tbItemCarrinho.fk_Produto_CodProd = tbProduto.CodProd where fk_Carrinho_CodCarrinho=@Codcarrinho;
end $$

##Total carrinho
delimiter $$    
create procedure spTotalCarrinho(spCPF varchar(20))
begin
	select ValorTotal, Cupom from tbCarrinho where fk_Clinte_CPF =spCPF;
end $$

##comentarios do produto
delimiter $$    
create procedure spMostraComentarios(spCodProd int)
begin
	select TxtComentario, NomeCliente from tbComentarios 
			inner join tbcliente on tbComentarios.Fk_CpfCli = tbcliente.CPF where Fk_CodProd=spCodProd;
end $$

##produto simples 
delimiter $$    
create procedure spMostraProdSimples(spCodProd int)
begin
	select CodProd, ProdNome, ProdTipo, ProdValor, ImgCapa from tbProduto where CodProd=spCodProd;
end $$

##produto por categoria 
delimiter $$    
create procedure spMostraProdCategoria(spProdTipo varchar(50))
begin
	select CodProd, ProdNome, ProdTipo, ProdValor,ImgCapa  from tbProduto where ProdTipo=spProdTipo;
end $$

##Pesquisa produto
delimiter $$    
create procedure spPesquisaProduto(spPesquia varchar(150))
begin
	select CodProd, ProdNome, ProdTipo, ProdValor,ImgCapa from tbProduto where ProdNome 
    LIKE CONCAT('%',spPesquia,'%') OR ProdTipo LIKE CONCAT('%',spPesquia,'%') OR ProdDesc LIKE CONCAT('%',spPesquia,'%');
end $$

##produto detalhado
delimiter $$    
create procedure spMostraProd(spCodProd int)
begin
select TxtComentario, NomeCliente from tbComentarios 
			inner join tbcliente on tbComentarios.Fk_CpfCli = tbcliente.CPF where Fk_CodProd=spCodProd;
	select CodProd, ProdNome, ProdTipo, ProdDesc, ProdAnoLanc, ProdFaixaEtaria, ProdValor, ImgCapa from tbProduto where CodProd=spCodProd;
    
	select LinkImg,CatImg from tbImagem where fk_tbProduto_CodProd= spCodProd;
end $$

##produto detalhado
delimiter $$    
create procedure spMostraProdDetalhado(spCodProd int)
begin
	select CodProd, ProdNome, ProdTipo, ProdDesc, ProdAnoLanc, ProdFaixaEtaria, ProdValor, ImgCapa from tbProduto where CodProd=spCodProd;
end $$

##mostra infos das venda
delimiter $$    
create procedure spReciboVenda(vfk_Clinte_CPF Varchar(20))
begin
 select CodVenda, FormaPag, Parcela, Total, fk_Clinte_CPF, NomeCliente from tbVenda inner join tbcliente on tbVenda.fk_Clinte_CPF = tbcliente.CPF where fk_Clinte_CPF= vfk_Clinte_CPF order by CodVenda DESC limit 1;
end $$


#####################################
#									#
#				Update				#
#									#
#####################################
delimiter $$
create procedure spUpdateFunc (spnome varchar(150), spdata datetime, spCPF varchar(150), spcargo varchar(50))
begin
	update tbFuncionario 
		set NomeFunc = spnome, DataNasc = spdata, CPF = spCPF, Cargo = spcargo
        where CPF = spCPF;
end $$

delimiter $$
create procedure spUpdateProd (spnome varchar(150), sptipo varchar(150), spquantidade int, spdesc varchar(750), spano Varchar(4), spfaixa varchar(50), spvalor decimal(15,2), spimagem varchar(250))
begin
	update tbProduto 
		set ProdNome = spnome, ProdTipo = sptipo, ProdQtnEstoque = spquantidade, ProdDesc = spdesc, ProdAnoLanc = spano, ProdFaixaEtaria = spfaixa, ProdValor = spvalor, ImgCapa = spimagem
        where ProdNome = spnome;
end $$

delimiter $$
create procedure spUpdateCli (spCPF varchar(150), spnome varchar(150), spdata datetime, spsenha varchar(50), spemail varchar(150), sptel varchar(50))
begin
	update tbCliente 
		set NomeCliente = spnome, DataNasc = spdata, Senha = spsenha, EmailCli = spemail, TelCli = sptel
        where CPF = spCPF;
end $$

delimiter $$
create procedure spUpdateCupom (sptxt varchar(15), spspvalor int, splimite int)
begin
	update tbCupons 
		set CupomTxt = sptxt, ValorCupom = spvalor, NumLimiteCompras = splimite
        where CupomTxt = sptxt;
end $$

#####################################
#									#
#				Delete				#
#									#
#####################################

delimiter $$
create procedure spDeleteFunc(spCPF varchar(20))
begin
	delete from tbFuncionario where CPF = spCPF;
end $$

delimiter $$
create procedure spDeleteProd(spnome varchar(150))
begin
	delete from tbProduto where ProdNome = spnome;
end $$

delimiter $$
create procedure spDeleteCli(spCPF varchar(20))
begin
	delete from tbCliente where CPF = spCPF;
end $$

delimiter $$
create procedure spDeleteCupom(spid int)
begin
	delete from tbCupons where CodCupom = spid;
end $$

delimiter $$
create procedure spRemoveItem(spCodProd int, spCPF varchar(20))
begin
select CodCarrinho into @Codcarrinho from tbCarrinho where fk_Clinte_CPF=spCPF;
	delete from tbItemCarrinho where fk_Produto_CodProd=spCodProd AND fk_Carrinho_CodCarrinho=@Codcarrinho;
end $$

#####################################
#									#
#				Inserts				#
#									#
#####################################

Call spInsertFuncionario("Joao", "1990/07/19", "132.457.576-45", "12345", "Caixa");
Call spInsertFuncionario("Seraphine", "2009/07/29", "554.795.508-61", "12345", "Caixa");
Call spInsertFuncionario("Fiddle da Silva", "2009/09/11", "967.335.408-19", "12345", "Caixa");
Call spInsertFuncionario("Luxanna", "2008/09/29", "133.246.488-23", "12345", "Caixa");
Call spInsertFuncionario("Jhin Jorge Jo??o Jheniffer da Silva Pereira", "1978/07/29", "950.871.548-08", "borabill", "Caixa");

call spInsertCliente("333.333.333-33", "Julia Maria", "1990-03-14", "123456", "Jularia@gmail.com","(41) 98674-9617");
call spInsertCliente("918.545.618-38", "Enzo Braga", "2009-04-14", "123456", "LordOfDarkness69@gmail.com","(11) 94002-8922");
call spInsertCliente("257.938.258-51", "Hugo Domingues", "1990-03-14", "123456", "semcriatividade123@gmail.com","(41) 98671-9617");
call spInsertCliente("674.364.258-46", "Vinicius Monteiro", "1990-03-14", "123456", "blublu@gmail.com","(41) 98672-9617");
call spInsertCliente("057.184.478-29", "Kaleb Duarte", "1990-03-14", "123456", "qmekaleb@gmail.com","(41) 98673-9617");
call spInsertCliente("561.414.118-94", "Angel Da Silva", "1990-03-14", "123456", "anjinho@gmail.com","(41) 97674-9617");
call spInsertCliente("561.454.118-94", "Catarina Rodrigues", "1990-03-14", "123456", "desempregada123@gmail.com","(41) 98874-9617");

call spInsertProduto("Gta 2","Tiro", 10, "GTA est?? de volta. E agora, o FBI e o ex??rcito est??o se envolvendo...Sete gangues violentas se envolvem em uma disputa de poder e cabe a voc?? construir sua reputa????o. Respeito se conquista, n??o ?? ganho.","2001", "+14", 20.32, "https://m.media-amazon.com/images/M/MV5BMjZjZmFkZDYtYzBlMi00MmNiLWFjYWItNjBhZTgzNzBiNGM1XkEyXkFqcGdeQXVyNDY4OTcyNDQ@._V1_FMjpg_UX1000_.jpg-", 1);
call spInsertProduto("Gta 5","Tiro", 40, "Quando um jovem traficante, um assaltante de bancos aposentado e um psicopata aterrorizante envolvem-se com alguns dos elementos mais assustadores e desequilibrados do submundo do crime, o governo dos EUA e a ind??stria do entretenimento, eles devem realizar golpes ousados para sobreviver nessa cidade implac??vel onde n??o podem confiar em ningu??m, nem mesmo um no outro.","2016", "+16", 90.32,"https://img.utdstc.com/screen/fad/8f5/fad8f5dd318d30ce1e8ba2548038bf2f8853b0edae95185627aa93b7d09920d8:200", 1);
call spInsertProduto("Barbie of Blair","Terror", 50, "A procura de sua filha, Peter adentra as misteriosas florestas de Blair, mas, algo inesperado ocorre, o levando a encontra as bonecas de sua filha em formas mo0nstruosas antes nunca imaginadas pelo pai preocupado","2001", "+12", 19.90, "https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg", 1);
call spInsertProduto("Five Nights at Freddy's: Security Breach","Terror", 89, "Quando os protocolos noturnos s??o ativados, os animatr??nicos perseguem todos os intrusos implacavelmente. Glamrock Chica, Roxanne Wolf, Montgomery Gator e Vanessa, a guarda noturna do Pizzaplex","2001", "+12", 35.30, "https://image.api.playstation.com/vulcan/img/rnd/202112/1602/A7JsgIOY4rhzk5JUXzduLtWq.png", 2);
call spInsertProduto("The Last of Us","RPG", 10, "Em uma civiliza????o devastada, em que infectados e sobreviventes veteranos est??o ?? solta, Joel, um protagonista abatido, ?? contratado para tirar uma garota de 14 anos, Ellie, de uma zona de quarentena militar.","2019", "+18", 49.90, "https://upload.wikimedia.org/wikipedia/en/thumb/4/46/Video_Game_Cover_-_The_Last_of_Us.jpg/220px-Video_Game_Cover_-_The_Last_of_Us.jpg", 3);
call spInsertProduto("STAR WARS: SQUADRONS","Tiro", 80, "Domine a arte de pilotagem aut??ntica de STAR WARS???: Squadrons. Sinta a adrenalina das lutas em primeira pessoa ao lado do seu esquadr??o e aperte o cinto em uma emocionante hist??ria de STAR WARS???.","2001", "+14", 39.80, "https://image.api.playstation.com/vulcan/img/rnd/202009/2410/aaIGMZl7LGnfbmQNOrHOrL6c.png?w=780&thumb=false", 4);
call spInsertProduto("Elden Ring","RPG", 10, "O NOVO RPG DE A????O E FANTASIA. Levante-se, Maculado, e seja guiado pela gra??a para portar o poder do Anel Pr??stino e se tornar um Lorde Pr??stino nas Terras Interm??dias.","2001", "+14", 249.90, "https://upload.wikimedia.org/wikipedia/pt/0/0d/Elden_Ring_capa.jpg", 1);
call spInsertProduto("GODDESS OF VICTORY: NIKKE","Tiro", 20,"NIKKE ?? um jogo de tiro RPG de fic????o cient??fica imersivo, onde voc?? recruta e comanda v??rias donzelas para formar um lindo esquadr??o de garotas de anime especializado em empunhar armas e outras armas de fic????o cient??fica exclusivas.","2022","+14", 15.00,"https://mmorpgbr.com.br/wp-content/uploads/2022/11/NIKKE-Goddess-of-Victory-Coming-to-Japan-in-2022.webp",2);
call spInsertProduto("Final Fantasy 7","RPG", 20,"O mundo est?? sob o dom??nio da Shinra, uma empresa que controla a energia mako, a for??a vital do planeta. Na cidade de Midgar, Cloud Strife, um antigo membro da unidade de elite SOLDIER da Shinra e agora mercen??rio, ajuda um grupo de resist??ncia.","2020","+12",249.90,"https://image.api.playstation.com/vulcan/img/cfn/11307-dNapclgq_VqNtQ98Xp_LxovvAdjd5AknZhd_-k2Cckq9FPtKDXAHk-ODCfvDKChH6hkEO0VLtj7Vk4E-Z8G707oe0N.png",1);
call spInsertProduto("God of War Ragnarok","RPG", 30,"Kratos e Atreus devem viajar pelos Nove Reinos em busca de respostas enquanto as for??as asgardianas se preparam para uma batalha profetizada que causar?? o fim do mundo.","2022","+18",300.00,"https://sm.ign.com/ign_br/game/g/god-of-war/god-of-war-ragnarok_z48t.jpg",1);
call spInsertProduto("Hollow Knight","Aventura",20,"Explore cavernas serpenteantes, cidades antigas e ermos mortais. Lute contra criaturas malignas, alie-se a insetos bizarros. Descubra a hist??ria antiga e solucione mist??rios enterrados no cora????o do reino.","2017","+10", 27.90,"https://images.squarespace-cdn.com/content/v1/606d159a953867291018f801/1619987722169-VV6ZASHHZNRBJW9X0PLK/Key_Art_02_layeredjpg.jpg?format=1500w",4)
call spInsertProduto("Genshim impact","Aventura", 15,"Sob o c??u desconhecido, voc??s s??o um par de g??meos viajantes, vindos de um outro mundo. Separados por deuses estranhos, voc?? foi selado e adormeceu. Ao acordar novamente, o cen??rio entre o c??u e a terra mudou completamente...","2020","+12", 54.50,"https://m.media-amazon.com/images/M/MV5BNzAyMzEwN2YtODVkZi00NzBlLTkwNDAtZjhhZjYxZjQ1OWJkXkEyXkFqcGdeQXVyMTAyNjg4NjE0._V1_FMjpg_UX1000_.jpg",2)
call spInsertProduto("Bendy and the Dark Revival","Terror", 20,"Bendy and the Dark Revival??? ?? um jogo de terror de sobreviv??ncia em primeira pessoa ambientado no est??dio de desenho animado mais assustador que j?? existiu. Acima de tudo, tema o Dem??nio da Tinta... e sobreviva.","2022","+14", 67.90," https://uploads.spiritfanfiction.com/historias/capitulos/201910/bendy-torture-and-the-ink-machine-17771323-271020192302.jpg",1)
call spInsertProduto("Vampiros Sobreviventes","Simula????o", 32,"Acabe com milhares de criaturas noturnas e sobreviva at?? o amanhecer! Onde suas escolhas podem fazer voc?? crescer rapidamente e aniquilar milhares de monstros que aparecem pelo caminho.","2022","+10", 25.00,"https://static-cdn.jtvnw.net/ttv-boxart/1833694612_IGDB-285x380.jpg", 3)
call spInsertProduto("Mineirinho Ultra Adventures","Plataforma", 18,"Um jogo de plataforma 3d muito legal, muitas aventuras extremas com nosso amigo Minerinho, agora temos a op????o Double Miner e a aventura fica muito mais legal.","2017","Livre", 5.00,"https://cdn2.steamgriddb.com/file/sgdb-cdn/grid/39260f85ab3a3963a3eb419b1f1fc6ea.png", 1)
call spInsertProduto("Gunner, HEAT, PC","Simula????o", 2,"GHPC ?? um jogo de simula????o sobre combate montado moderno, com aten????o especial ?? autenticidade e divers??o.","2022","+14", 60.00,"https://cdn.akamai.steamstatic.com/steam/apps/1705180/capsule_616x353.jpg?t=1663194680", 3)
call spInsertProduto("Dead Cells","RogueLike", 66,"Voc?? vai explorar um castelo extenso e em constante muta????o... considerando que consiga enfrentar seus guardi??es em combates 2D inspirados em Dark Souls. Sem checkpoints. Mate, morra, aprenda, repita.","2018","+14", 47.90,"https://static-cdn.jtvnw.net/ttv-boxart/495961_IGDB-272x380.jpg",2)
call spInsertProduto("Forza Horizon 2","Simula????o", 14,"Jogo de Carro revolucionario, com milhares de op????es de customiza????o disponiveis e gameplay involvente","2014","+10", 120.00,"https://sm.ign.com/ign_br/cover/f/forza-hori/forza-horizon-2_8ggj.jpg", 1)
call spInsertProduto("Minecraft","Simula????o", 999,"Explore mundos infinitos e construa desde simples casas a grandiosos castelos. Jogue no modo criativo com recursos ilimitados ou minere fundo no mundo no modo sobreviv??ncia, criando armas e armaduras para lutar contra criaturas perigosas.","2011","Livre", 25.00,"https://upload.wikimedia.org/wikipedia/pt/thumb/9/9c/Minecraft_capa.png/260px-Minecraft_capa.png", 4)

update tbproduto set ImgCapa="https://upload.wikimedia.org/wikipedia/pt/thumb/9/9c/Minecraft_capa.png/260px-Minecraft_capa.png" where CodProd=18
select * from tbproduto
call spInsertImg("https://i.ytimg.com/vi/RdGCN2mtgJQ/maxresdefault.jpg", "Imagem",2);
call spInsertImg("https://i.ytimg.com/vi/3FzriRcKwjg/maxresdefault.jpg", "Imagem",1);
call spInsertImg("https://img.utdstc.com/screen/fad/8f5/fad8f5dd318d30ce1e8ba2548038bf2f8853b0edae95185627aa93b7d09920d8:200", "Imagem",1);


call spInsertComentarios("Muito bom", 1, "333.333.333-33");
call spInsertComentarios("jogo epico nosssa", 1, "333.333.333-33");

call spInsertComentarios("Diverido", 2, "333.333.333-33");
call spInsertComentarios("Amei", 2, "918.545.618-38");

call spInsertComentarios("Muito Asustador", 3, "057.184.478-29");
call spInsertComentarios("jogo Muito bom XD", 3, "333.333.333-33");
call spInsertComentarios("Fofo :D", 3, "257.938.258-51");
call spInsertComentarios("jogo epico nosssa", 3, "561.454.118-94");

call spInsertComentarios("Historia boa", 4, "257.938.258-51");
call spInsertComentarios("jogo epico nosssa", 4, "918.545.618-38");
call spInsertComentarios("Difcil", 4, "057.184.478-29");

call spInsertComentarios("Amo Star Wars", 5, "561.454.118-94");

call spInsertComentarios("Muito bom", 6, "333.333.333-33");
call spInsertComentarios("jogo epico nosssa", 6, "057.184.478-29");

call spInsertComentarios("o JOgo te cativa", 7, "057.184.478-29");
call spInsertComentarios("Ruim", 7, "333.333.333-33");

call spInsertComentarios("Bora cratos", 9, "561.454.118-94");
call spInsertComentarios("Amei essa vers??o", 9, "918.545.618-38");
call spInsertComentarios("bom", 10, "333.333.333-33");
call spInsertComentarios("Pessimo", 10, "057.184.478-29");

call spInsertComentarios("Jogo de Otaku", 11, "333.333.333-33");
call spInsertComentarios("Gastei todo o meu dinheiro", 11, "918.545.618-38");
call spInsertComentarios("Visiante", 11, "561.414.118-94");

call spInsertComentarios("jogo epico nosssa", 12, "674.364.258-46");

call spInsertComentarios("Vampiros s??o demais", 13, "918.545.618-38");
call spInsertComentarios("Dificil", 13, "561.454.118-94");

call spInsertComentarios("Mine nunca decepciona", 14, "674.364.258-46");
call spInsertComentarios("jogo criativo", 14, "333.333.333-33");

call spInsertComentarios("Muito bom", 15, "561.414.118-94");
call spInsertComentarios("jogo epico nosssa", 15, "561.454.118-94");
call spInsertComentarios("Bem realista", 15, "674.364.258-46");
call spInsertComentarios("Horrivel", 15, "333.333.333-33");

call spInsertComentarios("N??o paro de jogar", 16, "674.364.258-46");
call spInsertComentarios("jogo epico", 16, "257.938.258-51");
call spInsertComentarios("N??o joguem", 16, "333.333.333-33");

call spInsertComentarios("Amo esses carros", 17, "257.938.258-51");



#####################################
#									#
#			Exermplos				#
#									#
#####################################

call spInsertCupom("Off10", 10, 2);
call spInsertItemCarrinho(1, 5, "333.333.333-33");
call spRemoveItem(5, "333.333.333-33");
call spInsertCarrinho("", "333.333.333-33");
call spInsertVenda("Pix",1,"333.333.333-33")
call spReciboVenda("333.333.333-33")

call spDadosCliente("333.333.333-33");
call spInsertItemCarrinho(1 , 7, "333.333.333-33");
call spMostraItens("333.333.333-33");
call spTotalCarrinho("333.333.333-33");


select * from tbcliente
call spDadosFunc(1);

call spMostraProd(8);
call spMostraProdSimples(2);
call spMostraProdCategoria("Tiro");
call spPesquisaProduto("am");

call spMostraComentarios(1);
call spMostraProdDetalhado(1);
