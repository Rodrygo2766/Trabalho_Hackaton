CREATE DATABASE nexa;
-- Execute as tabelas já conectado ao banco nexa.
CREATE TABLE cadastro(
 id SERIAL PRIMARY KEY,
 nome VARCHAR(50) NOT NULL,
 email VARCHAR(50) NOT NULL UNIQUE,
 senha VARCHAR(255) NOT NULL,
 foto_url TEXT
);
CREATE TABLE area(
 id SERIAL PRIMARY KEY,
 nicho_area VARCHAR(50),
 tempo_area INT,
 id_cadastro INT NOT NULL REFERENCES cadastro(id) ON DELETE CASCADE
);
CREATE TABLE post(
 id SERIAL PRIMARY KEY,
 id_cadastro INT NOT NULL REFERENCES cadastro(id) ON DELETE CASCADE,
 id_area INT NOT NULL REFERENCES area(id) ON DELETE CASCADE,
 descricao VARCHAR(300),
 imagem_url TEXT
);
CREATE TABLE comentario(
 id SERIAL PRIMARY KEY,
 id_cadastro INT NOT NULL REFERENCES cadastro(id) ON DELETE CASCADE,
 id_area INT NOT NULL REFERENCES area(id) ON DELETE CASCADE,
 id_post INT NOT NULL REFERENCES post(id) ON DELETE CASCADE,
 mensagem VARCHAR(100)
);
