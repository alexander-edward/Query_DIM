CREATE DATABASE PTMEGAHITASEJAHTERA;
USE PTMEGAHITASEJAHTERA;

CREATE TABLE Pelanggan(
	IDPelanggan CHAR(8) PRIMARY KEY NOT NULL CHECK(IDPelanggan LIKE 'MHSPL[0-9][0-9][0-9]'),
	NamaPelanggan VARCHAR(100) NOT NULL,
	NomorHPPelanggan VARCHAR(20) NOT NULL,
	AlamatPelanggan VARCHAR(255) NOT NULL,
	EmailPelanggan VARCHAR(100) NOT NULL,
	TanggalInput DATE NOT NULL,
	TanggalPembaruanTerakhir DATETIME NOT NULL
);

CREATE TABLE Karyawan (
	IDKaryawan CHAR(7) PRIMARY KEY NOT NULL CHECK(IDKaryawan LIKE 'MHSK[0-9][0-9][0-9]'),
	NamaKaryawan VARCHAR(50) NOT NULL,
	PosisiKaryawan VARCHAR(30) NOT NULL,
	TanggalBergabung DATE NOT NULL,
	TanggalInput DATE NOT NULL,
	TanggalPembaruanTerakhir DATETIME NOT NULL
)

CREATE TABLE Produk(
	IDProduk CHAR(9) PRIMARY KEY NOT NULL CHECK (IDProduk LIKE 'MHSPRK[0-9][0-9][0-9]'),
	NamaProduk VARCHAR(100) NOT NULL,
	Deskripsi VARCHAR(255),
	HargaProduk INT NOT NULL,
	TanggalInput DATE NOT NULL,
	TanggalPembaruanTerakhir DATETIME NOT NULL
);

CREATE TABLE MetodePengiriman (
	IDMetodePengiriman CHAR(8) PRIMARY KEY NOT NULL CHECK (IDMetodePengiriman LIKE 'MHSPM[0-9][0-9][0-9]'),
	NamaMetodePengiriman VARCHAR(20) NOT NULL,
	DurasiPengiriman INT NOT NULL,
	BiayaPengiriman INT NOT NULL,
	TanggalInput DATE NOT NULL,
	TanggalPembaruanTerakhir DATETIME NOT NULL
)

CREATE TABLE MetodePembayaran(
	IDMetodePembayaran CHAR(8) PRIMARY KEY NOT NULL CHECK(IDMetodePembayaran LIKE 'MHSPR[0-9][0-9][0-9]'),
	NamaMetodePembayaran VARCHAR(30) NOT NULL CHECK(NamaMetodePembayaran IN ('Transfer', 'Tempo')),
	TanggalInput DATE NOT NULL,
	TanggalPembaruanTerakhir DATETIME NOT NULL
)

CREATE TABLE Penjualan(
	IDPenjualan CHAR(7) PRIMARY KEY NOT NULL CHECK(IDPenjualan LIKE 'MHSP[0-9][0-9][0-9]'),
	TanggalPenjualan DATE NOT NULL,
	IDPelanggan CHAR(8) REFERENCES Pelanggan(IDPelanggan) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	IDKaryawan CHAR(7) REFERENCES Karyawan(IDKaryawan) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	IDMetodePembayaran CHAR(8) REFERENCES MetodePembayaran(IDMetodePembayaran) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	IDMetodePengiriman CHAR(8) REFERENCES MetodePengiriman (IDMetodePengiriman) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TotalJumlahProduk INT , --> di sini harusnya tidak perlu karena bisa diautomated oleh sistem
	Diskon INT NOT NULL,
	PPN INT NOT NULL,
	-- TotalHarga INT NOT NULL, --> di sini tidak perlu, bisa automated
	TanggalPelunasan DATE
);

CREATE TABLE DetailPenjualan(
	IDPenjualan CHAR(7) REFERENCES Penjualan(IDPenjualan) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	IDProduk CHAR(9) REFERENCES Produk(IDProduk) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	JumlahProduk INT NOT NULL,
	SubTotal INT 
);

INSERT INTO Pelanggan (IDPelanggan, NamaPelanggan, NomorHPPelanggan, AlamatPelanggan, EmailPelanggan, TanggalInput, TanggalPembaruanTerakhir) VALUES
('MHSPL001', 'Andi Setiawan', '08123456789', 'Jl. Merdeka No. 1', 'andi@example.com', GETDATE(), GETDATE()),
('MHSPL002', 'Budi Santoso', '08123456780', 'Jl. Sudirman No. 2', 'budi@example.com', GETDATE(), GETDATE()),
('MHSPL003', 'Citra Dewi', '08123456781', 'Jl. Gatot Subroto No. 3', 'citra@example.com', GETDATE(), GETDATE()),
('MHSPL004', 'Dewi Lestari', '08123456782', 'Jl. Ahmad Yani No. 4', 'dewi@example.com', GETDATE(), GETDATE()),
('MHSPL005', 'Eko Prasetyo', '08123456783', 'Jl. Diponegoro No. 5', 'eko@example.com', GETDATE(), GETDATE());

-- Inserting data into Karyawan
INSERT INTO Karyawan (IDKaryawan, NamaKaryawan, PosisiKaryawan, TanggalBergabung, TanggalInput, TanggalPembaruanTerakhir) VALUES
('MHSK001', 'Fajar Nugroho', 'Manager', '2021-01-15', GETDATE(), GETDATE()),
('MHSK002', 'Gina Sari', 'Staff', '2021-02-20', GETDATE(), GETDATE()),
('MHSK003', 'Hendra Wijaya', 'Staff', '2021-03-10', GETDATE(), GETDATE()),
('MHSK004', 'Ika Putri', 'Supervisor', '2021-04-25', GETDATE(), GETDATE()),
('MHSK005', 'Joko Susilo', 'Staff', '2021-05-30', GETDATE(), GETDATE());

