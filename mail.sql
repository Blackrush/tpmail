DROP TABLE IF EXISTS
  `virtual_users`,
  `virtual_aliases`,
  `virtual_domains`
CASCADE;

CREATE TABLE `virtual_domains` (
  `id`  INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domain_id` INT NOT NULL,
  `password` VARCHAR(106) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_aliases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domain_id` INT NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `virtual_domains`
       (`id`, `name`)
VALUES ('1', 'company.lan'),
       ('2', 'societe.local');

INSERT INTO `virtual_users`
       (`id`, `domain_id`, `password` , `email`)
VALUES ('1', '1', ENCRYPT('HelloWorld1234', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'contact@company.lan'),
       ('2', '1', ENCRYPT('Bonjour1234', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'antoine@societe.local');

INSERT INTO `virtual_aliases`
       (`id`, `domain_id`, `source`, `destination`)
VALUES ('1', '1', 'ceo@company.lan', 'antoine@societe.local');
