CREATE TABLE `accounts`
(
    `id`         BIGINT PRIMARY KEY AUTO_INCREMENT,
    `owner`      VARCHAR(20) NOT NULL,
    `balance`    BIGINT      NOT NULL,
    `currency`   VARCHAR(20) NOT NULL,
    `created_at` DATETIME    NOT NULL DEFAULT current_timestamp,
    INDEX `ix_account_owner` (`owner`)
);

CREATE TABLE `entries`
(
    `id`         BIGINT PRIMARY KEY AUTO_INCREMENT,
    `account_id` BIGINT   NOT NULL,
    `amount`     BIGINT   NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT current_timestamp,
    INDEX `ix_entries_account_id` (`account_id`)
);

CREATE TABLE `transfers`
(
    `id`              BIGINT PRIMARY KEY AUTO_INCREMENT,
    `from_account_id` BIGINT          NOT NULL,
    `to_account_id`   BIGINT          NOT NULL,
    `amount`          BIGINT UNSIGNED NOT NULL,
    `created_at`      DATETIME        NOT NULL DEFAULT current_timestamp,
    INDEX `ix_transfers_from_account_id_to_account_id` (`from_account_id`, `to_account_id`)
);
