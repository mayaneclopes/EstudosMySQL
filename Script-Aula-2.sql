select * from produto p
select * from classificacao c ;

--ex.1 retornar os produtos da Classificação 003 e que a unidade de medida não
seja 'UN'
R: 139 registros--
select * from produto p 
where p.CODIGO_CLASSIFICACAO = '003' 
and p.UNIDADE <> 'UN';

--ex.2 Retornar os produtos da Classificação 003, com a unidade de medida 'UN'
em que a quantidade seja entre 5 e 7 com o valor menor que 10;
R: 27 registros--
select * from produto p 
where p.CODIGO_CLASSIFICACAO = '003'
and p.UNIDADE = 'UN'
and p.QUANTIDADE >=5 and p.QUANTIDADE <=7
and p.VALOR < 10;

--ex.3 Valor total dos 'biscoito' da base de dados
R: 3021--
SELECT SUM(valor) AS valor_total_biscoito
FROM produto p 
INNER JOIN classificacao c ON c.CODIGO = p.CODIGO_CLASSIFICACAO 
WHERE p.DESCRICAO LIKE '%biscoito%';

--ex.4 Validar se existe algum 'martelo' que não pertença a 
classificação material de Construção--
SELECT * FROM produto p 
INNER JOIN classificacao c ON c.CODIGO = p.CODIGO_CLASSIFICACAO 
WHERE p.DESCRICAO LIKE '%martelo%'
AND (c.DESCRICAO NOT LIKE '%materiais de construção%');


--ex.5 Retornar os produtos da classificação EPI que estejam em menos
de 5 caixas
R: 2 registros--
select * from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO 
where c.DESCRICAO like 'EPI%'
and p.unidade like 'CX%'
and p.QUANTIDADE < 5;

--ex.6 Retornar os produtos da Classificação EPI que NÃO ESTEJA em
caixas e sua quantidade esteja em 10 e 50
R:9 registros--
select * from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO 
where c.DESCRICAO like 'EPI%'
and p.UNIDADE not like 'CX%'
and p.QUANTIDADE >= 10 and p.QUANTIDADE <= 50;

--ex.7 Retornar todos registros da classificação UNIFORMES com o nome
camiseta e todos os produtos da classificação MATERIAL ESPORTIVO
e com nome bola--
select * from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO 
where 
	(c.DESCRICAO like '%UNIFORMES%' and p.DESCRICAO like 'camiseta%')
	or 
	(c.DESCRICAO like 'MATERIAIS ESPORTIVOS%' and p.DESCRICAO like 'bola%')

--ex.8 Retornar a média do valor dos produtos que a quantidade esteja entre
2 e 4, com valor inferior a 50, que não seja material de construção e que
não seja um 'copo'
R: 18.8688--
select AVG(p.valor) as media_valor 
from produto p 
where p.QUANTIDADE between 2 and 4
and p.valor < 50
and p.DESCRICAO not like 'MATERIAIS DE CONS%'
and p.DESCRICAO not like 'COPO%';

--EX.9 Retornar o quantidade total de pacotes ( PCT) dos produtos
alimenticios 
R: 1165--
select sum(p.QUANTIDADE) as soma 
from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO 
where p.UNIDADE like 'PCT%'
and c.DESCRICAO like 'Produtos Alimentícios%';


--EX.10 Retornar apenas o numero total de produtos cadastrados com
unidade pacote e que seja da classificação de alimentos
R: 23 produtos --
select count(valor) as contador 
from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO 
where p.UNIDADE like 'PCT%'
and c.DESCRICAO like 'Produtos Alimentícios%';

--EX.11 Retornar qual é o maior valor de um produto do estoque, este deve
ser o produto que sua quantidade * valor seja o maior 
R. 1134870--
select max(p.quantidade * p.valor) as total,
p.descricao
from produto p 
where p.tipo = 'P'
group by p.codigo 
having sum(p.valor * p.quantidade) = 
(select max(p2.quantidade * p2.valor) from produto p2
where p2.tipo = 'p')

--EX12 Retornar o menor valor de um produto que a quantidade seja maior
que 0 e que a unidade seja ‘UN’ e classificação alimentos
R: 1--
select min(valor) as menor_valor
from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO
where p.QUANTIDADE > 0
and c.DESCRICAO like 'produtos alimenticios%'

--EX13 Retornar é o valor total dos produtos da categoria ‘Material
Hospitalares’
R: 406355 -- 
select sum(valor * quantidade) as valor_total
from produto p 
inner join classificacao c on c.CODIGO = p.CODIGO_CLASSIFICACAO
where c.DESCRICAO like 'materiais hospitalares%';

--EX14 Retornar TODOS os valores totais por categoria e ordenar por
categoria--
select c.DESCRICAO as categoria, SUM(p.QUANTIDADE * p.VALOR) as valor_total
from produto p 
inner join classificacao c on c.codigo = p.codigo_classificacao
group by c.descricao
order by c.descricao;

--EX15 Retornar todos os tipos de ‘UNIDADE’ da classificação Veterinária
R: 12 --
select distinct(unidade) as tipos
from produto p 
inner join classificacao c on c.codigo = p.codigo_classificacao
where c.descricao like 'Veterinária%';

--EX16 Contar Quantos produtos são da categoria de Aviamentos por
unidade. EX: (20 produtos - UN; 2 PRODUTOS - PCT) --
select count(*) as quantidade
		p.UNIDADE as unid
from produto p 
inner join classificacao c on c.codigo = p.codigo_classificacao
where c.descricao like 'aviamentos%'
group by p.unidade
