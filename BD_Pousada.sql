create table cliente(
	cli_id int AUTO_INCREMENT NOT null PRIMARY KEY,
    cli_nome varchar(70) not null,
    cli_cpf varchar(14) not null UNIQUE,
    cli_rg varchar(12) not null UNIQUE,
    cli_senha varchar (32) not null,
    cli_email varchar(70) not null unique,
    cli_recuperarsenha varchar(100),
    cli_arquivar_em datetime
   
CREATE PROCEDURE addClientes(name varchar(70),cpfs varchar(14),rgs varchar(12),passwords varchar(32),emails varchar(70))
 insert into cliente(cli_nome, cli_cpf,cli_rg,cli_senha,cli_email) values (name ,cpfs ,rgs,passwords ,emails );

create table novidade(
	nov_id int not null AUTO_INCREMENT PRIMARY key,
    nov_nome varchar(70) not null,
    nov_email varchar(70) not null
)

create table telefones_cli(
	tel_int int PRIMARY key not null AUTO_INCREMENT,
    tel_tipo varchar(20),
    tel_varchar varchar(21) not null,
    tel_cli_id INT,
    FOREIGN KEY (tel_cli_id) REFERENCES cliente(cli_id)
)

create table cartoes_cli(
	cart_id int not null PRIMARY key AUTO_INCREMENT,
    cart_nometitular varchar(45) not null,
    cart_numero varchar(21),
    cart_validade varchar(7),
    cart_cvv varchar(3) UNIQUE,
    cart_tipo varchar(12),
    cart_cli_id int,
    FOREIGN key (cart_cli_id) REFERENCES cliente(cli_id)
)

	
	create table endereco_cli(
	end_cli int not null AUTO_INCREMENT PRIMARY KEY,
    end_cep varchar(9),
    end_cidade varchar(30),
    end_uf varchar(2),
    end_logradouro varchar(60),
    end_numero varchar(6),
    end_cli_id int,   
    FOREIGN KEY (end_cli_id) REFERENCES cliente(cli_id)
)

CREATE table cargos(
	cargo_id int not null AUTO_INCREMENT PRIMARY KEY,
    cargo_nome varchar(45) not null,
    cargo_descricao text,
    arquivar_em varchar(5)
    
)

CREATE table acoes(
	acoes_id int PRIMARY KEY not null AUTO_INCREMENT,
    acoes_nome varchar(45) not null,
    acoes_cargos_id int,
    FOREIGN KEY (acoes_cargos_id) REFERENCES cargos(cargo_id)
)

create table permissoes(
	permi_id int not null AUTO_INCREMENT PRIMARY KEY,
    permi_consulta bit(1),
    permi_del bit(1),
    permi_criar bit(1),
    permi_alterar bit(1),
    permi_acoes_id int,
    FOREIGN KEY  (permi_acoes_id) REFERENCES acoes(acoes_id)
    
)

create table funcionarios(
	func_id int not null AUTO_INCREMENT PRIMARY KEY,
    func_nome varchar(70) not null,
    func_datanasc date,
    func_cpf varchar(14) UNIQUE not null,
    func_rg varchar(12) UNIQUE not null,
    func_salario float(7,2),
    func_email varchar(70) UNIQUE,
    func_senha varchar(32),
    func_periodo varchar (32),
    func_admissao datetime,
    func_demissao datetime,
    func_cargos_id int,
    FOREIGN KEY (func_cargos_id) REFERENCES acoes(acoes_id)
    
)
create table enderecos_func(
    endfunc_id int not null PRIMARY key AUTO_INCREMENT,
    endfunc_logradouro varchar(70),
    endfunc_numero varchar(5),
    endfunc_cep varchar(9),
    endfunc_bairro varchar(30),
    endfunc_cidade varchar(40),
    endfunc_uf varchar(2),
    endfunc_func_id int,
	FOREIGN KEY (endfunc_func_id) REFERENCES funcionarios(func_id) 
	
)

create table telefone_func (
	telfunc_id int not null AUTO_INCREMENT PRIMARY KEY,
    telfunc_tipo varchar(20) not null,
    telfunc_tel varchar(21) not null,
    telfunc_func_id int,
    FOREIGN key (telfunc_func_id) REFERENCES funcionarios(func_id)
    
)
create table historico(
	hist_id int not null AUTO_INCREMENT PRIMARY KEY,
    hist_logs text not null,
    hist_datahora datetime,
    hist_func_id int,
    FOREIGN KEY (hist_func_id) REFERENCES funcionarios(func_id)
)


CREATE table statos(
	sta_id int AUTO_INCREMENT PRIMARY key,
    sta_status varchar(20) not null
)
create TABLE tipos(
tipo_id int AUTO_INCREMENT PRIMARY KEY,
    tipo_tipos varchar(45)
)
create table forma_pagamentos(
	pagamento_id int AUTO_INCREMENT PRIMARY KEY,
    pagamento_tipo varchar(20)
)
create table quartos(
	quartos_id int PRIMARY KEY AUTO_INCREMENT,
    quartos_quarto varchar(45) not null,
    quartos_descricao text not null,
    quartos_precodiaria double (6,2),
    quartos_qtdepessoa int,
    quartos_destaque bit(1),
    quartos_arquivarem datetime,
    quartos_status_id int,
    quartos_tipos_id int,
    FOREIGN KEY (quartos_status_id) REFERENCES statos(sta_id),
    FOREIGN KEY (quartos_tipos_id) REFERENCES tipos(tipo_id)
)
create TABLE imagens(
	ima_id int  PRIMARY KEY AUTO_INCREMENT,
    ima_caminho1 varchar(100),
    ima_caminho2 varchar(100),
    ima_quartos_id int,
    FOREIGN KEY (ima_quartos_id) REFERENCES quartos(quartos_id)
)
create table pedidos_reservas(
	ped_res_id int PRIMARY KEY AUTO_INCREMENT,
    ped_res_datareserva datetime,
    ped_res_dataentrada datetime,
    ped_res_datasaida datetime,
    ped_res_nome varchar(70) not null,
    ped_res_cpf varchar(14) unique,
    ped_res_email varchar(70) unique,
    ped_res_acompanhantes int,
    ped_res_quatos_id int,
    ped_res_status_id int,
    FOREIGN KEY (ped_res_quatos_id) REFERENCES quartos(quartos_id),
    FOREIGN key (ped_res_status_id) REFERENCES statos(sta_id)
)
CREATE table reservas(
	reservas_id int PRIMARY key AUTO_INCREMENT,
    reservas_precototal float (6,2),
    reservas_parcelastotal int(2),
    reservas_entrada datetime not null,
    reservas_pedidosresevas_id int,
    reservas_funcionarios_id int,
    reservas_status_id int,
    FOREIGN KEY (reservas_pedidosresevas_id) REFERENCES pedidos_reservas(ped_res_id),
    FOREIGN KEY (reservas_funcionarios_id) REFERENCES funcionarios(func_id),
    FOREIGN KEY (reservas_status_id) REFERENCES statos(sta_id)
)

create table negativas(
	neg_id int AUTO_INCREMENT PRIMARY KEY,
    neg_mot_negativa text,
    neg_ped_res_id int,
    neg_ped_func_id int,
    FOREIGN KEY (neg_ped_res_id) REFERENCES pedidos_reservas(ped_res_id),
    FOREIGN key (neg_ped_func_id) REFERENCES funcionarios(func_id)
)
create table pagamentos(
pag_id int AUTO_INCREMENT PRIMARY key,
 pag_entrada float(6,2),
 pag_restante float(6,2),
 pag_taxa_juros float(6,2),
 pag_formaspagamento_id int,
 pag_reservas_id int,
 FOREIGN KEY (pag_formaspagamento_id) REFERENCES forma_pagamentos(pagamento_id),
 FOREIGN KEY (pag_reservas_id) REFERENCES reservas(reservas_id) );
