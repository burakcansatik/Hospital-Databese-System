-- Create and use database
CREATE DATABASE IF NOT EXISTS HospitalIDB;
USE HospitalIDB;

-- Patients Table
CREATE TABLE IF NOT EXISTS Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    PhoneNumber VARCHAR(15),
);

-- Doctors Table
CREATE TABLE IF NOT EXISTS Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(50),
    PhoneNumber VARCHAR(15)
);

-- Appointments Table
CREATE TABLE IF NOT EXISTS Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime VARCHAR(10),
    Reason VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Insert Sample Data
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Gender, PhoneNumber)
VALUES 
(1, 'Ali', 'Veli', '1990-05-14', 'Male', '555-1234'),
(2, 'Ayşe', 'Yılmaz', '1985-11-20', 'Female', '555-5678'),
(3, 'Ahmet', 'Demir', '1975-03-22', 'Male', '555-1010'),
(4, 'Fatma', 'Çelik', '1988-07-30', 'Female', '555-2020'),
(5, 'Mehmet', 'Öztürk', '1995-12-15', 'Male', '555-3030');

INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialty, PhoneNumber)
VALUES 
(1, 'Mehmet', 'Kara', 'Cardiologist', '555-8765'),
(2, 'Fatma', 'Beyaz', 'Dermatologist', '555-4321'),
(3, 'Ayhan', 'Sarı', 'Neurologist', '555-9999'),
(4, 'Selin', 'Yeşil', 'Pediatrician', '555-8888');

INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, Reason)
VALUES 
(1, 1, 1, '2024-07-10', '10:00', 'Heart Checkup'),
(2, 2, 2, '2024-07-11', '11:00', 'Skin Issue'),
(3, 3, 3, '2024-07-12', '09:00', 'Headache'),
(4, 4, 4, '2024-07-13', '14:00', 'Child Checkup'),
(5, 5, 1, '2024-07-14', '16:00', 'Blood Pressure Problem'),
(6, 1, 3, '2024-07-15', '08:00', 'Dizziness'),
(7, 2, 4, '2024-07-16', '13:00', 'Child Vaccination');

-- Update Data
UPDATE Patients
SET PhoneNumber = '555-9999'
WHERE PatientID = 1;

-- Delete Data
DELETE FROM Appointments
WHERE AppointmentID = 2;

-- Query Data
-- List all Patients
SELECT * FROM Patients;

-- List Appointments of a Specific Doctor (For example, DoctorID = 1)
SELECT 
    a.AppointmentID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Reason
FROM
    Appointments a
        JOIN Patients p ON a.PatientID = p.PatientID
WHERE
    a.DoctorID = 1;

-- List Appointments within a Specific Date Range (For example, between '2024-07-10' and '2024-07-20')
SELECT 
    a.AppointmentID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    p.PhoneNumber,
    d.FirstName AS DoctorFirstName,
    d.LastName AS DoctorLastName,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Reason,
    CASE 
        WHEN p.Gender = 'Male' THEN 'M'
        WHEN p.Gender = 'Female' THEN 'F'
        ELSE 'Unknown'
    END AS Gender
FROM
    Appointments a
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE
    a.AppointmentDate BETWEEN '2024-07-10' AND '2024-07-20';

