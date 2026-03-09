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

create table instituto (
    id_instituto int primary key auto_increment,
    nome_instituto varchar(60) not null,
    cnpj char(14) not null unique,
    telefone varchar(15),
    email varchar(100),
    statusInstituto varchar(10) not null default 'ativa',
    data_cadastro datetime default current_timestamp,
    check (statusInstituto in ('ativa', 'inativa'))
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

insert into ambiente (nomeambiente, andar, descricao) values
('Galeria Renascentista', 1, 'Ala norte com pé direito alto'),
('Depósito de Acervo', 0, 'Subsolo com controle rigoroso de temperatura'),
('Sala de Restauração', 2, 'Laboratório técnico');

insert into  vitrine (codigo_vitrine, descricao) values
('VIT-001', 'Vitrine de vidro temperado com vedação hermética'),
('VIT-002', 'Expositor central aberto'),
('VIT-003', 'Nichos de parede com iluminação LED fria');

insert into sensor (tiposensor, localizacao, statussensor) values
('DHT11', 'Parede Leste - Galeria 1', 'ativo'),
('DHT22', 'Interno - Vitrine 001', 'ativo'),
('LM35', 'Teto - Depósito', 'manutencao');

insert into medicao (temperatura, umidade) values 
(22.50, 45.00),
(23.10, 48.50),
(19.00, 40.00),
(25.80, 60.00); 

insert into alerta (tipoalerta, descricao) values
('Umidade Alta', 'Nível de umidade excedeu 55% no Depósito'),
('Oscilação Térmica', 'Variação brusca detectada na Vitrine 001');

insert into usuario (nome, cargo, email, senha) values
('Carlos Andrade', 'Curador', 'carlos@museu.com', 'Cura123#'),
('Ana Souza', 'Técnica de Manutenção', 'ana.s@monitoramento.com', 'Mant456!'),
('Marcos Silva', 'Administrador', 'admin@sistema.com', 'Sudo789$');

insert into instituto (nome_instituto, cnpj, telefone, email) values 
('Tech Guard Monitoramento', '12345678000199', '(11) 98888-7777', 'contato@techguard.com'),
('Artes & Cia Exposição', '98765432000188', '(21) 3333-4444', 'logistica@artescia.com');

insert into  obra (titulo, artista, ano, material, sensibilidade_umidade, sensibilidade_temperatura) values 
('O Grito (Estudo)', 'Edvard Munch', 1893, 'Pastel sobre cartão', 'alta', 'alta'),
('Estátua de Mármore', 'Desconhecido', 1550, 'Mármore Carrara', 'baixa', 'media'),
('Manuscrito Antigo', 'Monge Beneditino', 1200, 'Pergaminho e Tinta Ferrogalica', 'alta', 'alta');


select * from instituto;

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

select * from medicao where temperatura > 25.00 or umidade > 50.00;


