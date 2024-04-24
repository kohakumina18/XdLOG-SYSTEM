-- Creating the base class "user" table
CREATE TABLE [user]
(
    UserID INT PRIMARY KEY,
    Username NVARCHAR(50),
    Password NVARCHAR(50),
    Email NVARCHAR(100),
    UserType NVARCHAR(50) -- This column will indicate the type of user (e.g., GIAOVIEN, TOTRUONGBOMON, etc.)
);

-- Creating the derived class "GIAOVIEN" table
CREATE TABLE GIAOVIEN
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID),
    MAGV NCHAR(3),
    HOTEN NVARCHAR(50),
    PHAI NCHAR(3),
    NGSINH DATE,
    DIACHI NCHAR(50)
);

-- Creating the derived class "GIÁO VIÊN CHỦ NHIỆM" table
CREATE TABLE GIAOVIENCHUNHIEM
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID),
    -- Add specific columns related to GIÁO VIÊN CHỦ NHIỆM here
);

-- Creating the derived class "TOTRUONGBOMON" table
CREATE TABLE TOTRUONGBOMON
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID),
    -- Add specific columns related to TOTRUONGBOMON here
);

-- Creating the derived class "BANGIAMHIEU" table
CREATE TABLE BANGIAMHIEU
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID),
    -- Add specific columns related to BANGIAMHIEU here
);

-- Creating the derived class "SYSADMIN" table
CREATE TABLE SYSADMIN
(
    UserID INT PRIMARY KEY FOREIGN KEY REFERENCES [user](UserID),
    -- Add specific columns related to SYSADMIN here
);

-- Creating the "BOMON" table
CREATE TABLE BOMON
(
    MABM NCHAR(4) PRIMARY KEY,
    MATT INT FOREIGN KEY REFERENCES TOTRUONGBOMON(UserID),
    TENMONHOC NVARCHAR(50)
);


-- SODAUBAI: Attendance Record Table
CREATE TABLE SODAUBAI
(
    RecordID INT PRIMARY KEY,
    ClassID INT, -- or whatever identifier you're using for classes
    Date DATE,
    AttendanceStatus NVARCHAR(20), -- e.g., Present, Absent
    StudentID INT,
    Note NVARCHAR(MAX)
);

-- LOPHOC: Class Table
CREATE TABLE LOPHOC
(
    ClassID INT PRIMARY KEY,
    ClassName NVARCHAR(100),
    TeacherID INT FOREIGN KEY REFERENCES GIAOVIEN(UserID),
    Schedule NVARCHAR(100),
    Room NVARCHAR(50)
);

-- Tài Nguyên Giáo Dục: Educational Resources Table
CREATE TABLE TAINGUYENGIAODUC
(
    ResourceID INT PRIMARY KEY,
    ResourceType NVARCHAR(50),
    ResourceName NVARCHAR(100),
    Description NVARCHAR(MAX),
    FileLink NVARCHAR(200) -- Assuming file link is a URL
);

-- MINIGAMES: Educational Games Table
CREATE TABLE MINIGAMES
(
    GameID INT PRIMARY KEY,
    GameName NVARCHAR(100),
    Description NVARCHAR(MAX),
    Link NVARCHAR(200) -- Assuming link is a URL
);
