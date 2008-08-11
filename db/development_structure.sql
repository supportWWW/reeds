CREATE TABLE `accessories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `price_in_cents` int(11) default NULL,
  `new_vehicle_id` int(11) NOT NULL,
  `model_reference` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `assignments` (
  `id` int(11) NOT NULL auto_increment,
  `branch_id` int(11) default NULL,
  `salesperson_id` int(11) default NULL,
  `enabled` tinyint(1) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_assignments_on_salesperson_id` (`salesperson_id`),
  KEY `index_assignments_on_branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `filename` varchar(255) default NULL,
  `content_type` varchar(255) default NULL,
  `owner_id` int(11) default NULL,
  `owner_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_attachments_on_owner_id` (`owner_id`),
  KEY `index_attachments_on_owner_type` (`owner_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `branches` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `classifieds` (
  `id` int(11) NOT NULL auto_increment,
  `stock_code` varchar(255) default NULL,
  `stock_type` int(11) default NULL,
  `model_variant_id` int(11) default NULL,
  `year` int(11) default NULL,
  `price_in_cents` int(11) default NULL,
  `colour` varchar(255) default NULL,
  `reg_num` varchar(255) default NULL,
  `mileage` int(11) default NULL,
  `features` text,
  `img_url` varchar(255) default NULL,
  `best_buy` tinyint(1) default NULL,
  `days_in_stock` int(11) default NULL,
  `removed_at` datetime default NULL,
  `has_service_history` tinyint(1) default NULL,
  `cyberstock` tinyint(1) default NULL,
  `expires_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_classifieds_on_stock_code` (`stock_code`),
  KEY `index_classifieds_on_model_variant_id` (`model_variant_id`),
  KEY `index_classifieds_on_price_in_cents` (`price_in_cents`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;

CREATE TABLE `images` (
  `id` int(11) NOT NULL auto_increment,
  `filename` varchar(255) default NULL,
  `content_type` varchar(255) default NULL,
  `size` int(11) default NULL,
  `width` int(11) default NULL,
  `height` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `owner_id` int(11) default NULL,
  `owner_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) default NULL,
  `thumbnail` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_images_on_owner_id` (`owner_id`),
  KEY `index_images_on_owner_type` (`owner_type`),
  KEY `index_images_on_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `makes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `common_name` varchar(255) default NULL,
  `website` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_makes_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `page_id` int(11) default NULL,
  `path` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `position` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `depth` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_menu_items_on_page_id` (`page_id`),
  KEY `index_menu_items_on_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `model_ranges` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `make_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `model_variants` (
  `id` int(11) NOT NULL auto_increment,
  `model_id` int(11) default NULL,
  `year` int(11) default NULL,
  `mead_mcgrouther_code` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_model_variants_on_model_id` (`model_id`),
  KEY `index_model_variants_on_year` (`year`),
  KEY `index_model_variants_on_mead_mcgrouther_code` (`mead_mcgrouther_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1165 DEFAULT CHARSET=utf8;

CREATE TABLE `models` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `common_name` varchar(255) default NULL,
  `make_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_models_on_make_id` (`make_id`),
  KEY `index_models_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8;

CREATE TABLE `new_vehicle_variants` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `price_in_cents` int(11) default NULL,
  `model_reference` varchar(255) default NULL,
  `new_vehicle_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `new_vehicles` (
  `id` int(11) NOT NULL auto_increment,
  `model_range_id` int(11) default NULL,
  `description` text,
  `year` int(11) default NULL,
  `enabled` tinyint(1) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `news_articles` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `author` varchar(255) default NULL,
  `source_url` varchar(255) default NULL,
  `title_permalink` varchar(255) default NULL,
  `text` text,
  `rendered_text` text,
  `publish_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `category_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_news_articles_on_title_permalink` (`title_permalink`),
  KEY `index_news_articles_on_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `title_permalink` varchar(255) default NULL,
  `text` text,
  `rendered_text` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_pages_on_title_permalink` (`title_permalink`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `referrals` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `source` varchar(255) default NULL,
  `description` text,
  `visits_count` int(11) default '0',
  `redirect_to` varchar(255) default '/',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `salespeople` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) default NULL,
  `name` varchar(100) default '',
  `email` varchar(100) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `is_admin` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`),
  UNIQUE KEY `index_users_on_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `visits` (
  `id` int(11) NOT NULL auto_increment,
  `referral_id` int(11) default NULL,
  `referer` varchar(255) default NULL,
  `remote_ip` varchar(255) default NULL,
  `user_agent` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `referer_host` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_visits_on_referral_id` (`referral_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20080604024949');

INSERT INTO schema_migrations (version) VALUES ('20080604040527');

INSERT INTO schema_migrations (version) VALUES ('20080604130146');

INSERT INTO schema_migrations (version) VALUES ('20080604170419');

INSERT INTO schema_migrations (version) VALUES ('20080604195242');

INSERT INTO schema_migrations (version) VALUES ('20080605020537');

INSERT INTO schema_migrations (version) VALUES ('20080605205428');

INSERT INTO schema_migrations (version) VALUES ('20080605205832');

INSERT INTO schema_migrations (version) VALUES ('20080606021003');

INSERT INTO schema_migrations (version) VALUES ('20080606024632');

INSERT INTO schema_migrations (version) VALUES ('20080606124326');

INSERT INTO schema_migrations (version) VALUES ('20080606200946');

INSERT INTO schema_migrations (version) VALUES ('20080606201507');

INSERT INTO schema_migrations (version) VALUES ('20080606224121');

INSERT INTO schema_migrations (version) VALUES ('20080607032939');

INSERT INTO schema_migrations (version) VALUES ('20080607034217');

INSERT INTO schema_migrations (version) VALUES ('20080614152902');

INSERT INTO schema_migrations (version) VALUES ('20080614154225');

INSERT INTO schema_migrations (version) VALUES ('20080614154418');

INSERT INTO schema_migrations (version) VALUES ('20080615044433');

INSERT INTO schema_migrations (version) VALUES ('20080616034717');

INSERT INTO schema_migrations (version) VALUES ('20080708133913');

INSERT INTO schema_migrations (version) VALUES ('20080708135619');

INSERT INTO schema_migrations (version) VALUES ('20080708164703');

INSERT INTO schema_migrations (version) VALUES ('20080708170348');

INSERT INTO schema_migrations (version) VALUES ('20080711122620');