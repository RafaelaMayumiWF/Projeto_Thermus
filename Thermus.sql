create database thermus;
use thermus;

create table ambiente (
    idambiente int primary key auto_increment,
    nomeambiente varchar(100) not null,
    andar int null,
    descricao varchar(300)
);

create table vitrine (
    idvitrine int primary key auto_increment,
    codigo_vitrine varchar(50) not null,
    descricao varchar(300)
);

create table sensor (
    idsensor int primary key auto_increment,
    tiposensor varchar(50) not null,
    localizacao varchar(100),
    statussensor varchar(10) default 'ativo',
    check (statussensor in ('ativo', 'inativo', 'manutencao'))
);

create table medicao (
    idmedicao int primary key auto_increment,
    temperatura decimal(5,2) not null,
    umidade decimal(5,2) not null,
    datahora datetime default current_timestamp
);

create table alerta (
    idalerta int primary key auto_increment,
    tipoalerta varchar(50) not null,
    descricao varchar(200),
    datahora datetime default current_timestamp
);

create table usuario (
    idusuario int primary key auto_increment,
    nome varchar(100) not null,
    cargo varchar(50),
    email varchar(100) not null unique,
    senha varchar(30) not null
);

create table empresa (
    id_empresa int primary key auto_increment,
    nome_empresa varchar(60) not null,
    cnpj char(14) not null unique,
    telefone varchar(15),
    email varchar(100),
    statusEmpresa varchar(10) not null default 'ativa',
    data_cadastro datetime default current_timestamp,
    check (statusEmpresa in ('ativa', 'inativa'))
);

create table obra (
    id_obra int primary key auto_increment,
    titulo varchar(60) not null,
    artista varchar(100),
    ano int,
    material varchar(150),
    sensibilidade_umidade varchar(10) not null,
    sensibilidade_temperatura varchar(10) not null,
    check (sensibilidade_umidade in ('baixa', 'media', 'alta')),
    check (sensibilidade_temperatura in ('baixa', 'media', 'alta'))
);

insert into empresa (nome_empresa, cnpj, telefone, email, statusEmpresa)
values 
('museu nacional', '12345678000199', '11987654321', 'contato@museunacional.org', 'ativa'),
('museu de arte moderna', '98765432000155', '11345678900', 'contato@mam.org', 'ativa');


insert into ambiente (nomeambiente, andar, descricao)
values
('sala de exposicao 1', 1, 'sala principal de exposicao'),
('sala de exposicao 2', 2, 'sala com obras modernas');


insert into vitrine (codigo_vitrine, descricao)
values
('vit-01', 'vitrine com documentos historicos'),
('vit-02', 'vitrine com esculturas');


insert into sensor (tiposensor, localizacao, statussensor)
values
('dht11', 'vitrine vit-01', 'ativo'),
('dht11', 'vitrine vit-02', 'ativo');


insert into medicao (temperatura, umidade)
values
(21.5, 55.2),
(22.1, 53.8),
(20.9, 57.0);


insert into alerta (tipoalerta, descricao)
values
('umidade alta', 'umidade proxima ao ponto de orvalho'),
('temperatura baixa', 'risco de condensacao na vitrine');


insert into usuario (nome, cargo, email, senha)
values
('ana silva', 'curadora', 'ana@museu.org', '123456'),
('carlos souza', 'administrador', 'carlos@museu.org', '123456');


insert into obra (titulo, artista, ano, material, sensibilidade_umidade, sensibilidade_temperatura)
values
('carta historica', 'autor desconhecido', 1850, 'papel', 'alta', 'media'),
('escultura antiga', 'artista classico', 1700, 'bronze', 'baixa', 'media');


select * from empresa;

select * from ambiente;

select * from sensor
where statussensor = 'ativo';

select 
concat(titulo, ' - ', artista) as obra,
material,
case
    when sensibilidade_umidade = 'alta' then 'controle ambiental critico'
    when sensibilidade_umidade = 'media' then 'atencao moderada'
    else 'baixo risco'
end as nivel_monitoramento
from obra;