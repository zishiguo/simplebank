CREATE TABLE `users`
(
    `username`            VARCHAR(30) PRIMARY KEY,
    `hashed_password`     CHAR(60) NOT NULL,
    `full_name`           VARCHAR(50) NOT NULL,
    `email`               VARCHAR(50) NOT NULL,
    `password_changed_at` DATETIME    NOT NULL DEFAULT '1000-01-01 00:00:00',
    `created_at`          DATETIME    NOT NULL DEFAULT current_timestamp,
    UNIQUE INDEX `ux_users_email` (`email`)
);

ALTER TABLE `accounts`
    ADD UNIQUE INDEX `ux_accounts_owner_currency` (`owner`, `currency`);
