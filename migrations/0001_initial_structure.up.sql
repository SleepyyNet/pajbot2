CREATE TABLE `pb_channel` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`channel` VARCHAR(64) NOT NULL COMMENT 'i.e. forsenlol',
	`nickname` VARCHAR(64) NULL DEFAULT NULL COMMENT 'i.e. Forsen',
	`twitch_channel_id` BIGINT(20) NULL DEFAULT NULL COMMENT 'i.e. 12345678',
	`twitch_access_token` VARCHAR(64) NULL DEFAULT NULL,
	`twitch_refresh_token` VARCHAR(64) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `channel` (`channel`)
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `pb_command` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`channel_id` INT(10) UNSIGNED NOT NULL,
	`triggers` VARCHAR(512) NOT NULL COMMENT 'Each trigger is divided by a pipe character "|". No !\'s allowed in command names. Example: testman|testman1|anotheralias',
	`response` VARCHAR(1024) NOT NULL,
	`response_type` ENUM('say','whisper','reply') NOT NULL DEFAULT 'say',
	`level` INT(11) NOT NULL DEFAULT '100' COMMENT 'User level required to use the command',
	`cooldown_all` INT(11) NOT NULL DEFAULT '4',
	`cooldown_user` INT(11) NOT NULL DEFAULT '10',
	`enabled` ENUM('yes','no','online_only','offline_only') NOT NULL DEFAULT 'yes',
	`cost_points` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`filters` SET('banphrases','linkchecker') NOT NULL DEFAULT '',
	PRIMARY KEY (`id`),
	INDEX `channel_id` (`channel_id`),
	CONSTRAINT `FK_pb_command_pb_channel` FOREIGN KEY (`channel_id`) REFERENCES `pb_channel` (`id`)
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
