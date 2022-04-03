-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Apr 2022 pada 12.10
-- Versi server: 10.4.21-MariaDB
-- Versi PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `raunraun.0.1`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `airport`
--

CREATE TABLE `airport` (
  `airport_id` int(11) NOT NULL,
  `airport_name` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `crew`
--

CREATE TABLE `crew` (
  `Crew_Id` int(11) NOT NULL,
  `NIP` int(32) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Birth_Date` date DEFAULT NULL,
  `Entry_Date` date DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Phone_Number` int(32) DEFAULT NULL,
  `Crew_type` varchar(255) DEFAULT NULL,
  `Realization_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `flightclass`
--

CREATE TABLE `flightclass` (
  `class_id` int(11) NOT NULL,
  `class` varchar(255) DEFAULT NULL,
  `cost` int(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `parking_airport`
--

CREATE TABLE `parking_airport` (
  `parking_airport_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `plane`
--

CREATE TABLE `plane` (
  `Plane_ID` int(11) NOT NULL,
  `Plane_Status` varchar(255) DEFAULT NULL,
  `Plane_Type_ID` int(11) DEFAULT NULL,
  `parking_airport_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `planetype`
--

CREATE TABLE `planetype` (
  `plane_type_ID` int(11) NOT NULL,
  `Class_ID` int(11) DEFAULT NULL,
  `Name_type` varchar(255) DEFAULT NULL,
  `Type_Machine` varchar(255) DEFAULT NULL,
  `Capacity` int(32) DEFAULT NULL,
  `Dimension` int(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `realization`
--

CREATE TABLE `realization` (
  `Realization_ID` int(11) NOT NULL,
  `Schedule_ID` int(11) DEFAULT NULL,
  `Real_time_departure` datetime DEFAULT NULL,
  `Real_time_arrival` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `schedule`
--

CREATE TABLE `schedule` (
  `Schedule_ID` int(11) NOT NULL,
  `Plane_ID` int(11) DEFAULT NULL,
  `airport_ID` int(11) DEFAULT NULL,
  `Departure` datetime DEFAULT NULL,
  `Arrival` datetime DEFAULT NULL,
  `Destination_Airport` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`airport_id`);

--
-- Indeks untuk tabel `crew`
--
ALTER TABLE `crew`
  ADD PRIMARY KEY (`Crew_Id`),
  ADD KEY `Realization_ID` (`Realization_ID`);

--
-- Indeks untuk tabel `flightclass`
--
ALTER TABLE `flightclass`
  ADD PRIMARY KEY (`class_id`);

--
-- Indeks untuk tabel `parking_airport`
--
ALTER TABLE `parking_airport`
  ADD KEY `parking_airport_ID` (`parking_airport_ID`);

--
-- Indeks untuk tabel `plane`
--
ALTER TABLE `plane`
  ADD PRIMARY KEY (`Plane_ID`),
  ADD KEY `Plane_Type_ID` (`Plane_Type_ID`),
  ADD KEY `airport_ID` (`parking_airport_ID`),
  ADD KEY `parking_airport_ID` (`parking_airport_ID`);

--
-- Indeks untuk tabel `planetype`
--
ALTER TABLE `planetype`
  ADD PRIMARY KEY (`plane_type_ID`),
  ADD KEY `Class_ID` (`Class_ID`);

--
-- Indeks untuk tabel `realization`
--
ALTER TABLE `realization`
  ADD PRIMARY KEY (`Realization_ID`),
  ADD KEY `Schedule_ID` (`Schedule_ID`);

--
-- Indeks untuk tabel `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`Schedule_ID`),
  ADD KEY `Plane_ID` (`Plane_ID`),
  ADD KEY `airport_ID` (`airport_ID`),
  ADD KEY `Destination_Airport` (`Destination_Airport`),
  ADD KEY `airport_ID_2` (`airport_ID`),
  ADD KEY `Plane_ID_2` (`Plane_ID`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `crew_ibfk_1` FOREIGN KEY (`Realization_ID`) REFERENCES `realization` (`Realization_ID`);

--
-- Ketidakleluasaan untuk tabel `parking_airport`
--
ALTER TABLE `parking_airport`
  ADD CONSTRAINT `parking_airport_ibfk_1` FOREIGN KEY (`parking_airport_ID`) REFERENCES `airport` (`airport_id`);

--
-- Ketidakleluasaan untuk tabel `plane`
--
ALTER TABLE `plane`
  ADD CONSTRAINT `plane_ibfk_1` FOREIGN KEY (`Plane_Type_ID`) REFERENCES `planetype` (`plane_type_ID`),
  ADD CONSTRAINT `plane_ibfk_2` FOREIGN KEY (`parking_airport_ID`) REFERENCES `parking_airport` (`parking_airport_ID`);

--
-- Ketidakleluasaan untuk tabel `planetype`
--
ALTER TABLE `planetype`
  ADD CONSTRAINT `planetype_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `flightclass` (`class_id`);

--
-- Ketidakleluasaan untuk tabel `realization`
--
ALTER TABLE `realization`
  ADD CONSTRAINT `realization_ibfk_1` FOREIGN KEY (`Schedule_ID`) REFERENCES `schedule` (`Schedule_ID`);

--
-- Ketidakleluasaan untuk tabel `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`airport_ID`) REFERENCES `airport` (`airport_id`),
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`Plane_ID`) REFERENCES `plane` (`Plane_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
