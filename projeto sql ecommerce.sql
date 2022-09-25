
CREATE DATABASE ecommerce;
use ecommerce;

-- -----------------------------------------------------
-- criar tabela Cliente
-- -----------------------------------------------------
create table clients (
  idClient int auto_increment,
  Fname varchar(10),
  Minit varchar(3),
  Lname varchar(20),
  CPF char(11) NOT NULL,
  Address varchar(100),
  primary key (idClient),
  constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;

-- -----------------------------------------------------
-- criar tabela Pedido
-- -----------------------------------------------------
create table orders (
  idOrder int auto_increment,
  idOrderClient int,
  orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
  orderDescription varchar(255),
  sendValue float default 10,
  paymentCash bool default false,
  idPayment int,
  idPPproduct int,
  primary key (idOrder, idOrderClient, idPayment, idPPproduct),
  constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
);

-- -----------------------------------------------------
-- criar tabela Produto
-- -----------------------------------------------------
create table product (
  idProduct int auto_increment,
  Pname varchar(30) not null,
  classification_kids bool default false,
  category enum('Eletrônicos','Vestuario','Brinquedos','Alimentos','Móveis'),
  avaliação float default 0,
  size varchar(15),
  price float NULL,
  primary key (idProduct)
);

-- -----------------------------------------------------
-- criar tabela Pagamentos
-- -----------------------------------------------------
create table payments (
  idPayment int,
  idClient int,
  idProduct int,
  typePayment enum('Boleto','Cartão','Dois cartões'),
  cardNumber varchar(16),
  namePrintedOnCard varchar(20),
  expirationDate char(5),
  primary key (idClient, idPayment, idProduct),
  constraint fk_payments_product foreign key(idProduct) references product(idProduct),
  constraint fk_payments_client foreign key(idClient) references clients(idClient)
);

-- -----------------------------------------------------
-- criar tabela Fornecedor
-- -----------------------------------------------------
create table supplier (
  idSupplier int auto_increment,
  SocialName varchar(255) not null,
  CNPJ char(15) not null,
  contact char(15) not null,
  primary key (idSupplier),
  constraint unique_supplier unique (CNPJ)
);

-- -----------------------------------------------------
-- criar tabela Produto_fornecedor
-- -----------------------------------------------------
create table productSupplier (
  idPsSupplier int,
  idPsProduct int,
  quantity int not null,
  primary key (idPsSupplier, idPsProduct),
  constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
  constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

-- -----------------------------------------------------
-- criar tabela Estoque
-- -----------------------------------------------------
create table productStorage (
  idProdStorage int auto_increment,
  storageLocation varchar(255),
  quantity int default 0,
  primary key (idProdStorage)
);

-- -----------------------------------------------------
-- criar tabela Produto_em_Estoque (localização)
-- -----------------------------------------------------
create table storageLocation (
  idLproduct int,
  idLstorage int,
  location varchar(255) not null,
  primary key (idLproduct, idLstorage),
  constraint fk_storage_location_product foreign key(idLproduct) references product(idProduct),
  constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idProdStorage)
);

-----------------------------------------------------
-- criar tabela Produto/Pedido
-- -----------------------------------------------------
create table productOrder (
  idPOproduct int,
  idPOorder int,
  poQuantity int default 1,
  poStatus enum('disponível', 'sem estoque') default 'disponível',
  primary key (idPOproduct, idPOorder),
  constraint fk_product_product foreign key(idPOproduct) references product(idProduct),
  constraint fk_product_order_product foreign key(idPOorder) references orders(idOrder)
);

-- -----------------------------------------------------
-- criar tabela Vendedor
-- -----------------------------------------------------
create table seller (
  idSeller int auto_increment,
  SocialName VARCHAR(255) not null,
  AbstName varchar(255),
  CNPJ char(15) null,
  CPF char(11) null,
  location varchar(255),
  contact char(15) not null,
  primary key (idSeller),
  constraint unique_cnpj_seller unique (CNPJ),
  constraint unique_cpf_seller unique (CPF)
);

-- -----------------------------------------------------
-- criar tabela Produtos_vendedor (terceiro)
-- -----------------------------------------------------
create table productSeller (
  idPseller int,
  idPproduct int ,
  prodQuantity int default 1,
  primary key (idPseller, idPproduct),
  constraint fk_product_pseller foreign key (idPseller) references seller(idSeller),
  constraint fk_product_seller_product foreign key (idPproduct) references product(idProduct)
  );

-- ----------------------------------------------------
-- criar tabela Metodos Pagamentos
-- -----------------------------------------------------
create table pMethod (
  idPMethod int,
  idPPayment int,
  MPayment enum('Boleto','Cartão de credito','Dois cartões'),
  primary key (idPMethod, idPPayment)
);

-- -----------------------------------------------------
-- criar tabela de Rastreamento
-- -----------------------------------------------------
create table tracking (
  idTracking int auto_increment,
  idOrder int not null,
  idPCClient int,
  Descrição varchar(255),
  geo_lat varchar(14),
  geo_long varchar(14),
  idStatus int,
  primary key (idtracking, idStatus, idOrder, idPCClient)
);

-- -----------------------------------------------------
-- Table Status Rastreamento
-- -----------------------------------------------------


show tables;create table statusTracking (
  idSTracking int,
  descrição varchar(255),
  primary key (idSTracking)
);
show databases;
show tables;
