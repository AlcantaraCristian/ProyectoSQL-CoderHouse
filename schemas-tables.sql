CREATE DATABASE  IF NOT EXISTS `app_pedidos_en_linea`;
USE `app_pedidos_en_linea`;


DROP TABLE IF EXISTS `clientes`;
/*
	Tabla clientes.
	Muestra informacion del usuario o cliente que realiza un pedido.
*/
CREATE TABLE `clientes` (
  `id_cli` int NOT NULL AUTO_INCREMENT,
  `cli_nombre` varchar(45) NOT NULL,
  `cli_apellido` varchar(45) NOT NULL,
  `cli_telefono` varchar(20) NOT NULL,
  `cli_direccion` varchar(60) NOT NULL,
  `cli_estado` char(1) NOT NULL,
  `cli_contrasena` varchar(45) NOT NULL,
  `id_zona` int not null,
  PRIMARY KEY (`id_cli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `repartidores`;
/*
	Tabla repartidores
    Muestra informacion del repartidor que entrega el pedido.
*/

CREATE TABLE `repartidores` (
  `id_rep` int NOT NULL AUTO_INCREMENT,
  `rep_nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rep_apellido` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rep_telefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rep_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rep_contrasena` varchar(8) NOT NULL,
  `rep_categoria` tinyint not null,
  `id_turno` int not null,
  `rep_estado` varchar(20) not null,
  PRIMARY KEY (`id_rep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `comercios`;
/*
	Tabla comercios.
    Muestra informacion de los comercios que venden los productos.
*/

CREATE TABLE `comercios` (
  `id_com` int NOT NULL AUTO_INCREMENT,
  `com_nombre` varchar(45) NOT NULL,
  `com_telefono` varchar(20) NOT NULL,
  `com_email` varchar(45) NOT NULL,
  `com_contrasena` varchar(45) NOT NULL,
  `com_direccion` varchar(45) NOT NULL,
  `com_estado` char(1) NOT NULL,
  `com_comision_servicio` tinyint NOT NULL,
  `id_zona` int not null,
  PRIMARY KEY (`id_com`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `productos`;
/*
	Tabla productos.
    Muestra el producto, su descripcion y si esta disponible. 
*/

CREATE TABLE `productos` (
  `id_prod` int NOT NULL AUTO_INCREMENT,
  `prod_precio` decimal(10,2) NOT NULL,
  `prod_descripcion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prod_status` tinyint(1) NOT NULL,
  `id_com` int NOT NULL,
  PRIMARY KEY (`id_prod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `zonas`;
/*
	Tabla zonas
    Es la zona donde se encuentra un comercio y donde puede llevar los pedidos el repartidor .
*/

CREATE TABLE `zonas` (
  `id_zona` int NOT NULL AUTO_INCREMENT,
  `zon_nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,  
  PRIMARY KEY (`id_zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `turnos`;
/*
	Tabla turnos
    Muestra la fecha, hora y zona que elige un repartidor para trabajar.
*/

CREATE TABLE `turnos` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `tur_fecha` date NOT NULL, 
  `tur_hs_inicio` datetime not null,
  `tur_hs_fin` datetime not null,
  `id_zona` int not null,
  PRIMARY KEY (`id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `cupones`;
/*
	Tabla cupones.
	Muestra los cupones para obtener descuetos, con la fecha de inicio y fin de cada uno.
*/

CREATE TABLE `cupones` (
  `id_cup` int NOT NULL AUTO_INCREMENT,
  `cup_codigo` varchar(8) NOT NULL,
  `cup_descuento` decimal(10,2) not null,
  `cup_fecha_inicio` date not null,
  `cup_fecha_fin` date not null,
  PRIMARY KEY (`id_cup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `formas_de_pago`;
/*
	Tabla formas de pago.
    Muestra las formas de pago disponible.
*/

CREATE TABLE `formas_de_pago` (
  `id_fPago` int NOT NULL AUTO_INCREMENT,
  `f_Pago` varchar(45) NOT NULL,
  `id_cup` int,
  PRIMARY KEY (`id_fPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `pedidos`;
/*
	Tabla pedidos.
    Muestra informacion basica de los pedidos realizados por los clientes.
*/

CREATE TABLE `pedidos` (
  `id_ped` int NOT NULL AUTO_INCREMENT,
  `id_prod` int NOT NULL,    
  PRIMARY KEY (`id_ped`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `detalle_pedido`;
/*
	Tabla detalle pedido.
    Muestra el tiempo desde que se realiza el pedido hasta que es entregado, el producto y cantidad,
    muestra si tiene descuento, la comision que se le cobra al local, costo de envio, si el cliente deja 
    propina, comentarios hacia el local y para la entrega.
*/

CREATE TABLE `detalle_pedido` (
  `id_dp` int NOT NULL AUTO_INCREMENT,
  `id_ped` int NOT NULL,
  `dp_fecha` date not null,
  `dp_hs_entrada` datetime NOT NULL,
  `dp_hs_entrega_repartidor` datetime NOT NULL,
  `dp_hs_entrega_cliente` datetime NOT NULL,
  `id_com` int NOT NULL DEFAULT '0',
  `id_rep` int NOT NULL DEFAULT '0',
  `dp_prod_cantidad` int NOT NULL DEFAULT '0',   
  `dp_comision` decimal(10,2) NOT NULL DEFAULT '0.00',
  `dp_costo_envio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `id_cup` int not null,
  `dp_propina` decimal(10,2) DEFAULT '0.00',
  `dp_precio_total` decimal(10,2) NOT NULL DEFAULT '0.00', 
  `id_fPago` int NOT NULL,
  `dp_descripcion_comercio` varchar(45) DEFAULT NULL,
  `dp_descripcion_entrega` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_dp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*** LLAVES FORANEAS ***/

alter table clientes add 
foreign key(id_zona) 	
references zonas(id_zona);	

alter table repartidores add 
foreign key(id_turno) 	
references turnos(id_turno);	

alter table comercios add 
foreign key(id_zona) 	
references zonas(id_zona);	

alter table productos add 
foreign key(id_com) 	
references comercios(id_com);	

alter table turnos add
foreign key(id_zona)
references zonas(id_zona);

alter table formas_de_pago add
foreign key(id_cup)
references cupones(id_cup); 

alter table pedidos add 
foreign key(id_prod) 	
references productos(id_prod);

alter table detalle_pedido add 
foreign key(id_ped) 	
references pedidos(id_ped);

alter table detalle_pedido add 
foreign key(id_com) 	
references comercios(id_com);

alter table detalle_pedido add 
foreign key(id_rep) 	
references repartidores(id_rep);

alter table detalle_pedido add 
foreign key(id_fPago) 	
references formas_de_pago(id_fPago);


















