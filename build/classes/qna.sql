DROP TABLE QNA
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_QNA;



CREATE TABLE QNA(
   SEQ NUMBER(8) PRIMARY KEY,
   NICKNAME VARCHAR2(50) NOT NULL, 
   REF NUMBER(8) NOT NULL, 
   STEP NUMBER(8) NOT NULL,
   TITLE VARCHAR2(300) NOT NULL, 
   CONTENT VARCHAR2(5000) NOT NULL, 
   WDATE DATE NOT NULL, 
   DEL NUMBER(1) NOT NULL, 
   WAIT NUMBER(1) NOT NULL,
   READCOUNT NUMBER(8) NOT NULL,
   NOTICE NUMBER(1) NOT NULL,
   DELBY NUMBER(1),
   PWD VARCHAR2(50) 
   );

   
   
   
   
   
ALTER TABLE QNA 
ADD CONSTRAINT FK_QNA_NN FOREIGN KEY(NICKNAME)
REFERENCES MEMBER(NICKNAME);

CREATE SEQUENCE SEQ_QNA
START WITH 1
INCREMENT BY 1;