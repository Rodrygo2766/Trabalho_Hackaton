CREATE DATABASE nexa;

CREATE TABLE cadastro(
	id SERIAL,
	nome VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	senha VARCHAR(15) NOT NULL,
	CONSTRAINT pk_cadastro PRIMARY KEY(id)
);

CREATE TABLE area(
	id SERIAL,
	nicho_area VARCHAR(15),
	tempo_area INT,
	id_cadastro INT NOT NULL,
	CONSTRAINT pk_area PRIMARY KEY(id),
	CONSTRAINT fk_cadastro FOREIGN KEY(id_cadastro) REFERENCES cadastro(id)
);

CREATE TABLE post(
	id SERIAL,
	id_cadastro INT NOT NULL,
	id_area INT NOT NULL,
	descricao VARCHAR(300),
	CONSTRAINT pk_post PRIMARY KEY(id),
	CONSTRAINT fk_cadastro FOREIGN KEY(id_cadastro) REFERENCES cadastro(id),
	CONSTRAINT fk_area FOREIGN KEY(id_area) REFERENCES area(id)
);

CREATE TABLE comentario(
	id SERIAL,
	id_cadastro INT NOT NULL,
	id_area INT NOT NULL,
	id_post INT NOT NULL,
	mensagem VARCHAR(100),
	CONSTRAINT pk_comentario PRIMARY KEY(id),
	CONSTRAINT fk_cadastro FOREIGN KEY(id_cadastro) REFERENCES cadastro(id),
	CONSTRAINT fk_area FOREIGN KEY(id_area) REFERENCES area(id),
	CONSTRAINT fk_post FOREIGN KEY(id_post) REFERENCES post(id)
);

select * from cadastro;
select * from area;
select * from post;
select * from comentario;
