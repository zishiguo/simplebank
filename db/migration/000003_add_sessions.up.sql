CREATE TABLE `sessions`
(
    `id`            CHAR(36)     NOT NULL PRIMARY KEY,
    `username`      VARCHAR(30)  NOT NULL,
    `refresh_token` VARCHAR(500) NOT NULL,
    `user_agent`    VARCHAR(100) NOT NULL,
    `client_ip`     VARCHAR(15)  NOT NULL,
    `is_blocked`    bool         not null default false,
    `expires_at`    DATETIME     NOT NULL,
    `created_at`    DATETIME     NOT NULL DEFAULT current_timestamp,
    UNIQUE INDEX `ux_username` (`username`)
);
