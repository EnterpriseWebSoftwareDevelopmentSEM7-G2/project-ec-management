SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS ecm_db;
CREATE DATABASE ecm_db;
USE ecm_db;

-- INIT USER AND AUTHORITY TABLE --
CREATE TABLE user (
  id            INTEGER      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username      VARCHAR(100) NOT NULL,
  password_hash VARCHAR(60)  NOT NULL,
  first_name    VARCHAR(50)  NOT NULL,
  last_name     VARCHAR(50)  NOT NULL,
  email         VARCHAR(100) NOT NULL,
  created_date  DATETIME     NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE authority (
  name         VARCHAR(50) NOT NULL PRIMARY KEY,
  created_date DATETIME    NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE user_authority (
  id            INTEGER      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id        INTEGER     NOT NULL,
  authority_name VARCHAR(50) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user (id),
  FOREIGN KEY (authority_name) REFERENCES authority (name)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

-- INIT CLAIM, COURSE, ASSESSMENT TABLE --
create table course(
    `code` varchar(50) not null,
    username varchar(100) not null,
    primary key (id)
)
    engine = InnoDB
    default character set = utf8;

create table assessment(
    crn varchar(50) not null,
    course_code varchar(50) not null,
    title varchar(100) not null,
    primary key(crn),
    foreign key (course_code) references course(code)
)
    engine = InnoDB
    default character set = utf8;

create table claim(
    id int not null auto_increment,
    user_id int,
    date_started datetime,
    date_ended datetime,
    primary key(id),
    foreign key (user_id) references `user`(id)
)
    engine = InnoDB
    default character set = utf8;

create table assessment_claim(
    claim_id int not null,
    assessment_crn varchar(50) not null,
    solution1 int,
    solution2 int,
    primary key(claim_id, assessment_crn),
    foreign key (claim_id) references claim(id),
    foreign key (assessment_crn) references assessment(crn)
)
    engine = InnoDB
    default character set = utf8;

create table claim_circumstances(
    claim_id int not null,
    circumstances_id int not null,
    primary key(claim_id, circumstances_id),
    foreign key (claim_id) references claim(id),
    foreign key (circumstances_id) references circumstances(id)
)
    engine = InnoDB
    default character set = utf8;


-- INSERT SAMPLE DATA FOR USER--

INSERT INTO authority (name, created_date) VALUES
  ('ROLE_USER', NOW()), ('ROLE_STUDENT', NOW()), ('ROLE_MANAGER', NOW()), ('ROLE_COORDINATOR', NOW()),
  ('ROLE_ADMIN', NOW());
INSERT INTO user (username, password_hash, first_name, last_name, email, created_date) VALUES
  ('user', '$2a$06$7oA08ApI.X1xU0H5zkmpbutG4Uawv9mMH2qFqzpqGqr3EUJvPnKtu', 'fuser', 'luser', 'user@gmail.com', NOW()),
  ('student', '$2a$06$FBK.uNoEF.5H1W2.pE3MB.rrr1JsNDuH3fZJr1RS0esFKzYWAn/3K', 'fstudent', 'lstudent',
   'student@gmail.com', NOW()),
  ('manager', '$2a$06$g5UumdjnCb5vRLy6FAice.mzSfkrU2ZPvGIh63t0nUzGnT9e/nZuu', 'fmanager', 'lmanager',
   'manager@gmail.com', NOW()),
  ('coordinator', '$2a$06$8iHCr9.rIYwzgkblpWoIiO7Bnu38QklQB6tleSlrwbLrvI5PEAojm', 'fcoordinator', 'lcoordinator',
   'coordinator@gmail.com', NOW()),
  ('admin', '$2a$06$P4rfOGUCvzL.2OzecFrar.oWmuIjozP5oogg3CT4GGw3oRBenbEVa', 'fadmin', 'ladmin', 'admin@gmail.com',
   NOW());
INSERT INTO user_authority (user_id, authority_name) VALUES
  (1, 'ROLE_USER'), (2, 'ROLE_STUDENT'), (3, 'ROLE_COORDINATOR'), (4, 'ROLE_ADMIN');

-- INSERT SAMPLE DATA FOR CLAIMS --





















SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;