/*================================================================================*/
/* DDL SCRIPT                                                                     */
/*================================================================================*/
/*  Title    : PhpPlaisio: Core Authority                                         */
/*  FileName : authority-core.ecm                                                 */
/*  Platform : MariaDB 10.x                                                       */
/*  Version  :                                                                    */
/*  Date     : Saturday, April 30, 2022                                           */
/*================================================================================*/
/*================================================================================*/
/* CREATE TABLES                                                                  */
/*================================================================================*/

CREATE TABLE `ABC_AUTH_FLAG` (
  `rfl_id` TINYINT AUTO_INCREMENT NOT NULL,
  `rfl_flag` INT NOT NULL,
  `rfl_name` VARCHAR(80) NOT NULL,
  `rfl_bitwise_function` VARCHAR(3) DEFAULT 'OR' NOT NULL,
  `rfl_label` VARCHAR(128) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  CONSTRAINT `PK_ABC_AUTH_FLAG` PRIMARY KEY (`rfl_id`)
);

/*
COMMENT ON COLUMN `ABC_AUTH_FLAG`.`rfl_id`
The ID of this flag.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FLAG`.`rfl_flag`
The value of this flag (only a single bit can be set, i.e. a power of 2).
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FLAG`.`rfl_name`
The description of this fag.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FLAG`.`rfl_bitwise_function`
The bitwise function for aggregating this flag.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FLAG`.`rfl_label`
The label (for constants) of this flag.
*/

