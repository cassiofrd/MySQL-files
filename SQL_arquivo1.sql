create database if not exists Sales;
use Sales;
create table sales
(
purchase_number INT NOT NULL PRIMARY KEY auto_increment,
date_of_purchase DATE NOT NULL,
customer_id INT,
item_code VARCHAR(10) NOT NULL
);

CREATE TABLE customers                                                 
( 
    customer_id INT, 
    first_name varchar(255), 
    last_name varchar(255), 
    email_address varchar(255), 
    number_of_complaints int 
);

drop table sales.sales;
use Sales;
create table sales
(
	purchase_number int auto_increment,
	date_of_purchase date,
	customer_id int,
	item_code varchar(10),
	primary key (purchase_number)
);

drop table sales.customers;
use Sales;
CREATE TABLE customers                                                               
(   
    customer_id INT,   
    first_name varchar(255),   
    last_name varchar(255),   
    email_address varchar(255),   
    number_of_complaints int,   
primary key (customer_id)   
);   
    
CREATE TABLE items                                                                                                                               
(   
    item_code varchar(255),    
    item varchar(255),   
    unit_price numeric(10,2),   
    company_id varchar(255),
primary key (item_code)    
);   
    CREATE TABLE companies    
(
    company_id varchar(255),   
    company_name varchar(255),   
    headquarters_phone_number int(12),   
primary key (company_id)   
); 
drop table sales;
drop table customers;
drop table items;
drop table companies;
use Sales;
CREATE TABLE customers ( 
    customer_id INT AUTO_INCREMENT, 
    first_name VARCHAR(255), 
    last_name VARCHAR(255), 
    email_address VARCHAR(255), 
    number_of_complaints INT, 
PRIMARY KEY (customer_id) 
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name; 
  
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints) 
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0) 
;
select * from customers;
alter table customers
alter column number_of_complaints drop default;

#vou fazer minha própria base de dados
create database if not exists cassio;
use cassio;
create table dados
(
    id int AUTO_INCREMENT,
    nome varchar(255), 
    email_address varchar(255), 
    idade varchar(255),
    tem_cachorro varchar(255), 
PRIMARY KEY (id) 
);
ALTER TABLE dados
ADD COLUMN sexo ENUM('M', 'F') AFTER tem_cachorro;   
INSERT INTO dados (nome,idade,tem_cachorro,sexo) 
VALUES ('Cássio', '29', 'Sim', 'M') 
;
#vamos inserir alguns valores naqueles células vazias
insert into dados (email_address)
values ('cassioealan@ig.com.br')
;
select * from dados;
use sales;
CREATE TABLE companies
(
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255),
PRIMARY KEY (company_id),
UNIQUE KEY (headquarters_phone_number) #unique key aceita valores em branco, primary key não
);

ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;
ALTER TABLE companies 
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL;
#é bom lembrar que NULL é o valor utilizado pelo sql para representar missings, a ausência de dados. NONE e 0 são dados utilizáveis
#é importante lembrar que no sql os condicionantes and são lidos primeiro e os or lidos depois
#update permite modificar valores nas tabelas
#era isso que eu queria saber
use cassio;
select * from dados;
update dados set email_address='cassiofrd@gmail.com' where nome='Cássio';
#para deletar uma observação ou observações que tem determinada característica, devemos utilizar o comando delete e operar como nos demais casos
#tenho que usar is null, =null não funciona
delete from dados where nome is null;
#drop deleta tabelas e bases
#delete deleta observações de uma coluna, não a coluna em si
INSERT INTO dados (id, nome, email_address, idade, tem_cachorro, sexo) 
VALUES ('2', 'Calton', 'calton@gmail.com', '17', 'Sim', 'M') 
;
select sum(idade) from dados;
select min(idade) from dados;
select max(idade) from dados;
#round é uma função que arredonda os valores de média
select round(avg(idade),0) from dados;

