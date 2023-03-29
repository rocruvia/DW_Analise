-- Cria  Schema
CREATE SCHEMA dimensional;

-- Cria tabela dimensão cliente
CREATE  TABLE dimensional.dcliente ( 
	sk_cliente           INT  NOT NULL AUTO_INCREMENT    PRIMARY KEY,
	id_cliente           VARCHAR(20)       ,
	nome_cliente         VARCHAR(100)       ,
	cidade_cliente       VARCHAR(50)       ,
	aceita_campanha      CHAR(1)       ,
	cep                  VARCHAR(8)       
 );

-- Cria tabela dimensão localização
CREATE  TABLE dimensional.dlocalizacao ( 
	sk_localidade        INT  NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	id_localidade        VARCHAR(20)       ,
	nome_localidade      VARCHAR(50)       ,
	cidade_localidade    VARCHAR(50)       ,
	regiao_localidade    VARCHAR(50)       
 );

-- Cria tabela dimensão produto
CREATE  TABLE dimensional.dproduto ( 
	sk_produto           INT  NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	id_produto           VARCHAR(20)       ,
	sku                  VARCHAR(50)       ,
	nome_produto         VARCHAR(50)       ,
	categoria_produto    VARCHAR(30)       ,
	marca_produto        VARCHAR(30)       
 );

-- Cria tabela dimensão tempo
CREATE  TABLE dimensional.dtempo ( 
	sk_data              INT  NOT NULL	PRIMARY KEY,
	data                 DATE       ,
	ano                  INT       ,
	mes                  INT       ,
	dia                  INT       ,
	trimestre            INT       ,
	semana               INT       ,
	dia_semana           VARCHAR(10)  NOT NULL     ,
	nome_mes			 VARCHAR(10)  NOT NULL	   ,
	feriado        		 CHAR(1)	DEFAULT 'f'	   ,
	fim_de_semana  		 CHAR(1)	DEFAULT 'f'	   ,    
	UNIQUE amd_idx		 (ano, mes,dia)			   ,
	UNIQUE data_idx 	 (data) 				   	
 );

-- Cria tabela fato vendas
CREATE  TABLE dimensional.fvendas ( 
	sk_cliente           INT  NOT NULL     ,
	sk_produto           INT  NOT NULL     ,
	sk_localidade        INT  NOT NULL     ,
	sk_tempo             INT  NOT NULL     ,
	valor_venda          DECIMAL(5,2)       ,
	quantidade_venda     INT       ,
	CONSTRAINT pk_fvendas PRIMARY KEY ( sk_cliente, sk_produto, sk_localidade, sk_tempo )
 );

-- Cria restrição sk_cliente
ALTER TABLE dimensional.fvendas ADD CONSTRAINT fk_fvendas_dcliente FOREIGN KEY ( sk_cliente ) REFERENCES dimensional.dcliente( sk_cliente ) ON DELETE CASCADE ON UPDATE CASCADE;

-- Cria restrição sk_produto
ALTER TABLE dimensional.fvendas ADD CONSTRAINT fk_fvendas_dproduto FOREIGN KEY ( sk_produto ) REFERENCES dimensional.dproduto( sk_produto ) ON DELETE CASCADE ON UPDATE CASCADE;

-- Cria restrição dlocalizacao
ALTER TABLE dimensional.fvendas ADD CONSTRAINT fk_fvendas_dlocalizacao FOREIGN KEY ( sk_localidade ) REFERENCES dimensional.dlocalizacao( sk_localidade ) ON DELETE CASCADE ON UPDATE CASCADE;

-- Cria restrição dtempo
ALTER TABLE dimensional.fvendas ADD CONSTRAINT fk_fvendas_dtempo FOREIGN KEY ( sk_data ) REFERENCES dimensional.dtempo( sk_data ) ON DELETE CASCADE ON UPDATE CASCADE;

