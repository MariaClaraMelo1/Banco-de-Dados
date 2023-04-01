CREATE TABLE "usuario" (
  "usu_cd_id" serial not null,
  "usu_tx_senha" varchar(50) not null,
  "usu_tx_nome_usuario" varchar(50) not null unique,
  PRIMARY KEY ("usu_cd_id")
);

CREATE TABLE "endereco" (
  "end_cd_id" serial not null,
  "end_int_cep" integer,
  "end_int_num" int4,
  "end_itx_rua" varchar(80),
  "end_tx_comp" char(20),
  "end_tx_bairro" varchar(50) not null,
  "end_tx_cidade" varchar(50) not null,
  "end_tx_estado" varchar(50) not null,
  PRIMARY KEY ("end_cd_id")

);

CREATE TABLE "cliente" (
  "cli_cd_id" serial not null,
  "cli_tx_nome_cli" varchar(60) not null,
  "cli_tx_email" varchar(80) not null unique,
  "cli_tx_cpf" char(14) not null unique,
  "cli_tx_endereço" varchar(80) not null unique,
  "cli_dt_data_nasc" date not null,
  "cli_int_codigo_cli" integer not null,
  "usu_cd_id" serial not null,
  "end_cd_id" serial not null,
  PRIMARY KEY ("cli_cd_id"),
    CONSTRAINT "FK_usuario.usu_cd_id"
    FOREIGN KEY ("usu_cd_id")
      REFERENCES "usuario"("usu_cd_id"),
	  CONSTRAINT "FK_endereco.end_cd_id"
    FOREIGN KEY ("end_cd_id")
      REFERENCES "endereco"("end_cd_id")
);



CREATE TABLE "funcionario" (
  "fun_cd_id" serial not null,
  "fun_tx_codigo" varchar(256) not null,
  "fun_tx_nome_fun" varchar(60) not null,
  "fun_tx_cpf" varchar(11) not null unique,
  "usu_cd_id" serial not null,
  PRIMARY KEY ("fun_cd_id"),
    CONSTRAINT "FK_usuario.usu_cd_id"
    FOREIGN KEY ("usu_cd_id")
      REFERENCES "usuario"("usu_cd_id")
);

CREATE TABLE "categoria" (
  "cat_cd_id" serial not null,
  "cat_tx_descrição_cat" varchar(256) not null,
  "cat_tx_nome_cat" varchar(60) not null unique,
  "cat_tx_codigo" varchar(256) not null unique,
  PRIMARY KEY ("cat_cd_id")
);

CREATE TABLE "produto" (
  "prod_cd_id" serial not null,
  "prod_tx_nome_prod" varchar(60) not null unique,
  "prod_tx_descricao_prod" varchar(256) not null unique,
  "prod_dt_data_fabri" date not null,
  "prod_int_valor_unitario" integer not null,
  "prod_int_qtd_em_estoque" integer not null ,
  "prod_int_codigo_prod" integer not null,
  "fun_cd_id" serial not null,
  "cat_cd_id" serial not null,
  PRIMARY KEY ("prod_cd_id"),
  CONSTRAINT "FK_funcionario.fun_cd_id"
    FOREIGN KEY ("fun_cd_id")
      REFERENCES "funcionario"("fun_cd_id"),
    CONSTRAINT "FK_categoria.cat_cd_id"
    FOREIGN KEY ("cat_cd_id")
      REFERENCES "categoria"("cat_cd_id")
);

CREATE TABLE "estoque" (
  "est_cd_id" serial not null,
  "est_int_quantidade" integer,
  PRIMARY KEY ("est_cd_id")
);

CREATE TABLE "produto_estoque" (
  "proes_cd_id" serial not null,
  "est_cd_id" serial not null,
  "prod_cd_id" serial not null,
  PRIMARY KEY ("proes_cd_id"),
  CONSTRAINT "FK_produto.prod_cd_id"
    FOREIGN KEY ("prod_cd_id")
      REFERENCES "produto"("prod_cd_id"),
        CONSTRAINT "FK_estoque.est_cd_id"
    	FOREIGN KEY ("est_cd_id")
      REFERENCES "estoque"("est_cd_id")
);

CREATE TABLE "pedido" (
  "ped_cd_id" serial not null,
  "ped_dt_data_pedido" date,
  "ped_tx_codigo_ped" integer not null,
  "cli_cd_id" serial not null,
  "prod_cd_id" serial not null,
  PRIMARY KEY ("ped_cd_id"),
  CONSTRAINT "FK_produto.prod_cd_id"
    FOREIGN KEY ("prod_cd_id")
      REFERENCES "produto"("prod_cd_id"),
    CONSTRAINT "FK_cliente.cli_cd_id"
    FOREIGN KEY ("cli_cd_id")
      REFERENCES "cliente"("cli_cd_id")
);

CREATE TABLE "pedido_item" (
  "pedit_cd_id" serial not null,
  "prod_cd_id" serial not null,
  "ped_cd_id" serial not null,
  PRIMARY KEY ("pedit_cd_id"),
  CONSTRAINT "FK_pedido.ped_cd_id"
    FOREIGN KEY ("ped_cd_id")
      REFERENCES "pedido"("ped_cd_id"),
    CONSTRAINT "FK_produto.prod_cd_id"
    FOREIGN KEY ("prod_cd_id")
      REFERENCES "produto"("prod_cd_id")
);
SELECT * FROM table_pedido;

SELECT DISTINCT column1, column2
FROM table_pedido_item;

SELECT column1, column2
FROM table_produto
WHERE produto_estoque;

DELETE FROM table_cliente WHERE date NULL;

SELECT Max(estoque) AS largestEstoque
FROM produto_estoque;

SELECT count(column_qtd)
FROM table_pedido_item
WHERE serial NOT NULL;

SELECT * FROM produtos
WHERE produtoname LIKE '%a';

SELECT * FROM cliente
WHERE endereco LIKE '_avenida';

SELECT * FROM endereco
WHERE bairro LIKE 'Si_va';

SELECT * FROM endereco
WHERE country NOT IN ('United States', 'Canada', 'Turkish');

SELECT * FROM cliente
WHERE codigo NOT BETWEEN 5 AND 10 caracteres;

SELECT estado, cidade FROM endereco
WHERE estado='Rio de Janeiro'
UNION
SELECT estado, cidade FROM cliente
WHERE estado='Rio de Janeiro'
ORDER BY cidade;

SELECT * INTO usuarioBackup
FROM usuario;

INSERT INTO TABLE endereco
SELECT * FROM TABLE cliente
WHERE rua;