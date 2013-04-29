ALTER TABLE users add column `name` varchar(255) DEFAULT NULL after `email`;
ALTER TABLE users add column `first_name` varchar(255) DEFAULT NULL after `name`;
ALTER TABLE users add column `last_name` varchar(255) DEFAULT NULL after `first_name`;
ALTER TABLE users add column `gender` varchar(255) DEFAULT NULL after `last_name`;
ALTER TABLE users add column `birthday` varchar(255) DEFAULT NULL after `gender`;
