CREATE TABLE `accounts` (
                            `id` bigint PRIMARY KEY AUTO_INCREMENT,
                            `owner` varchar(20) NOT NULL,
                            `balance` bigint NOT NULL,
                            `currency` varchar(20) NOT NULL,
                            `created_at` datetime default current_timestamp
);

CREATE TABLE `entries` (
                           `id` bigint PRIMARY KEY AUTO_INCREMENT,
                           `account_id` bigint not null,
                           `amount` bigint NOT NULL,
                           `created_at` datetime default current_timestamp
);

CREATE TABLE `transfers` (
                             `id` bigint PRIMARY KEY AUTO_INCREMENT,
                             `from_account_id` bigint not null,
                             `to_account_id` bigint not null,
                             `amount` bigint unsigned NOT NULL,
                             `created_at` datetime default current_timestamp
);

CREATE INDEX `accounts_index_0` ON `accounts` (`owner`);

CREATE INDEX `entries_index_1` ON `entries` (`account_id`);

CREATE INDEX `transfers_index_3` ON `transfers` (`from_account_id`, `to_account_id`);

# ALTER TABLE `entries` ADD FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);
#
# ALTER TABLE `transfers` ADD FOREIGN KEY (`from_account_id`) REFERENCES `accounts` (`id`);
#
# ALTER TABLE `transfers` ADD FOREIGN KEY (`to_account_id`) REFERENCES `accounts` (`id`);
