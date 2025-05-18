-- Ba��ml� tablolardan ba�layarak silme i�lemi
IF OBJECT_ID('Toplama', 'U') IS NOT NULL DROP TABLE Toplama;
IF OBJECT_ID('Atik', 'U') IS NOT NULL DROP TABLE Atik;
IF OBJECT_ID('Araclar', 'U') IS NOT NULL DROP TABLE Araclar;
IF OBJECT_ID('AtikTurleri', 'U') IS NOT NULL DROP TABLE AtikTurleri;
IF OBJECT_ID('Kullanicilar', 'U') IS NOT NULL DROP TABLE Kullanicilar;

-- 1. Kullan�c�lar tablosu
CREATE TABLE Kullanicilar (
   KullaniciID INT PRIMARY KEY IDENTITY(1,1),
   Ad VARCHAR(50),
   Soyad VARCHAR(50),
   Email VARCHAR(100),
   Telefon VARCHAR(15),
   Adres VARCHAR(255)
);

-- 2. At�k T�rleri tablosu
CREATE TABLE AtikTurleri (
   AtikTuruID INT PRIMARY KEY IDENTITY(1,1),
   TuruAdi VARCHAR(50)
);

-- 3. At�k tablosu
CREATE TABLE Atik (
   AtikID INT PRIMARY KEY IDENTITY(1,1),
   KullaniciID INT,
   AtikTuruID INT,
   Miktar DECIMAL(10,2),
   Birim VARCHAR(20),
   Tarih DATE,
   FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID),
   FOREIGN KEY (AtikTuruID) REFERENCES AtikTurleri(AtikTuruID)
);

-- 4. Ara�lar tablosu
CREATE TABLE Araclar (
   AracID INT PRIMARY KEY IDENTITY(1,1),
   Plaka VARCHAR(15),
   SurucuAdi VARCHAR(50),
   KapasiteKG INT
);

-- 5. Toplama tablosu
CREATE TABLE Toplama (
   ToplamaID INT PRIMARY KEY IDENTITY(1,1),
   AtikID INT,
   AracID INT,
   ToplamaTarihi DATE,
   FOREIGN KEY (AtikID) REFERENCES Atik(AtikID),
   FOREIGN KEY (AracID) REFERENCES Araclar(AracID)
);
INSERT INTO Kullanicilar (Ad, Soyad, Email, Telefon, Adres) VALUES
('Ahmet', 'Y�lmaz', 'ahmet@example.com', '5551230001', 'Kad�k�y, �stanbul'),
('Ay�e', 'Demir', 'ayse@example.com', '5551230002', '�sk�dar, �stanbul'),
('Mert', 'Kaya', 'mert@example.com', '5551230003', 'Be�ikta�, �stanbul'),
('Zeynep', 'Arslan', 'zeynep@example.com', '5551230004', 'Ata�ehir, �stanbul'),
('Ali', '�etin', 'ali@example.com', '5551230005', 'Maltepe, �stanbul'),
('Elif', 'Ko�', 'elif@example.com', '5551230006', 'Kartal, �stanbul'),
('Fatma', 'Yavuz', 'fatma@example.com', '5551230007', 'Pendik, �stanbul'),
('Emre', 'G�ne�', 'emre@example.com', '5551230008', 'Tuzla, �stanbul'),
('Can', 'Ayd�n', 'can@example.com', '5551230009', 'Bak�rk�y, �stanbul'),
('Ceren', '�ahin', 'ceren@example.com', '5551230010', 'Beylikd�z�, �stanbul'),
('Burak', 'Polat', 'burak@example.com', '5551230011', 'Esenyurt, �stanbul'),
('Merve', '�zt�rk', 'merve@example.com', '5551230012', 'Avc�lar, �stanbul'),
('Yusuf', 'Ta�', 'yusuf@example.com', '5551230013', 'Sar�yer, �stanbul'),
('Gamze', 'Bal', 'gamze@example.com', '5551230014', '�i�li, �stanbul'),
('Mustafa', 'Eren', 'mustafa@example.com', '5551230015', 'Ba�c�lar, �stanbul');

INSERT INTO AtikTurleri (TuruAdi) VALUES
('Plastik'), -- ID = 1
('Ka��t'),   -- ID = 2
('Cam'),     -- ID = 3
('Organik'); -- ID = 4

