CREATE TABLE PEMASOK 
(id_pemasok NUMBER (11), 
nama VARCHAR2 (30),
alamat VARCHAR2(30),
no_telp VARCHAR2 (15), 
PRIMARY KEY(id_pemasok));

CREATE TABLE PEMBELIAN 
(no_nota NUMBER (11), 
tanggal DATE,
id_pemasok NUMBER(11), 
PRIMARY KEY(no_nota));

ALTER TABLE PEMBELIAN ADD FOREIGN KEY (id_pemasok ) REFERENCES PEMASOK (id_pemasok);

CREATE TABLE DET_PEMBELIAN(
id_sepatu NUMBER(11),
no_nota NUMBER(11),
jumlah NUMBER(10),
harga NUMBER(10),
PRIMARY KEY (id_sepatu));

ALTER TABLE DET_PEMBELIAN ADD FOREIGN KEY (no_nota) REFERENCES PEMBELIAN (no_nota);

CREATE TABLE BARANG(
id_sepatu NUMBER(11),
merk_sepatu VARCHAR2(20),
jenis_sepatu VARCHAR2(30),
no_sepatu NUMBER(2),
stok NUMBER(3),
id_pemasok NUMBER(11),
PRIMARY KEY (id_sepatu));

ALTER TABLE BARANG ADD FOREIGN KEY (id_pemasok) REFERENCES PEMASOK (id_pemasok);

CREATE TABLE DET_PENJUALAN (
no_nota NUMBER(11),
id_sepatu NUMBER(11),
jumlah NUMBER(10),
harga NUMBER(10));

ALTER TABLE DET_PENJUALAN ADD FOREIGN KEY (id_sepatu) REFERENCES BARANG (id_sepatu);

CREATE TABLE PENJUALAN (
no_nota NUMBER(11),
id_pelanggan NUMBER(11),
tgl_nota DATE,
PRIMARY KEY(no_nota));

ALTER TABLE DET_PENJUALAN ADD FOREIGN KEY (no_nota) REFERENCES PENJUALAN (no_nota);

CREATE TABLE PELANGGAN(
id_pelanggan NUMBER(11),
nama VARCHAR2(20),
alamat VARCHAR2(80),
no_telp VARCHAR2(15),
PRIMARY KEY(id_pelanggan));

INSERT INTO PEMASOK VALUES (1, 'RANGGA', 'Jl.Cendrawasih', '08332423444');
INSERT INTO PEMASOK VALUES (2, 'RATNA', 'Jl.Merpati', '089765435632');
INSERT INTO PEMASOK VALUES (3, 'AYU', 'Jl.Jalak Bali', '089321238333');
INSERT INTO PEMASOK VALUES (4, 'BAYU', 'Jl.Bangau', '089283928332');

INSERT INTO PEMBELIAN VALUES (101, TO_DATE('2018-05-01', 'yyyy-mm-dd'), 1);
INSERT INTO PEMBELIAN VALUES (102, TO_DATE('2018-05-01', 'yyyy-mm-dd'), 2);
INSERT INTO PEMBELIAN VALUES (103, TO_DATE('2018-05-01', 'yyyy-mm-dd'), 3);
INSERT INTO PEMBELIAN VALUES (104, TO_DATE('2018-05-02', 'yyyy-mm-dd'), 4);

INSERT INTO DET_PEMBELIAN VALUES (501, 101, 5, 150000);
INSERT INTO DET_PEMBELIAN VALUES (502, 102, 7, 120000);
INSERT INTO DET_PEMBELIAN VALUES (503, 103, 6, 200000);
INSERT INTO DET_PEMBELIAN VALUES (504, 104, 8, 125000);

INSERT INTO BARANG VALUES (501, 'Adidas', 'Sport Pria', 40, 15, 1);
INSERT INTO BARANG VALUES (502, 'Yongki', 'Kasual Pria', 43, 13, 2);
INSERT INTO BARANG VALUES (503, 'Yongki', 'Kasual Wanita', 38, 14, 3);
INSERT INTO BARANG VALUES (504, 'Cat', 'Boot Pria', 42, 19, 4);

