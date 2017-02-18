CREATE TABLE ACL_CLASS (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  CLASS              VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE ACL_ENTRY (
  ID                  BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE  TIMESTAMP NOT NULL,
  VERSION             BIGINT    NOT NULL,
  ACE_ORDER           INTEGER   NOT NULL,
  AUDIT_FAILURE       BOOLEAN   NOT NULL,
  AUDIT_SUCCESS       BOOLEAN   NOT NULL,
  GRANTING            BOOLEAN   NOT NULL,
  MASK                INTEGER   NOT NULL,
  ACL_OBJECT_IDENTITY BIGINT    NOT NULL,
  SID                 BIGINT    NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE ACL_OBJECT_IDENTITY (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP NOT NULL,
  VERSION            BIGINT    NOT NULL,
  ENTRIES_INHERITING BOOLEAN   NOT NULL,
  OBJECT_ID_IDENTITY BIGINT    NOT NULL,
  OBJECT_ID_CLASS    BIGINT    NOT NULL,
  OWNER_SID          BIGINT    NOT NULL,
  PARENT_OBJECT      BIGINT,
  PRIMARY KEY (ID)
);

CREATE TABLE ACL_SID (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  PRINCIPAL          BOOLEAN      NOT NULL,
  SID                VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE AUTHORITY (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE CUSTOMER (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 40000 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  CITY               VARCHAR(255) NOT NULL,
  COMPANY_NAME       VARCHAR(255) NOT NULL,
  COUNTRY            VARCHAR(255) NOT NULL,
  POSTCODE           VARCHAR(255) NOT NULL,
  STREET             VARCHAR(255) NOT NULL,
  STREET2            VARCHAR(255) NOT NULL,
  VATID              DOUBLE,
  PARENT_ID          BIGINT,
  PRIMARY KEY (ID)
);

CREATE TABLE CUSTOMER_CONTACT (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  EMAIL_ADDRESS      VARCHAR(255) NOT NULL,
  FAX                VARCHAR(255) NOT NULL,
  FIRST_NAME         VARCHAR(255) NOT NULL,
  MOBILE_PHONE       VARCHAR(255) NOT NULL,
  PHONE              VARCHAR(255) NOT NULL,
  SALUTATION         VARCHAR(255) NOT NULL,
  SURNAME            VARCHAR(255) NOT NULL,
  TYPE               VARCHAR(255) NOT NULL,
  CUSTOMER_ID        BIGINT       NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE CUSTOMER_USER_ACCOUNT (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  ACTIVE             BOOLEAN      NOT NULL,
  BLOCKED            BOOLEAN      NOT NULL,
  CREATED            TIMESTAMP    NOT NULL,
  EMAIL              VARCHAR(255) NOT NULL,
  FIRST_NAME         VARCHAR(255) NOT NULL,
  PASSWORD           VARCHAR(255) NOT NULL,
  SALT               VARCHAR(255),
  SURNAME            VARCHAR(255) NOT NULL,
  USERNAME           VARCHAR(255) NOT NULL,
  SALUTATION         VARCHAR(255) NOT NULL,
  CUSTOMER_ID        BIGINT       NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE DASHBOARD (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  ICON               VARCHAR(255) NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  USER_ACCOUNT_ID    BIGINT       NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE DASHBOARD_BOX (
  ID                    BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE    TIMESTAMP    NOT NULL,
  VERSION               BIGINT       NOT NULL,
  DESCRIPTION           VARCHAR(255) NOT NULL,
  HEIGHT                VARCHAR(255) NOT NULL,
  NAME                  VARCHAR(255) NOT NULL,
  ORDER_NUMBER          INTEGER      NOT NULL,
  WIDTH                 VARCHAR(255) NOT NULL,
  DASHBOARD_ID          BIGINT       NOT NULL,
  DASHBOARD_BOX_TYPE_ID BIGINT       NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE DASHBOARD_BOX_TYPE (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  KIND               VARCHAR(255) NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  TYPE               VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE ROLE (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE USER_ACCOUNT (
  ID                 BIGINT GENERATED BY DEFAULT AS IDENTITY (
  START WITH 1 ),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            BIGINT       NOT NULL,
  ACTIVE             BOOLEAN      NOT NULL,
  BLOCKED            BOOLEAN      NOT NULL,
  CREATED            TIMESTAMP    NOT NULL,
  EMAIL              VARCHAR(255) NOT NULL,
  FIRST_NAME         VARCHAR(255) NOT NULL,
  PASSWORD           VARCHAR(255) NOT NULL,
  SALT               VARCHAR(255),
  SURNAME            VARCHAR(255) NOT NULL,
  USERNAME           VARCHAR(255) NOT NULL,
  SALUTATION         VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE USER_AUTHORITY (
  USER_ID      BIGINT NOT NULL,
  AUTHORITY_ID BIGINT NOT NULL,
  PRIMARY KEY (AUTHORITY_ID, USER_ID)
);

CREATE TABLE USER_ROLE (
  ROLE_ID BIGINT NOT NULL,
  USER_ID BIGINT NOT NULL,
  PRIMARY KEY (ROLE_ID, USER_ID)
);

ALTER TABLE ACL_CLASS
  ADD CONSTRAINT UK_b9jm6yrofuhriaet5qlvaa2sb UNIQUE (CLASS);

ALTER TABLE ACL_ENTRY
  ADD CONSTRAINT acl_identity_order_idx UNIQUE (ACL_OBJECT_IDENTITY, ACE_ORDER);

ALTER TABLE ACL_ENTRY
  ADD CONSTRAINT UK_2udy4xgijqxsi2enlqmp1ryoi UNIQUE (ACE_ORDER);

ALTER TABLE ACL_ENTRY
  ADD CONSTRAINT UK_4rfb2hf1mgefbvivqlb3uhc1o UNIQUE (ACL_OBJECT_IDENTITY);

ALTER TABLE ACL_OBJECT_IDENTITY
  ADD CONSTRAINT acl_class_identity_idx UNIQUE (OBJECT_ID_CLASS, OBJECT_ID_IDENTITY);

ALTER TABLE ACL_OBJECT_IDENTITY
  ADD CONSTRAINT UK_sqoxny9iftavslu22wdw45s5j UNIQUE (OBJECT_ID_IDENTITY);

ALTER TABLE ACL_OBJECT_IDENTITY
  ADD CONSTRAINT UK_93h9hjf8xedn5xo7gagsy6fth UNIQUE (OBJECT_ID_CLASS);

ALTER TABLE ACL_SID
  ADD CONSTRAINT acl_sid_principal_idx UNIQUE (SID, PRINCIPAL);

ALTER TABLE ACL_SID
  ADD CONSTRAINT UK_iffjecpr10qe7c08yilqi4mi6 UNIQUE (SID);

ALTER TABLE AUTHORITY
  ADD CONSTRAINT UK_ana6i0racv9b9d5dx3mlwho9p UNIQUE (NAME);

ALTER TABLE CUSTOMER_CONTACT
  ADD CONSTRAINT UK_rt1h2souk5fkc2l0yojlch8ng UNIQUE (EMAIL_ADDRESS);

ALTER TABLE CUSTOMER_USER_ACCOUNT
  ADD CONSTRAINT UK_ocoo1ta18u6p16unw7h8b7i8h UNIQUE (USERNAME);

ALTER TABLE DASHBOARD
  ADD CONSTRAINT UK_k452w4cpbviagh85ll1q6gfc UNIQUE (NAME);

ALTER TABLE DASHBOARD_BOX_TYPE
  ADD CONSTRAINT UK_calopw9wexb9vek0fnkaotp2n UNIQUE (NAME);

ALTER TABLE ROLE
  ADD CONSTRAINT UK_lqaytvswxwacb7s84gcw7tk7l UNIQUE (NAME);

ALTER TABLE USER_ACCOUNT
  ADD CONSTRAINT UK_5b1ufubngfek527jhb11aure0 UNIQUE (USERNAME);

ALTER TABLE ACL_ENTRY
  ADD CONSTRAINT FK_4rfb2hf1mgefbvivqlb3uhc1o
FOREIGN KEY (ACL_OBJECT_IDENTITY)
REFERENCES ACL_OBJECT_IDENTITY;

ALTER TABLE ACL_ENTRY
  ADD CONSTRAINT FK_pwqqgnc867uhlp6ra8f6cu44d
FOREIGN KEY (SID)
REFERENCES ACL_SID;

ALTER TABLE ACL_OBJECT_IDENTITY
  ADD CONSTRAINT FK_93h9hjf8xedn5xo7gagsy6fth
FOREIGN KEY (OBJECT_ID_CLASS)
REFERENCES ACL_CLASS;

ALTER TABLE ACL_OBJECT_IDENTITY
  ADD CONSTRAINT FK_47mv8is8lo3t2rm4n7a9oatpy
FOREIGN KEY (OWNER_SID)
REFERENCES ACL_SID;

ALTER TABLE ACL_OBJECT_IDENTITY
  ADD CONSTRAINT FK_osevoaw0w5t99q4x25r4ohkm2
FOREIGN KEY (PARENT_OBJECT)
REFERENCES ACL_OBJECT_IDENTITY;

ALTER TABLE CUSTOMER
  ADD CONSTRAINT FK_k3k4147v3m5pjyjgfcrs0cdpj
FOREIGN KEY (PARENT_ID)
REFERENCES CUSTOMER;

ALTER TABLE CUSTOMER_CONTACT
  ADD CONSTRAINT FK_32q3wpxac3cbvhn1t9bxmcr81
FOREIGN KEY (CUSTOMER_ID)
REFERENCES CUSTOMER
  ON DELETE CASCADE;

ALTER TABLE CUSTOMER_USER_ACCOUNT
  ADD CONSTRAINT FK_jup37owwps8o8ntgoxdmn0th2
FOREIGN KEY (CUSTOMER_ID)
REFERENCES CUSTOMER
  ON DELETE CASCADE;

ALTER TABLE DASHBOARD
  ADD CONSTRAINT FK_agttn8ptawhkdx8qse4hnkvpr
FOREIGN KEY (USER_ACCOUNT_ID)
REFERENCES USER_ACCOUNT
  ON DELETE CASCADE;

ALTER TABLE DASHBOARD_BOX
  ADD CONSTRAINT FK_dgep5oi78i2irrmue308doxrp
FOREIGN KEY (DASHBOARD_ID)
REFERENCES DASHBOARD
  ON DELETE CASCADE;

ALTER TABLE DASHBOARD_BOX
  ADD CONSTRAINT FK_pdct77x9bvtflrsx224gkvhhs
FOREIGN KEY (DASHBOARD_BOX_TYPE_ID)
REFERENCES DASHBOARD_BOX_TYPE
  ON DELETE CASCADE;

ALTER TABLE USER_AUTHORITY
  ADD CONSTRAINT FK_dyo9anhb75hbjut13e8uovw2s
FOREIGN KEY (AUTHORITY_ID)
REFERENCES AUTHORITY;

ALTER TABLE USER_AUTHORITY
  ADD CONSTRAINT FK_jbm4yrlayhtksry4mwk0e47ls
FOREIGN KEY (USER_ID)
REFERENCES USER_ACCOUNT;

ALTER TABLE USER_ROLE
  ADD CONSTRAINT FK_oqmdk7xj0ainhxpvi79fkaq3y
FOREIGN KEY (ROLE_ID)
REFERENCES ROLE;

ALTER TABLE USER_ROLE
  ADD CONSTRAINT FK_j2j8kpywaghe8i36swcxv8784
FOREIGN KEY (USER_ID)
REFERENCES USER_ACCOUNT;