create table dados2
(
id INT NOT NULL PRIMARY KEY auto_increment,
data_nascimento DATE NOT NULL,
nome VARCHAR(10) NOT NULL
);
ALTER TABLE dados2
ADD COLUMN anos_estudo int AFTER nome; 
INSERT INTO dados2 (data_nascimento, nome, anos_estudo) 
VALUES ('1990-05-10','Cássio','5') ,
('1980-05-11','Calton','15');
select * from dados2;
#vamos agora agregar as colunas de dados à de dados2 e fazer uma nova tabela
#vamos usar abreviações:d1 para dados e d2 para dados2
#inner join considera apenas os valores para nome que estão nas duas tabmelas ao mesmo tempo
select d1.email_address, d1.idade, d1.tem_cachorro, d1.sexo, d1.nome
from dados d1
join dados2 d2 on d1.nome=d2.nome order by d1.idade;
#utilizando left join no lugar de join não apenas os dados em comum nos dois conjuntos, mais um dos conjuntos juntamente com a unição de ambos os conjuntos irá aparecer
INSERT INTO dados2 (data_nascimento, nome, anos_estudo) 
VALUES ('1998-05-05','Will','0') 
;
INSERT INTO dados (nome, email_address, idade, tem_cachorro, sexo) 
VALUES ('RB', 'rb@gmail.com', '23', 'Sim', 'F')
;
#a ordem em que eu coloco as tabelas no comando fará com que outputs diferentes me sejam dados
select d1.email_address, d1.idade, d1.tem_cachorro, d1.sexo, d1.nome, d2.data_nascimento, d2.anos_estudo
from dados d1
left join dados2 d2 on d1.nome=d2.nome order by d1.idade;
select d1.email_address, d1.idade, d1.tem_cachorro, d1.sexo, d1.nome, d2.data_nascimento, d2.anos_estudo
from dados2 d2
left join dados d1 on d1.nome=d2.nome order by d1.idade;
#já o comando right join junta a interseção com os dados exclusivos do conjunto localizado à direita, não há esquerda
#vamos utilizar o where junto com o join, ou seja, vamos juntar duas tabelas com restrições
use cassio;
select * from dados2;
select d1.email_address, d1.idade, d1.tem_cachorro, d1.sexo, d1.nome
from dados d1
join dados2 d2 on d1.nome=d2.nome
where d2.anos_estudo>'10'
order by d1.idade;
#o cross join permite agregar todas as observações de duas tabelas, não apenas as que derem matching
select dados.*, dados2.data_nascimento, dados2.anos_estudo from dados
join dados2
order by dados.idade;
#podemos usar funções que nos dão resultados agregados relacionando duas
#tabelas
select d1.sexo, avg(d2.anos_estudo)
from dados2 d2
join dados d1 on d1.nome=d2.nome order by d1.sexo;
use cassio;
CREATE TABLE dados3
(
    id int auto_increment,
    nome VARCHAR(255),
    telefone VARCHAR(255),
PRIMARY KEY (id)
);
INSERT INTO dados3 (nome, telefone) 
VALUES ('Calton', '3134431091') ,
 ('Cássio', '988338926') ,
 ('Xisto', '15292738') 
;
select d1.*, d2.*, d3.*
from dados d1
join dados2 d2 on d1.nome=d2.nome
join dados3 d3 on d1.nome=d3.nome
order by d1.idade;
#lembrando que o que eu preciso é que a tabela d1 tenha alguma coluna
#relacionada à d2 e alguma à d3, não havendo necessidade de d2 e d3 
#terem uma coluna em comum
use cassio;
CREATE TABLE dados4
(
    id int auto_increment,
    anos_experiência VARCHAR(255),
    telefone VARCHAR(255),
PRIMARY KEY (id)
);
INSERT INTO dados4 (anos_experiência, telefone) 
VALUES ('25', '3134431091') ,
 ('7', '988338926') ,
 ('8', '15292738') 
;
#vamos relacionar as tabelas dados4 e dados3 por relacionando telefone e nome
#funcionou perfeitamente, ótimo
select d1.nome, d1.idade, d1.sexo, d3.telefone, d4.anos_experiência
from dados d1
join dados2 d2 on d2.nome=d1.nome
join dados3 d3 on d3.nome=d2.nome
join dados4 d4 on d4.telefone=d3.telefone order by d1.nome;