INSERT INTO PELANGGAN VALUES (111, 'Fatmawati', 'Jl. Kambuna', '08156465672');
INSERT INTO PELANGGAN VALUES (112, 'Turiman', 'Jl. Ahmad Yani', '08776756667');
INSERT INTO PELANGGAN VALUES (113, 'Mae Murni', 'Jl. Pulo Sirih', '08234777839');
INSERT INTO PELANGGAN VALUES (114, 'Nina Nurvita Lubis', 'Jl. Dwieranti', '085444545677');
INSERT INTO PELANGGAN VALUES (115, 'Siti Aisyah', 'Jl. Mawar', '08122389899');

INSERT INTO PENJUALAN VALUES (101, 111, TO_DATE('2018-05-01', 'yyyy-mm-dd'));
INSERT INTO PENJUALAN VALUES (102, 112, TO_DATE('2018-05-01', 'yyyy-mm-dd'));
INSERT INTO PENJUALAN VALUES (103, 113, TO_DATE('2018-05-01', 'yyyy-mm-dd'));
INSERT INTO PENJUALAN VALUES (104, 114, TO_DATE('2018-05-01', 'yyyy-mm-dd'));
INSERT INTO PENJUALAN VALUES (105, 115, TO_DATE('2018-05-02', 'yyyy-mm-dd'));


INSERT INTO DET_PENJUALAN VALUES (101, 101, 5, 150000);
INSERT INTO DET_PENJUALAN VALUES (102, 102, 7, 120000);
INSERT INTO DET_PENJUALAN VALUES (103, 103, 6, 200000);
INSERT INTO DET_PENJUALAN VALUES (104, 104, 8, 125000);
INSERT INTO DET_PENJUALAN VALUES (105, 105, 7, 175000);

--iF ELSE THEN 
--IF ELSE jumlah barang kalau kurang dari sama dengan 5 HARGA NORMAL, kalo 6 DISKON 10%, kalo lebih dari 6 DISKON 20%

DECLARE
    jumlah NUMBER := 6;
BEGIN
    IF jumlah <= 5 THEN
        DBMS_OUTPUT.PUT_LINE('HARGA NORMAL');
    ELSIF jumlah = 6 THEN
        DBMS_OUTPUT.PUT_LINE('DISKON 10%');
    ELSE
        DBMS_OUTPUT.PUT_LINE('DISKON 20%');
    END IF;
END;

--EXCEPTION HANDLING ERROR 

DECLARE
         v_merk_sepatu VARCHAR2(15);
BEGIN
         SELECT merk_sepatu INTO v_merk_sepatu
         FROM BARANG WHERE merk_sepatu = 'Yongki'; --parameter
      DBMS_OUTPUT.PUT_LINE('Merk sepatu '|| v_merk_sepatu || ' hanya ada 1');
EXCEPTION
   WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE ('Select statement found multiple rows');
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE ('Select statement found no rows');
   WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE ('Another type of error occurred');
END;

--Merk sepatu Cat hanya ada 1
--Kalau yang dimasukan Yongki Select statement found multiple rows


--EXPLICIT CURSOR INI UNTUK MENAMPILKAN NAMA , ALAMAT DAN MERK SEPATU DI TABEL PEMASOK DAN TABEL BARANG 

DECLARE
 CURSOR cur_pemasok_barang IS
    SELECT nama, alamat, merk_sepatu 
    FROM pemasok p, barang b
    WHERE p.id_pemasok = b.id_pemasok;
v_pemasok_barang_record cur_pemasok_barang%ROWTYPE;
BEGIN
OPEN cur_pemasok_barang;
LOOP
    FETCH cur_pemasok_barang INTO v_pemasok_barang_record;
EXIT WHEN cur_pemasok_barang%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(v_pemasok_barang_record.nama || ' – '|| v_pemasok_barang_record.alamat || ' – '|| v_pemasok_barang_record.merk_sepatu);
END LOOP;
CLOSE cur_pemasok_barang;
END;

--OUTPUT 
--RANGGA – Jl.Cendrawasih – Adidas
--RATNA – Jl.Merpati – Yongki
--AYU – Jl.Jalak Bali – Yongki
--BAYU – Jl.Bangau – Cat


--INI PROCEDURE UNTUK MENAMBAH STOK YANG INGIN DITAMBAH DI TABEL BARANG
CREATE OR REPLACE PROCEDURE tambah_stok
(p_stok IN BARANG.stok%TYPE, p_tambah IN NUMBER)
IS
BEGIN
UPDATE BARANG
SET stok = stok + p_tambah
WHERE stok = p_stok;
END tambah_stok;

