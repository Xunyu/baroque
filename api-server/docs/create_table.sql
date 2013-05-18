CREATE TABLE `bar_menu` (
  `FoodID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `FoodName` varchar(50) NOT NULL COMMENT '菜名',
  `Description` varchar(200) DEFAULT NULL COMMENT '描述',
  `FoodType` smallint(6) NOT NULL COMMENT '菜品类型(菜,主食,酒水)',
  `Price` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '售价',
  `Cost` decimal(10,0) NOT NULL DEFAULT '0' COMMENT '成本',
  `CategoryID` smallint(6) DEFAULT NULL COMMENT '菜系：湘菜粤菜等',
  `TastyType` smallint(6) DEFAULT NULL COMMENT '甜、酸、辣、超级辣、主厨推荐',
  `PicUrl` varchar(50) DEFAULT NULL COMMENT '图片URL',
  `Status` smallint(6) DEFAULT NULL COMMENT '状态（是否开卖等）',
  `AddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`FoodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品表';