CREATE TABLE `ABC_AUTH_MODULE` (
  `mdl_id` SMALLINT AUTO_INCREMENT NOT NULL,
  `wrd_id` SMALLINT NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`mdl_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_MODULE`
A module consists of multiple functionalities.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_MODULE`.`mdl_id`
The ID of the module.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_MODULE`.`wrd_id`
The name of the module.
*/

CREATE TABLE `ABC_AUTH_FUNCTIONALITY` (
  `fun_id` SMALLINT AUTO_INCREMENT NOT NULL,
  `mdl_id` SMALLINT NOT NULL,
  `wrd_id` SMALLINT NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`fun_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_FUNCTIONALITY`
A functionality grants access to multiple pages.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FUNCTIONALITY`.`fun_id`
The ID of the functionality.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FUNCTIONALITY`.`mdl_id`
The superseding module of the functionality.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_FUNCTIONALITY`.`wrd_id`
The name of the functionality.
*/

CREATE TABLE `ABC_AUTH_MODULE_COMPANY` (
  `cmp_id` SMALLINT NOT NULL,
  `mdl_id` SMALLINT NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`cmp_id`, `mdl_id`),
  CONSTRAINT `SECONDARY` UNIQUE (`mdl_id`, `cmp_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_MODULE_COMPANY`
The modules to which a company is granted access.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_MODULE_COMPANY`.`cmp_id`
The company.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_MODULE_COMPANY`.`mdl_id`
The module.
*/

CREATE TABLE `ABC_AUTH_PAG_FUN` (
  `pag_id` SMALLINT NOT NULL,
  `fun_id` SMALLINT NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`fun_id`, `pag_id`),
  CONSTRAINT `SECONDARY` UNIQUE (`pag_id`, `fun_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_PAG_FUN`
The pages to which a functionality grants access.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAG_FUN`.`pag_id`
The page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAG_FUN`.`fun_id`
The functionality.
*/

CREATE TABLE `ABC_AUTH_PRO_PAG` (
  `pag_id` SMALLINT NOT NULL,
  `pro_id` SMALLINT NOT NULL,
  CONSTRAINT `PK_ABC_AUTH_PRO_PAG` PRIMARY KEY (`pro_id`, `pag_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_PRO_PAG`
All the pages to which a profile grants access to.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PRO_PAG`.`pag_id`
The page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PRO_PAG`.`pro_id`
The profile.
*/

CREATE TABLE `ABC_AUTH_ROLE_GROUP` (
  `rlg_id` SMALLINT AUTO_INCREMENT NOT NULL,
  `wrd_id` SMALLINT NOT NULL,
  `rlg_weight` SMALLINT NOT NULL,
  `rlg_label` VARCHAR(50) CHARACTER SET ascii COLLATE ascii_general_ci,
  CONSTRAINT `PK_ABC_AUTH_ROLE_GROUP` PRIMARY KEY (`rlg_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_ROLE_GROUP`
A role group supersedes a role.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE_GROUP`.`rlg_id`
The ID of the role group.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE_GROUP`.`wrd_id`
The name of the role group.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE_GROUP`.`rlg_weight`
The weight of the role group for sorting.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE_GROUP`.`rlg_label`
The label (for constants) of the role group.
*/

CREATE TABLE `ABC_AUTH_ROLE` (
  `rol_id` SMALLINT AUTO_INCREMENT NOT NULL,
  `cmp_id` SMALLINT NOT NULL,
  `rlg_id` SMALLINT NOT NULL,
  `rol_weight` SMALLINT NOT NULL,
  `rol_name` VARCHAR(32) NOT NULL,
  `rol_label` VARCHAR(50) CHARACTER SET ascii COLLATE ascii_general_ci,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`rol_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_ROLE`
A role grants access to multiple functionalities.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE`.`rol_id`
The ID of the role.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE`.`cmp_id`
The company.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE`.`rlg_id`
The superseding role group.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE`.`rol_weight`
The weight of the role for sorting.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE`.`rol_name`
The name or description of the role.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROLE`.`rol_label`
The label (for constants) of the role.
*/

CREATE TABLE `ABC_AUTH_PRO_ROL` (
  `cmp_id` SMALLINT NOT NULL,
  `pro_id` SMALLINT NOT NULL,
  `rol_id` SMALLINT NOT NULL,
  CONSTRAINT `PK_ABC_AUTH_PRO_ROL` PRIMARY KEY (`pro_id`, `rol_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_PRO_ROL`
All roles of a profile.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PRO_ROL`.`cmp_id`
The company.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PRO_ROL`.`pro_id`
The profile.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PRO_ROL`.`rol_id`
The role.
*/

CREATE TABLE `ABC_AUTH_ROL_FLG` (
  `rfl_id` TINYINT NOT NULL,
  `rol_id` SMALLINT NOT NULL,
  CONSTRAINT `PK_ABC_AUTH_ROL_FLG` PRIMARY KEY (`rfl_id`, `rol_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_ROL_FLG`
The flags related to a role.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROL_FLG`.`rfl_id`
The flag.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROL_FLG`.`rol_id`
The role.
*/

CREATE TABLE `ABC_AUTH_ROL_FUN` (
  `cmp_id` SMALLINT NOT NULL,
  `fun_id` SMALLINT NOT NULL,
  `rol_id` SMALLINT NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`rol_id`, `fun_id`),
  CONSTRAINT `SECONDARY` UNIQUE (`fun_id`, `rol_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_ROL_FUN`
The functionalities a role grants access to.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROL_FUN`.`cmp_id`
The company.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROL_FUN`.`fun_id`
The functionality.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_ROL_FUN`.`rol_id`
The role.
*/

CREATE TABLE `ABC_AUTH_USR_ROL` (
  `cmp_id` SMALLINT NOT NULL,
  `usr_id` INTEGER NOT NULL,
  `rol_id` SMALLINT NOT NULL,
  `aur_date_start` DATE NOT NULL,
  `aur_date_stop` DATE NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`usr_id`, `rol_id`),
  CONSTRAINT `SECONDARY_KEY` UNIQUE (`rol_id`, `usr_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_USR_ROL`
The granted roles to a user and the date intervals (including) to which the roles a granted.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_USR_ROL`.`cmp_id`
The company.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_USR_ROL`.`usr_id`
The user.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_USR_ROL`.`rol_id`
The role.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_USR_ROL`.`aur_date_start`
The first day the role is granted to the user.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_USR_ROL`.`aur_date_stop`
The last day the role is granted to the user.
*/

/*================================================================================*/
/* CREATE INDEXES                                                                 */
/*================================================================================*/

CREATE INDEX `IX_ABC_AUTH_MODULE1` ON `ABC_AUTH_MODULE` (`wrd_id`);

CREATE INDEX `IX_ABC_AUTH_FUNCTIONALITY1` ON `ABC_AUTH_FUNCTIONALITY` (`mdl_id`);

CREATE INDEX `IX_ABC_AUTH_FUNCTIONALITY2` ON `ABC_AUTH_FUNCTIONALITY` (`wrd_id`);

CREATE INDEX `IX_ABC_AUTH_MODULE_COMPANY1` ON `ABC_AUTH_MODULE_COMPANY` (`mdl_id`);

CREATE INDEX `IX_ABC_AUTH_MODULE_COMPANY2` ON `ABC_AUTH_MODULE_COMPANY` (`cmp_id`);

CREATE INDEX `IX_ABC_AUTH_PRO_PAG1` ON `ABC_AUTH_PRO_PAG` (`pag_id`, `pro_id`);

CREATE INDEX `IX_FK_ABC_AUTH_ROLE_GROUP1` ON `ABC_AUTH_ROLE_GROUP` (`wrd_id`);

CREATE INDEX `IX_FK_ABC_AUTH_ROLE` ON `ABC_AUTH_ROLE` (`rlg_id`);

CREATE INDEX `IX_FK_ABC_AUTH_ROLE1` ON `ABC_AUTH_ROLE` (`cmp_id`);

CREATE UNIQUE INDEX `IX_ABC_AUTH_PRO_ROL1` ON `ABC_AUTH_PRO_ROL` (`rol_id`, `pro_id`);

CREATE INDEX `IX_FK_ABC_AUTH_PRO_ROL1` ON `ABC_AUTH_PRO_ROL` (`cmp_id`);

CREATE UNIQUE INDEX `IX_ABC_AUTH_ROL_FLG1` ON `ABC_AUTH_ROL_FLG` (`rol_id`, `rfl_id`);

CREATE INDEX `IX_ABC_AUTH_ROL_FUN3` ON `ABC_AUTH_ROL_FUN` (`cmp_id`);

CREATE INDEX `IX_FK_ABC_AUTH_USR_ROL` ON `ABC_AUTH_USR_ROL` (`cmp_id`);

/*================================================================================*/
/* CREATE FOREIGN KEYS                                                            */
/*================================================================================*/

ALTER TABLE `ABC_AUTH_MODULE`
  ADD CONSTRAINT `FK_ABC_AUTH_MODULE_ABC_BABEL_WORD`
  FOREIGN KEY (`wrd_id`) REFERENCES `ABC_BABEL_WORD` (`wrd_id`);

ALTER TABLE `ABC_AUTH_FUNCTIONALITY`
  ADD CONSTRAINT `FK_ABC_AUTH_FUNCTIONALITY_ABC_BABEL_WORD`
  FOREIGN KEY (`wrd_id`) REFERENCES `ABC_BABEL_WORD` (`wrd_id`);

ALTER TABLE `ABC_AUTH_FUNCTIONALITY`
  ADD CONSTRAINT `FK_ABC_AUTH_FUNCTIONALITY_ABC_AUTH_MODULE`
  FOREIGN KEY (`mdl_id`) REFERENCES `ABC_AUTH_MODULE` (`mdl_id`);

ALTER TABLE `ABC_AUTH_MODULE_COMPANY`
  ADD CONSTRAINT `FK_ABC_AUTH_MODULE_COMPANY_ABC_AUTH_COMPANY`
  FOREIGN KEY (`cmp_id`) REFERENCES `ABC_AUTH_COMPANY` (`cmp_id`);

ALTER TABLE `ABC_AUTH_MODULE_COMPANY`
  ADD CONSTRAINT `FK_ABC_AUTH_MODULE_COMPANY_ABC_AUTH_MODULE`
  FOREIGN KEY (`mdl_id`) REFERENCES `ABC_AUTH_MODULE` (`mdl_id`);

ALTER TABLE `ABC_AUTH_PAG_FUN`
  ADD CONSTRAINT `FK_ABC_AUTH_PAG_FUN_ABC_AUTH_FUNCTIONALITY`
  FOREIGN KEY (`fun_id`) REFERENCES `ABC_AUTH_FUNCTIONALITY` (`fun_id`);

ALTER TABLE `ABC_AUTH_PAG_FUN`
  ADD CONSTRAINT `FK_ABC_AUTH_PAG_FUN_ABC_AUTH_PAGE`
  FOREIGN KEY (`pag_id`) REFERENCES `ABC_AUTH_PAGE` (`pag_id`);

ALTER TABLE `ABC_AUTH_PRO_PAG`
  ADD CONSTRAINT `FK_ABC_AUTH_PRO_PAG_ABC_AUTH_PAGE`
  FOREIGN KEY (`pag_id`) REFERENCES `ABC_AUTH_PAGE` (`pag_id`);

ALTER TABLE `ABC_AUTH_PRO_PAG`
  ADD CONSTRAINT `FK_ABC_AUTH_PRO_PAG_ABC_AUTH_PROFILE`
  FOREIGN KEY (`pro_id`) REFERENCES `ABC_AUTH_PROFILE` (`pro_id`)
  ON DELETE CASCADE;

ALTER TABLE `ABC_AUTH_ROLE_GROUP`
  ADD CONSTRAINT `FK_ABC_AUTH_ROLE_GROUP_ABC_BABEL_WORD`
  FOREIGN KEY (`wrd_id`) REFERENCES `ABC_BABEL_WORD` (`wrd_id`);

ALTER TABLE `ABC_AUTH_ROLE`
  ADD CONSTRAINT `FK_ABC_AUTH_ROLE_ABC_AUTH_COMPANY`
  FOREIGN KEY (`cmp_id`) REFERENCES `ABC_AUTH_COMPANY` (`cmp_id`);

ALTER TABLE `ABC_AUTH_ROLE`
  ADD CONSTRAINT `FK_ABC_AUTH_ROLE_ABC_AUTH_ROLE_GROUP`
  FOREIGN KEY (`rlg_id`) REFERENCES `ABC_AUTH_ROLE_GROUP` (`rlg_id`);

ALTER TABLE `ABC_AUTH_PRO_ROL`
  ADD CONSTRAINT `FK_ABC_AUTH_PRO_ROL_ABC_AUTH_COMPANY`
  FOREIGN KEY (`cmp_id`) REFERENCES `ABC_AUTH_COMPANY` (`cmp_id`);

ALTER TABLE `ABC_AUTH_PRO_ROL`
  ADD CONSTRAINT `FK_ABC_AUTH_PRO_ROL_ABC_AUTH_ROLE`
  FOREIGN KEY (`rol_id`) REFERENCES `ABC_AUTH_ROLE` (`rol_id`);

ALTER TABLE `ABC_AUTH_PRO_ROL`
  ADD CONSTRAINT `FK_ABC_AUTH_PRO_ROL_ABC_AUTH_PROFILE`
  FOREIGN KEY (`pro_id`) REFERENCES `ABC_AUTH_PROFILE` (`pro_id`)
  ON DELETE CASCADE;

ALTER TABLE `ABC_AUTH_ROL_FLG`
  ADD CONSTRAINT `FK_ABC_AUTH_ROL_FLG_ABC_AUTH_FLAG`
  FOREIGN KEY (`rfl_id`) REFERENCES `ABC_AUTH_FLAG` (`rfl_id`);

ALTER TABLE `ABC_AUTH_ROL_FLG`
  ADD CONSTRAINT `FK_ABC_AUTH_ROL_FLG_ABC_AUTH_ROLE`
  FOREIGN KEY (`rol_id`) REFERENCES `ABC_AUTH_ROLE` (`rol_id`);

ALTER TABLE `ABC_AUTH_ROL_FUN`
  ADD CONSTRAINT `FK_ABC_AUTH_ROL_FUN_ABC_AUTH_COMPANY`
  FOREIGN KEY (`cmp_id`) REFERENCES `ABC_AUTH_COMPANY` (`cmp_id`);

ALTER TABLE `ABC_AUTH_ROL_FUN`
  ADD CONSTRAINT `FK_ABC_AUTH_ROL_FUN_ABC_AUTH_FUNCTIONALITY`
  FOREIGN KEY (`fun_id`) REFERENCES `ABC_AUTH_FUNCTIONALITY` (`fun_id`);

ALTER TABLE `ABC_AUTH_ROL_FUN`
  ADD CONSTRAINT `FK_ABC_AUTH_ROL_FUN_ABC_AUTH_ROLE`
  FOREIGN KEY (`rol_id`) REFERENCES `ABC_AUTH_ROLE` (`rol_id`);

ALTER TABLE `ABC_AUTH_USR_ROL`
  ADD CONSTRAINT `FK_ABC_AUTH_USR_ROL_ABC_AUTH_COMPANY`
  FOREIGN KEY (`cmp_id`) REFERENCES `ABC_AUTH_COMPANY` (`cmp_id`);

ALTER TABLE `ABC_AUTH_USR_ROL`
  ADD CONSTRAINT `FK_ABC_AUTH_USR_ROL_ABC_AUTH_ROLE`
  FOREIGN KEY (`rol_id`) REFERENCES `ABC_AUTH_ROLE` (`rol_id`);

ALTER TABLE `ABC_AUTH_USR_ROL`
  ADD CONSTRAINT `FK_ABC_AUTH_USR_ROL_ABC_AUTH_USER`
  FOREIGN KEY (`usr_id`) REFERENCES `ABC_AUTH_USER` (`usr_id`);
