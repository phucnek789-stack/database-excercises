--Cach 1:Tao va xoa bang dung thu tu
--Tao FK khi tao bang

--Cau 44: Tao CSDL 
USE master
GO
CREATE DATABASE QLSinhVien_HocDDL
GO
USE QLSinhVien_HocDDL
GO

--Tao tu tren xuong
--Cau 45: Thiet ke bang Khoa
CREATE TABLE dbo.Khoa(
		MaKhoa nvarchar(8) NOT NULL,
		TenKhoa nvarchar(50) NULL,
		NgayThanhLap date NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaKhoa)
)
GO

--Cau 46: Thiet ke bang Lop
CREATE TABLE dbo.Lop(
		MaLop nvarchar(8) NOT NULL,
		TenLop nvarchar(50) NULL,
		GVCN nvarchar(100) NULL,
		MaKhoa nvarchar(8) NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaLop),
		FOREIGN KEY(MaKhoa) REFERENCES dbo.Khoa (MaKhoa)
)
GO

--Cau 47: Thiet ke bang SinhVien
CREATE TABLE dbo.SinhVien(
		MaSV nvarchar(8) NOT NULL,
		HoSV nvarchar(50) NULL,
		TenSV nvarchar(20) NULL,
		GioiTinh nvarchar(50) NULL,
		NgaySinh datetime NULL,
		DiaChi nvarchar(100) NULL,
		MaLop nvarchar(8) NULL,
		QueQuan nvarchar(50) NULL,
		DTDD nvarchar(12) NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaSV),
		FOREIGN KEY(MaLop) REFERENCES dbo.Lop (MaLop)
)
GO

--Cau 48: Thiet ke bang MonHoc
CREATE TABLE MonHoc(
		MaMH int IDENTITY(1,1) NOT NULL,
		TenMH nvarchar(50) NULL,
		SoTC float NULL,
		MaKhoaPhuTrach nvarchar(8) NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaMH),
		FOREIGN KEY(MaKhoaPhuTrach) REFERENCES dbo.Khoa (MaKhoa)
)
GO

--Cau 49: Thiet ke bang Hoc
CREATE TABLE Hoc(
		MaMH int NOT NULL,
		MaSV nvarchar(8) NOT NULL,
		NgayDangKyMH date NOT NULL,
		DiemTrungBinhMH float NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaMH, MaSV, NgayDangKyMH),
		FOREIGN KEY(MaMH) REFERENCES MonHoc (MaMH),
		FOREIGN KEY(MaSV) REFERENCES SinhVien (MaSV)
)
GO

--Cau 50: Xoa tat ca cac bang (xoa tu duoi len)
USE QLSinhVien_HocDDL
GO
DROP TABLE Hoc
GO
DROP TABLE MonHoc
GO
DROP TABLE SinhVien
GO
DROP TABLE Lop
GO
DROP TABLE Khoa
GO

--Cach 2: Tao va xoa bang ko can dung thu tu
--Ko can tao FK khi tao bang
--Cau 44: Tao CSDL 
USE master
GO
CREATE DATABASE QLSinhVien_HocDDL2
GO
USE QLSinhVien_HocDDL2
GO

--Cau 45: Thiet ke bang MonHoc
CREATE TABLE MonHoc(
		MaMH int IDENTITY(1,1) NOT NULL,
		TenMH nvarchar(50) NULL,
		SoTC float NULL,
		MaKhoaPhuTrach nvarchar(8) NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaMH)
)
GO

--Cau 46: Thiet ke bang Hoc
CREATE TABLE Hoc(
		MaMH int NOT NULL,
		MaSV nvarchar(10) NOT NULL,
		NgayDangKyMH date NOT NULL,
		DiemTrungBinhMH float NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaMH, MaSV, NgayDangKyMH)
)
GO

--Cau 47: Thiet ke bang khoa
CREATE TABLE dbo.Khoa(
		MaKhoa nvarchar(8) NOT NULL,
		TenKhoa nvarchar(50) NULL,
		NgayThanhLap date NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaKhoa)
)
GO

--Cau 48: Thiet ke bang Lop
CREATE TABLE dbo.Lop(
		MaLop nvarchar(8) NOT NULL,
		TenLop nvarchar(50) NULL,
		GVCN nvarchar(100) NULL,
		MaKhoa nvarchar(8) NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaLop)
)
GO

--Cau 49: Thiet ke bang SinhVien
CREATE TABLE dbo.SinhVien(
		MaSV nvarchar(10) NOT NULL,
		HoSV nvarchar(50) NULL,
		TenSV nvarchar(20) NULL,
		GioiTinh nvarchar(50) NULL,
		NgaySinh datetime NULL,
		DiaChi nvarchar(100) NULL,
		MaLop nvarchar(8) NULL,
		QueQuan nvarchar(50) NULL,
		DTDD nvarchar(12) NULL,
		GhiChu ntext NULL,
		PRIMARY KEY(MaSV)
)
GO

--Sau khi tao tat ca cac bang, ta them rang buoc cac khoa ngoai:
ALTER TABLE Lop ADD CONSTRAINT FK_Lop_MaKhoa FOREIGN KEY(Makhoa) REFERENCES Khoa (MaKhoa)
GO
ALTER TABLE SinhVien ADD CONSTRAINT FK_SinhVien_MaLop FOREIGN KEY(MaLop) REFERENCES Lop (MaLop)
GO
ALTER TABLE MonHoc ADD CONSTRAINT FK_MonHoc_MaKhoaPhuTrach FOREIGN KEY(MakhoaPhuTrach) REFERENCES Khoa (MaKhoa)
GO
ALTER TABLE Hoc ADD CONSTRAINT FK_Hoc_MaMH FOREIGN KEY(MaMH) REFERENCES MonHoc (MaMH)
GO
ALTER TABLE Hoc ADD CONSTRAINT FK_Hoc_MaSV FOREIGN KEY(MaSV) REFERENCES SinhVien (MaSV)
GO

--Xoa rang buoc khoa ngoai:
ALTER TABLE Lop DROP CONSTRAINT FK_Lop_MaKhoa
GO
ALTER TABLE SinhVien DROP CONSTRAINT FK_SinhVien_MaLop
GO
ALTER TABLE MonHoc DROP CONSTRAINT FK_MonHoc_MaKhoaPhuTrach
GO
ALTER TABLE Hoc DROP CONSTRAINT FK_Hoc_MaMH
GO
ALTER TABLE Hoc DROP CONSTRAINT FK_Hoc_MaSV
GO

--Xoa cac bangm, ko can theo thu tu
DROP TABLE SinhVien
DROP TABLE Lop
DROP TABLE Khoa
DROP TABLE Hoc
DROP TABLE MonHoc