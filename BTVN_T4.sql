﻿CREATE DATABASE QLSP
USE QLSP 
SET DATEFORMAT DMY
CREATE TABLE NhomSanPham( MANHOM INT NOT NULL PRIMARY KEY,
	TenNhom NVARCHAR(15));
CREATE TABLE NhaCungCap (MaNCC INT NOT NULL PRIMARY KEY,
	TenNcc NVARCHAR(40) NOT NULL,
	Diachi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50));
CREATE TABLE SanPham (MaSp INT NOT NULL PRIMARY KEY,
	TenSp NVARCHAR(40) NOT NULL,
	MaNCC INT,
	MoTa NVARCHAR(50),
	MaNhom INT,
	Donvitinh NVARCHAR(20),
	GiaGoc MONEY CHECK (GiaGoc > 0),
	SLTON INT CHECK (SLTON > 0),
	CONSTRAINT FK_SanPham_Nhom FOREIGN KEY (MaNhom) REFERENCES NhomSanPham(MANHOM),
    CONSTRAINT FK_SanPham_NCC FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC));
CREATE TABLE HoaDon (MaHD INT NOT NULL,
	NgayLapHD DATETIME, 
	NgayGiao DATETIME,
	Noichuyen NVARCHAR(60) NOT NULL,
	MaKh NCHAR(5));
CREATE TABLE CT_HoaDon (MaHD INT NOT NULL,
	MaSp INT NOT NULL,
	Soluong INT CHECK (Soluong > 0),
	Dongia MONEY,
	ChietKhau MONEY CHECK (ChietKhau >= 0));
CREATE TABLE KhachHang (MaKh NCHAR(5) NOT NULL,
	TenKh NVARCHAR(40) NOT NULL,
	LoaiKh NVARCHAR(3) CHECK (LoaiKh IN ('VIP','TV','VL')),
	DiaChi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50),
	DiemTL INT CHECK (DiemTL >= 0));
	--- b) THÊM KHÓA CHÍNH CHO 3 TABLE
ALTER TABLE KhachHang ADD CONSTRAINT PK_KhachHang PRIMARY KEY (MaKh);
ALTER TABLE HoaDon ADD CONSTRAINT Pk_HoaDon PRIMARY KEY (MaHD);
ALTER TABLE CT_HoaDon ADD CONSTRAINT Pk_CTHoaDon PRIMARY KEY (MaHD, MaSp);
--- C) THÊM KHÓA NGOẠI CHO 3 TABLE
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDON_KhachHang FOREIGN KEY (MaKh) REFERENCES KhachHang(MaKh);
ALTER TABLE CT_HoaDon ADD CONSTRAINT FK_CT_HoaDon_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD);
ALTER TABLE CT_HoaDon ADD CONSTRAINT FK_CT_HoaDon_SanPham FOREIGN KEY (MaSp) REFERENCES SanPham(MaSp);
--- d) Alter Table … khai báo các ràng buộc miền giá trị (Check Constraint) và ràng buộc giá trị mặc định:
ALTER TABLE HoaDon  ADD CONSTRAINT DF_NgayLapHD DEFAULT GETDATE() FOR NgayLapHD;
--- e) LoaiHD vào bảng HOADON, có kiểu dữ liệu char(1), Chỉ nhập N(Nhập), X(Xuất), C(Chuyển từ cửa hàng này sang cửa hàng khác), T (Trả), giá trị mặc định là ‘N’.
ALTER TABLE HoaDon ADD LoaiHD CHAR(1) NOT NULL DEFAULT 'N';
ALTER TABLE HoaDon ADD CONSTRAINT CK_LoaiHD CHECK (LoaiHD IN ('N', 'X', 'C', 'T'));
---f) ràng buộc cho bảng HoaDon với yêu cầu NgayGiao>=NgayLapHD
ALTER TABLE HoaDon ADD CONSTRAINT CK_NgayGiao CHECK (NgayGiao >= NgayLapHD);
CREATE TABLE Nhanvien( MaNV nchar(5) PRIMARY KEY,
 TenNV nvarchar(40) NOT NULL,
 DiaChi nvarchar(60) NULL,
 Dienthoai nvarchar(24) NULL )
GO
ALTER TABLE HoaDon ADD MaNV NCHAR(5);
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_Nhanvien FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL)
VALUES ('Kh001', 'NGUYEN ANH DUONG', 'VIP', 'QGV-TP.HCM', '0377651286', '235146', 'anhduongnguyen454@gmail.com', 10);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL)
VALUES ('Kh002', 'NGUYEN THUY DUONG', 'TV', 'QGV-TP.HCM', '0981630839', '201543', 'thuyduonglahai@gmail.com', 50);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL)
VALUES ('Kh003', 'NGUYEN DUY LOI', 'VIP', 'Q1-TP.HCM', '0394626243', '201543', 'duyloi1402@gmail.com', 91);
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV001', 'NGUYEN VAN A', 'PHU NHUAN', '0987265146');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV010', 'NGUYEN HOA B', 'PHU NHUAN', '0901120456');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV015', 'NGUYEN XUAN C', 'PHU NHUAN', '0902530811');
GO
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (00001, 'CONG TY TNHH ABC', 'PHAN XICH LONG - PHU NHUAN', '0325614562', '034987', 'ABC1104@GMAIL.COM');
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (00002, 'CONG TY TNHH ACB', 'PHAN DANG LUU - PHU NHUAN', '0375213642', '035211', 'ACB0213@GMAIL.COM');
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail)
VALUES (00003, 'CONG TY TNHH ACI', 'PHAN CHAU TRINH - PHU NHUAN', '0391567862', '035234', 'ACI333@GMAIL.COM');
INSERT INTO NhomSanPham (MANHOM, TenNhom)
VALUES (1, 'LAPTOP');
INSERT INTO NhomSanPham (MANHOM, TenNhom)
VALUES (2, 'PHUKIEN');
INSERT INTO NhomSanPham (MANHOM, TenNhom)
VALUES (3, 'KHAC');
INSERT INTO SanPham (MaSp, TenSp, Donvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (1, 'LAPTOP ASUS', 'CAI', 23500000, 100, 1, 00001, 'LAPTOP  GAMING');
INSERT INTO SanPham (MaSp, TenSp, Donvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (10, 'CHUOT ASUS', 'CAI', 500000, 100, 1, 00001, 'CHUOT  GAMING');
INSERT INTO SanPham (MaSp, TenSp, Donvitinh, GiaGoc, SLTON, MaNhom, MaNCC, MoTa)
VALUES (2, 'LAPTOP DELL', 'CAI', 14900000, 50, 1, 00002, 'LAPTOP  VAN PHONG');
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES (1, 06-03-2025, 'Kh001', 08-03-2025, 'DONG BAC, TAN CHAN HIEP, QUAN 12');
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES (2, 06-03-2025, 'Kh002', 10-03-2025, 'NGUYEN VAN QUA, TAN CHAN HIEP, QUAN 12');
INSERT INTO HoaDon (MaHD, NgayLapHD, MaKh, NgayGiao, Noichuyen)
VALUES (3, 06-03-2025, 'Kh001', 08-03-2025, 'DONG BAC, TAN CHAN HIEP, QUAN 12');
INSERT INTO CT_HoaDon (MaHD, MaSp, Dongia, Soluong)
VALUES (1, 1, 25000000, 5);
INSERT INTO CT_HoaDon (MaHD, MaSp, Dongia, Soluong)
VALUES (2, 2, 15000000, 10);
INSERT INTO CT_HoaDon (MaHD, MaSp, Dongia, Soluong)
VALUES (3, 10, 450000, 5);