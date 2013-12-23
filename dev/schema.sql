CREATE TABLE IF NOT EXISTS t_domain (
  id UNSIGNED INTEGER
    PRIMARY KEY
    NOT NULL
    UNIQUE
    ON CONFLICT IGNORE,
  name VARCHAR(255) NOT NULL,
  stat UNSIGNED TINYINT
);

CREATE TABLE IF NOT EXISTS t_ip (
  id UNSIGNED INTEGER
    PRIMARY KEY
    NOT NULL
    UNIQUE
    ON CONFLICT IGNORE,
  ip VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS t_domain_ip (
  domain_id UNSIGNED INTEGER
    NOT NULL,
  ip_id UNSIGNED INTEGER
    NOT NULL,
  combination_id UNSIGNED INTEGER
    NOT NULL,
  FOREIGN KEY (domain_id) REFERENCES t_domain(id),
  FOREIGN KEY (ip_id) REFERENCES t_ip(id),
  PRIMARY KEY (domain_id, ip_id)
    ON CONFLICT IGNORE
);
  
CREATE TABLE IF NOT EXISTS t_pingTest (
  ip_id UNSIGNED INTEGER
    PRIMARY KEY
    NOT NULL
    UNIQUE
    ON CONFLICT IGNORE,
  min_delay FLOAT,
  max_delay FLOAT,
  avg_delay FLOAT,
  ratio FLOAT,
  test_count UNSIGNED TINYINT,
  FOREIGN KEY (ip_id) REFERENCES t_ip(id)
);

CREATE TABLE IF NOT EXISTS t_httpTest (
  http_id UNSIGNED INTEGER
    NOT NULL,
  ssl_flag UNSIGNED TINYINT
    NOT NULL,
  min_delay FLOAT,
  max_delay FLOAT,
  avg_delay FLOAT,
  ratio FLOAT,
  status VARCHAR(40),
  test_count UNSIGNED TINYINT,
  FOREIGN KEY (http_id) REFERENCES t_domain_ip(combination_id),
  PRIMARY KEY (http_id, ssl_flag)
    ON CONFLICT IGNORE
);