-- Inserting data into Produk
INSERT INTO Produk (IDProduk, NamaProduk, Deskripsi, HargaProduk, TanggalInput, TanggalPembaruanTerakhir) VALUES
('MHSPRK001', 'Produk A', 'Deskripsi Produk A', 10000, GETDATE(), GETDATE()),
('MHSPRK002', 'Produk B', 'Deskripsi Produk B', 20000, GETDATE(), GETDATE()),
('MHSPRK003', 'Produk C', 'Deskripsi Produk C', 30000, GETDATE(), GETDATE()),
('MHSPRK004', 'Produk D', 'Deskripsi Produk D', 40000, GETDATE(), GETDATE()),
('MHSPRK005', 'Produk E', 'Deskripsi Produk E', 50000, GETDATE(), GETDATE());

-- Inserting data into MetodePengiriman
INSERT INTO MetodePengiriman (IDMetodePengiriman, NamaMetodePengiriman, DurasiPengiriman, BiayaPengiriman, TanggalInput, TanggalPembaruanTerakhir) VALUES
('MHSPM001', 'Kurir', 2, 5000, GETDATE(), GETDATE()),
('MHSPM002', 'JNE', 3, 10000, GETDATE(), GETDATE()),
('MHSPM003', 'Tiki', 4, 15000, GETDATE(), GETDATE()),
('MHSPM004', 'Pos Indonesia', 5, 20000, GETDATE(), GETDATE()),
('MHSPM005', 'Grab', 1, 7000, GETDATE(), GETDATE());

-- Inserting data into MetodePembayaran
INSERT INTO MetodePembayaran (IDMetodePembayaran, NamaMetodePembayaran, TanggalInput, TanggalPembaruanTerakhir) VALUES
('MHSPR001', 'Transfer', GETDATE(), GETDATE()),
('MHSPR002', 'Tempo', GETDATE(), GETDATE()),
('MHSPR003', 'Transfer', GETDATE(), GETDATE()),
('MHSPR004', 'Tempo', GETDATE(), GETDATE()),
('MHSPR005', 'Transfer', GETDATE(), GETDATE());

INSERT INTO Penjualan (IDPenjualan, TanggalPenjualan, IDPelanggan, IDKaryawan, IDMetodePembayaran, IDMetodePengiriman, Diskon, PPN, TanggalPelunasan) VALUES
('MHSP001', '2023-10-01', 'MHSPL001', 'MHSK001', 'MHSPR001', 'MHSPM001', 0, 10, NULL),
('MHSP002', '2023-10-02', 'MHSPL002', 'MHSK002', 'MHSPR002', 'MHSPM002', 5, 10, '2023-10-05'),
('MHSP003', '2023-10-03', 'MHSPL003', 'MHSK003', 'MHSPR001', 'MHSPM003', 0, 10, NULL),
('MHSP004', '2023-10-04', 'MHSPL004', 'MHSK004', 'MHSPR002', 'MHSPM004', 10, 10, '2023-10-10'),
('MHSP005', '2023-10-05', 'MHSPL005', 'MHSK005', 'MHSPR001', 'MHSPM005', 0, 10, NULL),
('MHSP006', '2023-10-06', 'MHSPL001', 'MHSK002', 'MHSPR002', 'MHSPM001', 5, 10, NULL),
('MHSP007', '2023-10-07', 'MHSPL002', 'MHSK003', 'MHSPR001', 'MHSPM002', 0, 10, '2023-10-12'),
('MHSP008', '2023-10-08', 'MHSPL003', 'MHSK004', 'MHSPR002', 'MHSPM003', 0, 10, NULL),
('MHSP009', '2023-10-09', 'MHSPL004', 'MHSK005', 'MHSPR001', 'MHSPM004', 15, 10, NULL),
('MHSP010', '2023-10-10', 'MHSPL005', 'MHSK001', 'MHSPR002', 'MHSPM005', 0, 10, '2023-10-15');

INSERT INTO DetailPenjualan (IDPenjualan, IDProduk, JumlahProduk, SubTotal) VALUES
('MHSP001', 'MHSPRK001', 2, 20000),
('MHSP001', 'MHSPRK002', 1, 20000),
('MHSP002', 'MHSPRK003', 3, 90000),
('MHSP002', 'MHSPRK001', 1, 10000),
('MHSP003', 'MHSPRK002', 2, 40000),
('MHSP004', 'MHSPRK004', 1, 40000),
('MHSP005', 'MHSPRK005', 5, 250000),
('MHSP006', 'MHSPRK001', 2, 20000),
('MHSP007', 'MHSPRK003', 1, 30000),
('MHSP008', 'MHSPRK002', 1, 20000),
('MHSP009', 'MHSPRK004', 1, 40000),
('MHSP010', 'MHSPRK005', 3, 150000);

--Trigger akan dijalankan setelah insert data ke DetailPenjualan
CREATE TRIGGER CalculateSubtotal
ON DetailPenjualan
AFTER INSERT
AS
BEGIN
    -- Update SubTotal after a new row is inserted
    UPDATE dp
    SET dp.SubTotal = i.JumlahProduk * p.HargaProduk
    FROM DetailPenjualan dp
    INNER JOIN INSERTED i ON dp.IDPenjualan = i.IDPenjualan AND dp.IDProduk = i.IDProduk
    INNER JOIN Produk p ON i.IDProduk = p.IDProduk;
END;


-- SELECT data DetailPenjualan
SELECT * FROM DetailPenjualan DP
JOIN Produk P 
ON P.IDProduk = DP.IDProduk