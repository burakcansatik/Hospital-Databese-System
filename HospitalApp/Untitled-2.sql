

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
    

