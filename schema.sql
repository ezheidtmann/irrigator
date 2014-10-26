
CREATE TABLE `ghcnd_stations` (
  `id` char(11) COLLATE utf8_unicode_ci NOT NULL,
  `lat` float DEFAULT NULL COMMENT 'degrees',
  `lng` float DEFAULT NULL COMMENT 'degrees',
  `elevation` int(11) DEFAULT NULL COMMENT 'altitude above sea level, in feet',
  `state` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hcnflag` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gsnflag` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wmoid` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loc` point DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loc` (`loc`(25))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
