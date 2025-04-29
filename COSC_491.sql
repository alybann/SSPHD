USE COSC_491;

CREATE TABLE `patients` (
  `nin` int PRIMARY KEY,
  `last_name` varchar(255),
  `first_name` varchar(255),
  `parish_id` int,
  `village_id` int,
  `dob` date,
  `sex` ENUM ('male', 'female'),
  `emergency_contact_id` int,
  `consent` boolean
);

CREATE TABLE `diseases` (
  `id` int PRIMARY KEY,
  `name` varchar(255) UNIQUE,
  `disease_type` ENUM ('reportable', 'infectious', 'noninfectious', 'maternal_perinatal', 'miscellaneous', 'cough', 'tuberculosis', 'other')
);

CREATE TABLE `vaccinations` (
  `id` int PRIMARY KEY,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `diseases_patients` (
  `id` int PRIMARY KEY,
  `patient_id` int,
  `disease_id` int,
  `first_reported_date` date,
  `last_confirmed_date` date
);

CREATE TABLE `vaccinations_patients` (
  `id` int PRIMARY KEY,
  `patient_id` int,
  `vaccination_id` int,
  `first_reported_date` date,
  `last_confirmed_date` date
);

CREATE TABLE `parishes` (
  `id` int PRIMARY KEY,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `villages` (
  `id` int PRIMARY KEY,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `emergency_contacts` (
  `id` int PRIMARY KEY,
  `last_name` varchar(255),
  `first_name` varchar(255),
  `relationship` varchar(255),
  `phone_num` varchar(255),
  `parish_id` int,
  `village_id` int
);

CREATE TABLE `scanned_files` (
  `id` int PRIMARY KEY,
  `patient_id` int,
  `file_data` blob,
  `uploaded_at` timestamp,
  `file_text` varchar(255)
);

CREATE TABLE `users` (
  `id` int PRIMARY KEY,
  `username` varchar(255) UNIQUE,
  `password` varchar(255),
  `role` varchar(255)
);

CREATE TABLE `permissions` (
  `id` int PRIMARY KEY,
  `role` ENUM ('admin', 'doctor', 'nurse', 'its', 'patient'),
  `can_view_patients` bool,
  `can_edit_patients` bool,
  `can_view_files` bool,
  `can_edit_files` bool
);

CREATE TABLE `access_logs` (
  `id` int PRIMARY KEY,
  `user_id` int,
  `action` varchar(255),
  `patient_id` int,
  `timestamp` timestamp
);

ALTER TABLE `patients` ADD FOREIGN KEY (`parish_id`) REFERENCES `parishes` (`id`);

ALTER TABLE `patients` ADD FOREIGN KEY (`village_id`) REFERENCES `villages` (`id`);

ALTER TABLE `patients` ADD FOREIGN KEY (`emergency_contact_id`) REFERENCES `emergency_contacts` (`id`);

ALTER TABLE `diseases_patients` ADD FOREIGN KEY (`patient_id`) REFERENCES `patients` (`nin`);

ALTER TABLE `diseases_patients` ADD FOREIGN KEY (`disease_id`) REFERENCES `diseases` (`id`);

ALTER TABLE `vaccinations_patients` ADD FOREIGN KEY (`patient_id`) REFERENCES `patients` (`nin`);

ALTER TABLE `vaccinations_patients` ADD FOREIGN KEY (`vaccination_id`) REFERENCES `vaccinations` (`id`);

ALTER TABLE `emergency_contacts` ADD FOREIGN KEY (`parish_id`) REFERENCES `parishes` (`id`);

ALTER TABLE `emergency_contacts` ADD FOREIGN KEY (`village_id`) REFERENCES `villages` (`id`);

ALTER TABLE `scanned_files` ADD FOREIGN KEY (`patient_id`) REFERENCES `patients` (`nin`);

ALTER TABLE `access_logs` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `access_logs` ADD FOREIGN KEY (`patient_id`) REFERENCES `patients` (`nin`);