INSERT INTO Atik (KullaniciID, AtikTuruID, Miktar, Birim, Tarih) VALUES
(1, 1, 2.5, 'kg', '2025-05-01'),
(2, 2, 1.3, 'kg', '2025-05-02'),
(3, 1, 4.2, 'kg', '2025-05-02'),
(4, 3, 0.8, 'kg', '2025-05-03'),
(5, 1, 3.1, 'kg', '2025-05-03'),
(6, 4, 2.0, 'kg', '2025-05-04'),
(7, 2, 1.5, 'kg', '2025-05-04'),
(8, 1, 5.0, 'kg', '2025-05-05'),
(9, 3, 2.2, 'kg', '2025-05-05'),
(10, 4, 3.0, 'kg', '2025-05-05'),
(11, 1, 1.9, 'kg', '2025-05-06'),
(12, 2, 2.7, 'kg', '2025-05-06'),
(13, 3, 1.1, 'kg', '2025-05-07'),
(14, 4, 2.4, 'kg', '2025-05-07'),
(15, 1, 4.0, 'kg', '2025-05-07'),
(1, 2, 1.2, 'kg', '2025-05-08'),
(2, 3, 1.6, 'kg', '2025-05-08'),
(3, 4, 0.9, 'kg', '2025-05-08'),
(4, 1, 2.3, 'kg', '2025-05-08'),
(5, 2, 3.4, 'kg', '2025-05-08');
SELECT * FROM Atik;
SELECT k.Ad, k.Soyad, a.Miktar, a.Tarih
FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID;
SELECT k.Ad, k.Soyad, t.TuruAdi, a.Miktar, a.Tarih
FROM Atik a
JOIN Kullanicilar k ON a.KullaniciID = k.KullaniciID
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID;
SELECT t.TuruAdi, SUM(a.Miktar) AS ToplamMiktar
FROM Atik a
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID
GROUP BY t.TuruAdi;
SELECT k.Ad, k.Soyad, SUM(a.Miktar) AS Toplam
FROM Atik a
JOIN Kullanicilar k ON a.KullaniciID = k.KullaniciID
GROUP BY k.Ad, k.Soyad;
SELECT TOP 5 k.Ad, k.Soyad, SUM(a.Miktar) AS Toplam
FROM Atik a
JOIN Kullanicilar k ON a.KullaniciID = k.KullaniciID
GROUP BY k.Ad, k.Soyad
ORDER BY Toplam DESC;
SELECT k.Ad, k.Soyad, SUM(a.Miktar) AS Toplam
FROM Atik a
JOIN Kullanicilar k ON a.KullaniciID = k.KullaniciID
GROUP BY k.Ad, k.Soyad
HAVING SUM(a.Miktar) > 3;
SELECT Tarih, SUM(Miktar) AS GunlukMiktar
FROM Atik
GROUP BY Tarih
ORDER BY Tarih;
SELECT t.TuruAdi, AVG(a.Miktar) AS Ortalama
FROM Atik a
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID
GROUP BY t.TuruAdi;
SELECT TOP 1 k.Ad, k.Soyad, COUNT(a.AtikID) AS KayitSayisi
FROM Atik a
JOIN Kullanicilar k ON a.KullaniciID = k.KullaniciID
GROUP BY k.Ad, k.Soyad
ORDER BY KayitSayisi DESC;
-- Kullan�c� ekle
INSERT INTO Kullanicilar (Ad, Soyad, Email, Telefon, Adres)
VALUES ('Ahmet', 'Y�lmaz', 'ahmet@example.com', '5551234567', 'Kad�k�y');

-- At�k t�r� ekle
INSERT INTO AtikTurleri (TuruAdi) VALUES ('Plastik');

-- At�k kayd� ekle
INSERT INTO Atik (KullaniciID, AtikTuruID, Miktar, Birim, Tarih)
VALUES (1, 1, 2.5, 'kg', '2025-05-01');

-- At�k miktar�n� g�ncelle
UPDATE Atik SET Miktar = 3.0 WHERE AtikID = 1;

-- At�k kayd� sil
DELETE FROM Atik WHERE AtikID = 1;

SELECT k.Ad, k.Soyad, a.Miktar FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID;
SELECT k.Ad, t.TuruAdi, a.Miktar FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID;
SELECT t.TuruAdi, SUM(a.Miktar) AS ToplamMiktar
FROM Atik a
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID
GROUP BY t.TuruAdi;
SELECT k.Ad, SUM(a.Miktar) AS ToplamAtikMiktari
FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID
GROUP BY k.Ad;
SELECT k.Ad, SUM(a.Miktar) AS Toplam FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID
GROUP BY k.Ad
HAVING SUM(a.Miktar) > 3;
SELECT t.TuruAdi, AVG(a.Miktar) AS OrtalamaMiktar
FROM Atik a
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID
GROUP BY t.TuruAdi;


SELECT k.Ad FROM Kullanicilar k
LEFT JOIN Atik a ON k.KullaniciID = a.KullaniciID
WHERE a.AtikID IS NULL;
SELECT TOP 3 k.Ad, SUM(a.Miktar) AS Toplam FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID
GROUP BY k.Ad ORDER BY Toplam DESC;
SELECT t.TuruAdi, COUNT(*) AS AtikSayisi
FROM Atik a
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID
GROUP BY t.TuruAdi;
SELECT t.TuruAdi, COUNT(*) FROM Atik a
JOIN AtikTurleri t ON a.AtikTuruID = t.AtikTuruID
GROUP BY t.TuruAdi;

CREATE VIEW KullaniciAtikToplam AS
SELECT k.Ad, k.Soyad, SUM(a.Miktar) AS ToplamMiktar
FROM Kullanicilar k
JOIN Atik a ON k.KullaniciID = a.KullaniciID
GROUP BY k.Ad, k.Soyad

SELECT * FROM KullaniciAtikToplam;

CREATE PROCEDURE spAtikEkle
   @KullaniciID INT,
   @AtikTuruID INT,
   @Miktar DECIMAL(10,2)
AS
BEGIN
   INSERT INTO Atik (KullaniciID, AtikTuruID, Miktar, Birim, Tarih)
   VALUES (@KullaniciID, @AtikTuruID, @Miktar, 'kg', GETDATE());
END;

EXEC spAtikEkle @KullaniciID = 1, @AtikTuruID = 2, @Miktar = 1.5;
SELECT * FROM Atik WHERE KullaniciID = 1 AND AtikTuruID = 2 ORDER BY Tarih DESC;

SELECT * FROM Atik;