--memanggil stok yang tersedia di tabel ditambah parameter(jumlah yang ingin ditambah)
BEGIN tambah_stok(15,10); 
END;


--PROCEDURE UNTUK MENAMBAHKAN BARIS DI PENJUALAN DENGAN ID_PELANGGAN 117 DAN NO_NOTA 107 DAN TANGGAL SEKARANG

CREATE OR REPLACE PROCEDURE add_penjualan IS
    v_id_pel penjualan.id_pelanggan%TYPE;
    v_nota penjualan.no_nota%TYPE;
BEGIN
    v_id_pel := 117;
    v_nota := 107;
INSERT INTO penjualan(no_nota, id_pelanggan , tgl_nota)
VALUES(v_nota, v_id_pel, SYSDATE);
DBMS_OUTPUT.PUT_LINE('Inserted '|| SQL%ROWCOUNT || ' row.');
END; 

--pemanggilan
BEGIN
     add_penjualan;
END;

--OUTPUT
--inserted 1 row

--FUNCTION UNTUK MENCARI NAMA PEMASOK BERDASARKAN ID_PEMASOK DI TABEL PEMASOK
CREATE OR REPLACE FUNCTION get_nama_pemasok
(p_id IN pemasok.id_pemasok%TYPE)
    RETURN VARCHAR2 IS
        v_nama pemasok.nama%TYPE := '';
BEGIN
       SELECT nama INTO v_nama FROM PEMASOK
       WHERE id_pemasok = p_id;
    RETURN v_nama;
EXCEPTION
       WHEN NO_DATA_FOUND THEN RETURN NULL;
END get_nama_pemasok;

	--MENCETAK NAMA DENGAN MEMANGGIL ID_PEMASOK     
	DECLARE v_nama PEMASOK.nama%type;
	BEGIN
	      v_nama := get_nama_pemasok(2); 
	     DBMS_OUTPUT.PUT_LINE(v_nama); 
	END;

--OUTPUT
--RATNA

--FUNCTION potongan harga pada tabel det_penjualan
CREATE OR REPLACE FUNCTION diskon(p_harga IN NUMBER)
    RETURN NUMBER IS
BEGIN
    RETURN (p_harga * 0.2);
END diskon;

--Menampilkan diskon pada kolom harga pada tabel det_penjualan 20%
SELECT no_nota ,id_sepatu , jumlah, diskon(harga)
FROM det_penjualan
WHERE no_nota = 105; 


/*TRIGGERS INI BERFUNGSI KALAU INSERT , DELETE , UPDATE 
DATA PADA TABEL PENJUALAN PADA HARI SABTU DAN MINGGU AKAN MUNCUL ERROR
*/
CREATE OR REPLACE TRIGGER secure_penjualan
BEFORE INSERT OR DELETE OR UPDATE ON PENJUALAN
BEGIN
   IF TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN') THEN
        IF DELETING THEN RAISE_APPLICATION_ERROR
              (-20501,'You may delete from PENJUALAN table only during business hours');
        ELSIF INSERTING THEN RAISE_APPLICATION_ERROR
              (-20502,'You may insert into PENJUALAN table only during business hours');
        ELSIF UPDATING THEN RAISE_APPLICATION_ERROR
              (-20503,'You may update PENJUALAN table only during business hours');
        END IF; 
   END IF;
END;

--PACKAGE 
CREATE OR REPLACE PACKAGE cust_harga AS 
   PROCEDURE find_harga(p_id DET_PENJUALAN.id_sepatu%type); 
END cust_harga; 
--package created

--PACKAGE BIASA HARUS DIBUAT UNTUK PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY cust_harga AS  
   PROCEDURE find_harga(p_id DET_PENJUALAN.id_sepatu%TYPE) IS 
   v_harga DET_PENJUALAN.harga%TYPE; 
   BEGIN 
      SELECT HARGA INTO v_harga 
      FROM DET_PENJUALAN
      WHERE id_sepatu = p_id; 
      DBMS_OUTPUT.PUT_LINE('HARGA: '|| v_harga); 
   END find_harga; 
END cust_harga;
--package body created.

--PANGGIL PACKAGE BODY UNTUK MENAMPILKAN HARGA YANG INGIN DIKETAHUI
DECLARE 
   code DET_PENJUALAN.id_sepatu%type := 101; 
BEGIN 
   cust_harga.find_harga(code); 
END; 

--OUTPUT :
--HARGA: 150000
--Statement processed. 

