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

 drop database thermus;