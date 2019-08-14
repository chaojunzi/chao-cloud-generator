/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-08-14 13:53:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for xc_config
-- ----------------------------
DROP TABLE IF EXISTS `xc_config`;
CREATE TABLE `xc_config` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL COMMENT '分组id',
  `author` varchar(255) DEFAULT '' COMMENT '作者',
  `package_name` varchar(255) DEFAULT '' COMMENT '包名',
  `title` varchar(30) DEFAULT '' COMMENT '标题',
  `host` varchar(255) DEFAULT '' COMMENT '主机',
  `port` int(11) DEFAULT 3306 COMMENT '端口',
  `database` varchar(255) DEFAULT '' COMMENT '数据库名称',
  `username` varchar(30) DEFAULT '' COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `type` tinyint(4) DEFAULT 1 COMMENT '数据库类型 1.mysql',
  `version` int(11) DEFAULT 0 COMMENT '乐观锁',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='数据库配置';

-- ----------------------------
-- Records of xc_config
-- ----------------------------
INSERT INTO `xc_config` VALUES ('9', '6', '薛超', 'com.github.chaojunzi', 'test-127.0.0.1', '127.0.0.1', '3306', 'test', 'root', '123456', '1', '0', '2019-08-05 13:25:11');

-- ----------------------------
-- Table structure for xc_group
-- ----------------------------
DROP TABLE IF EXISTS `xc_group`;
CREATE TABLE `xc_group` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT '' COMMENT '分组名称',
  `version` int(11) DEFAULT 0 COMMENT '乐观锁',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='分组配置';

-- ----------------------------
-- Records of xc_group
-- ----------------------------
INSERT INTO `xc_group` VALUES ('6', '超君子', '0', '2019-07-24 10:42:31');

-- ----------------------------
-- Table structure for xc_user
-- ----------------------------
DROP TABLE IF EXISTS `xc_user`;
CREATE TABLE `xc_user` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) DEFAULT '' COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(30) DEFAULT '' COMMENT '昵称',
  `head_img` varchar(150) DEFAULT '' COMMENT '头像',
  `status` int(11) DEFAULT 1 COMMENT '状态 0.冻结 1.正常',
  `deleted` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除1已删除）',
  `version` int(11) DEFAULT 0 COMMENT '乐观锁',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户帐号';

-- ----------------------------
-- Records of xc_user
-- ----------------------------
INSERT INTO `xc_user` VALUES ('1', 'xuechao', '1', '薛超', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoSLMMV0Gic9Zy3Nk56dZfkdm9DB5vWYQyucYOon0BG1vfVaz2d8kcsnetwM2eVzXgTJsvN2Pq45Fg/132', '1', '0', '0', '2019-06-26 16:48:21');
INSERT INTO `xc_user` VALUES ('5', 'chaojunzi', '1', '超君子', 'http://img5.imgtn.bdimg.com/it/u=3938581769,4080993088&fm=26&gp=0.jpg', '0', '0', '0', '2019-07-25 12:13:37');
