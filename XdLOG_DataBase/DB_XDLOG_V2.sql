-- Tạo bảng lớp "user" (cơ sở)
CREATE TABLE [user]
(
    UserID INT PRIMARY KEY,
    Username NVARCHAR(50),
    Password NVARCHAR(50),
    Email NVARCHAR(100),
    UserType NVARCHAR(50)
);

-- Tạo bảng lớp "GIAOVIEN" (giáo viên)
CREATE TABLE GIAOVIEN
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID),
    MAGV NCHAR(3),
    HOTEN NVARCHAR(50),
    PHAI NCHAR(3),
    NGSINH DATE,
    DIACHI NCHAR(50)
);

-- Tạo bảng lớp "GIÁO VIÊN CHỦ NHIỆM" (giáo viên chủ nhiệm)
CREATE TABLE GIAOVIENCHUNHIEM
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID)
);

-- Tạo bảng lớp "TOTRUONGBOMON" (tổ trưởng bộ môn)
CREATE TABLE TOTRUONGBOMON
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID)
);

-- Tạo bảng lớp "BANGIAMHIEU" (ban giám hiệu)
CREATE TABLE BANGIAMHIEU
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID)
);

-- Tạo bảng lớp "SYSADMIN" (quản trị hệ thống)
CREATE TABLE SYSADMIN
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID)
);

-- Tạo bảng "BOMON" (bộ môn)
CREATE TABLE BOMON
(
    MABM NCHAR(4) PRIMARY KEY,
    MATT INT FOREIGN KEY REFERENCES TOTRUONGBOMON(UserID),
    TENMONHOC NVARCHAR(50)
);

-- Bảng "SODAUBAI" (sổ đầu bài: ghi chú điểm danh)
CREATE TABLE SODAUBAI
(
    RecordID INT PRIMARY KEY,
    ClassID INT,
    Date DATE,
    AttendanceStatus NVARCHAR(20),
    StudentID INT,
    Note NVARCHAR(MAX)
);

-- Bảng "LOPHOC" (lớp học)
CREATE TABLE LOPHOC
(
    ClassID INT PRIMARY KEY,
    ClassName NVARCHAR(100),
    TeacherID INT FOREIGN KEY REFERENCES GIAOVIEN(UserID),
    Schedule NVARCHAR(100),
    Room NVARCHAR(50)
);

-- Bảng "TAINGUYENGIAODUC" (tài nguyên giáo dục)
CREATE TABLE TAINGUYENGIAODUC
(
    ResourceID INT PRIMARY KEY,
    ResourceType NVARCHAR(50),
    ResourceName NVARCHAR(100),
    Description NVARCHAR(MAX),
    FileLink NVARCHAR(200)
);

-- Bảng "MINIGAMES" (trò chơi giáo dục)
CREATE TABLE MINIGAMES
(
    GameID INT PRIMARY KEY,
    GameName NVARCHAR(100),
    Description NVARCHAR(MAX),
    Link NVARCHAR(200)
);
