CREATE TABLE `assignments` (
  `id` int(11) NOT NULL auto_increment,
  `branch_id` int(11) default NULL,
  `salesperson_id` int(11) default NULL,
  `enabled` tinyint(1) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `filename` varchar(255) default NULL,
  `content_type` varchar(255) default NULL,
  `owner_id` int(11) default NULL,
  `owner_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `page_id` int(11) default NULL,
  `path` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `position` int(11) default NULL,
  `depth` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
  UNIQUE KEY `index_news_articles_on_title_permalink` (`title_permalink`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `title_permalink` varchar(255) default NULL,
  `text` text,
  `rendered_text` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `salespeople` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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