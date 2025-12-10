-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2025 at 02:19 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iwabeza_safari`
--

-- --------------------------------------------------------

--
-- Table structure for table `accommodation`
--

CREATE TABLE `accommodation` (
  `accommodation_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `location` varchar(120) DEFAULT NULL,
  `price_range` varchar(50) DEFAULT NULL,
  `destination_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accommodation`
--

INSERT INTO `accommodation` (`accommodation_id`, `name`, `type`, `location`, `price_range`, `destination_id`) VALUES
(1, 'Akagera Lodge', 'Hotel', 'Akagera Park Entrance', '$100-$200', 1);

-- --------------------------------------------------------

--
-- Table structure for table `admin_accounts`
--

CREATE TABLE `admin_accounts` (
  `admin_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(80) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `role` varchar(50) NOT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_accounts`
--

INSERT INTO `admin_accounts` (`admin_id`, `username`, `password_hash`, `role`, `status`) VALUES
(1, 'admin1', 'securehash456', 'superadmin', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `analytics`
--

CREATE TABLE `analytics` (
  `analytics_id` int(10) UNSIGNED NOT NULL,
  `metric_name` varchar(100) NOT NULL,
  `value` decimal(12,2) DEFAULT NULL,
  `date` date NOT NULL,
  `dimensions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dimensions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `analytics`
--

INSERT INTO `analytics` (`analytics_id`, `metric_name`, `value`, `date`, `dimensions`) VALUES
(1, 'Monthly Revenue', 1000.00, '2025-12-01', '{\"destination\": \"Akagera\", \"currency\": \"USD\"}');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `tour_id` int(10) UNSIGNED DEFAULT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL,
  `party_size` int(11) DEFAULT 1,
  `approved_by` int(10) UNSIGNED DEFAULT NULL
) ;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `customer_id`, `tour_id`, `booking_date`, `status`, `party_size`, `approved_by`) VALUES
(1, 1, 1, '2025-12-07 13:08:52', 'confirmed', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cancelled_events`
--

CREATE TABLE `cancelled_events` (
  `cancelled_event_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `cancel_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `reason` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cancelled_events`
--

INSERT INTO `cancelled_events` (`cancelled_event_id`, `event_id`, `user_id`, `cancel_date`, `reason`) VALUES
(1, 1, 1, '2025-12-07 13:08:52', 'Weather conditions');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `nationality` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `full_name`, `email`, `phone`, `age`, `nationality`) VALUES
(1, 'John Doe', 'john.doe@example.com', '+250788123456', 30, 'Rwandan');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `destination_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `region` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`destination_id`, `name`, `region`, `description`) VALUES
(1, 'Akagera National Park', 'Eastern Rwanda', 'Home to the Big Five and savannah landscapes');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(10) UNSIGNED NOT NULL,
  `event_name` varchar(150) NOT NULL,
  `location` varchar(120) DEFAULT NULL,
  `event_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(60) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `event_name`, `location`, `event_date`, `description`, `category`, `created_by`) VALUES
(1, 'Cultural Dance Show', 'Kigali', '2025-12-18', 'Traditional Rwandan dance performance', 'Culture', 1);

-- --------------------------------------------------------

--
-- Table structure for table `event_tickets`
--

CREATE TABLE `event_tickets` (
  `event_ticket_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `price` decimal(12,2) NOT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_tickets`
--

INSERT INTO `event_tickets` (`event_ticket_id`, `event_id`, `user_id`, `purchase_date`, `price`, `status`) VALUES
(1, 1, 1, '2025-12-07 13:08:52', 30.00, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `faq_id` int(10) UNSIGNED NOT NULL,
  `question` varchar(200) NOT NULL,
  `answer` text NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`faq_id`, `question`, `answer`, `created_by`) VALUES
(1, 'What should I pack for safari?', 'Light clothing, binoculars, sunscreen, and a hat.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `guides`
--

CREATE TABLE `guides` (
  `guide_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `languages` varchar(150) DEFAULT NULL,
  `experience_years` int(11) DEFAULT NULL,
  `contact_info` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guides`
--

INSERT INTO `guides` (`guide_id`, `full_name`, `languages`, `experience_years`, `contact_info`) VALUES
(1, 'Alice Safari', 'English, Kinyarwanda', 5, 'alice@safari.com');

-- --------------------------------------------------------

--
-- Table structure for table `itineraries`
--

CREATE TABLE `itineraries` (
  `itinerary_id` int(10) UNSIGNED NOT NULL,
  `tour_id` int(10) UNSIGNED DEFAULT NULL,
  `day_number` int(11) NOT NULL,
  `activity` varchar(200) NOT NULL,
  `location` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `itineraries`
--

INSERT INTO `itineraries` (`itinerary_id`, `tour_id`, `day_number`, `activity`, `location`) VALUES
(1, 1, 1, 'Game drive in Akagera', 'Akagera National Park');

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `match_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL,
  `team_a` varchar(120) NOT NULL,
  `team_b` varchar(120) NOT NULL,
  `match_date` date NOT NULL,
  `location` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`match_id`, `event_id`, `team_a`, `team_b`, `match_date`, `location`) VALUES
(1, 1, 'Team Lions', 'Team Elephants', '2025-12-19', 'Akagera Stadium');

-- --------------------------------------------------------

--
-- Table structure for table `match_tickets`
--

CREATE TABLE `match_tickets` (
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `match_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `seat_number` varchar(20) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `match_tickets`
--

INSERT INTO `match_tickets` (`ticket_id`, `match_id`, `user_id`, `purchase_date`, `seat_number`, `price`, `status`) VALUES
(1, 1, 1, '2025-12-07 13:08:52', 'A12', 50.00, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `media_gallery`
--

CREATE TABLE `media_gallery` (
  `media_id` int(10) UNSIGNED NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `type` varchar(30) NOT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `linked_tour_id` int(10) UNSIGNED DEFAULT NULL,
  `linked_destination_id` int(10) UNSIGNED DEFAULT NULL,
  `uploaded_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media_gallery`
--

INSERT INTO `media_gallery` (`media_id`, `file_path`, `type`, `caption`, `linked_tour_id`, `linked_destination_id`, `uploaded_by`) VALUES
(1, '/images/akagera_safari.jpg', 'image', 'Safari Jeep in Akagera', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `message` varchar(250) NOT NULL,
  `date_sent` timestamp NOT NULL DEFAULT current_timestamp(),
  `channel` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `message`, `date_sent`, `channel`) VALUES
(1, 1, 'Your booking is confirmed!', '2025-12-07 13:08:52', 'email');

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `package_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`package_id`, `name`, `description`, `price`, `created_by`) VALUES
(1, 'Luxury Safari Package', 'Includes tours, accommodation, and cultural events', 1500.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `package_accommodation`
--

CREATE TABLE `package_accommodation` (
  `package_id` int(10) UNSIGNED NOT NULL,
  `accommodation_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `package_accommodation`
--

INSERT INTO `package_accommodation` (`package_id`, `accommodation_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `package_tours`
--

CREATE TABLE `package_tours` (
  `package_id` int(10) UNSIGNED NOT NULL,
  `tour_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `package_tours`
--

INSERT INTO `package_tours` (`package_id`, `tour_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `partner_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `contact_info` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `partners`
--

INSERT INTO `partners` (`partner_id`, `name`, `type`, `contact_info`) VALUES
(1, 'Wildlife Adventures Ltd', 'Tour Operator', 'info@wildlifeadventures.com');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(10) UNSIGNED NOT NULL,
  `booking_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `method` varchar(40) NOT NULL,
  `status` varchar(20) DEFAULT 'completed',
  `processed_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `amount`, `payment_date`, `method`, `status`, `processed_by`) VALUES
(1, 1, 1000.00, '2025-12-07 13:08:52', 'Credit Card', 'completed', 1);

-- --------------------------------------------------------

--
-- Table structure for table `permits`
--

CREATE TABLE `permits` (
  `permit_id` int(10) UNSIGNED NOT NULL,
  `tour_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(60) NOT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'issued',
  `issued_by` int(10) UNSIGNED DEFAULT NULL
) ;

--
-- Dumping data for table `permits`
--

INSERT INTO `permits` (`permit_id`, `tour_id`, `type`, `issue_date`, `expiry_date`, `status`, `issued_by`) VALUES
(1, 1, 'Park Entry', '2025-12-15', '2025-12-20', 'issued', 1);

-- --------------------------------------------------------

--
-- Table structure for table `policies`
--

CREATE TABLE `policies` (
  `policy_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `policies`
--

INSERT INTO `policies` (`policy_id`, `title`, `description`, `effective_date`, `created_by`) VALUES
(1, 'Cancellation Policy', 'Cancellations must be made 7 days before the tour.', '2025-12-01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `tour_id` int(10) UNSIGNED DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `review_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `customer_id`, `tour_id`, `rating`, `comment`, `review_date`) VALUES
(1, 1, 1, 5, 'Amazing safari experience!', '2025-12-07 13:08:52');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `role` varchar(80) NOT NULL,
  `contact_info` varchar(150) DEFAULT NULL,
  `partner_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `full_name`, `role`, `contact_info`, `partner_id`) VALUES
(1, 'Michael Safari', 'Driver', 'michael@safari.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `subject` varchar(150) NOT NULL,
  `status` varchar(20) DEFAULT 'open',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `handled_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`ticket_id`, `user_id`, `subject`, `status`, `created_date`, `updated_date`, `handled_by`) VALUES
(1, 1, 'Payment issue', 'open', '2025-12-07 13:08:52', '2025-12-07 13:08:52', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tours`
--

CREATE TABLE `tours` (
  `tour_id` int(10) UNSIGNED NOT NULL,
  `tour_name` varchar(150) NOT NULL,
  `destination_id` int(10) UNSIGNED DEFAULT NULL,
  `partner_id` int(10) UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `min_age` int(11) DEFAULT 18,
  `max_age` int(11) DEFAULT 25,
  `capacity` int(11) DEFAULT NULL,
  `base_price` decimal(12,2) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL
) ;

--
-- Dumping data for table `tours`
--

INSERT INTO `tours` (`tour_id`, `tour_name`, `destination_id`, `partner_id`, `start_date`, `end_date`, `min_age`, `max_age`, `capacity`, `base_price`, `created_by`) VALUES
(1, 'Akagera Safari Experience', 1, 1, '2025-12-15', '2025-12-20', 18, 60, 20, 500.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tour_events`
--

CREATE TABLE `tour_events` (
  `tour_event_id` int(10) UNSIGNED NOT NULL,
  `tour_id` int(10) UNSIGNED DEFAULT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tour_events`
--

INSERT INTO `tour_events` (`tour_event_id`, `tour_id`, `event_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tour_guides`
--

CREATE TABLE `tour_guides` (
  `tour_id` int(10) UNSIGNED NOT NULL,
  `guide_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tour_guides`
--

INSERT INTO `tour_guides` (`tour_id`, `guide_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `transport`
--

CREATE TABLE `transport` (
  `transport_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `provider` varchar(120) DEFAULT NULL,
  `tour_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport`
--

INSERT INTO `transport` (`transport_id`, `type`, `capacity`, `provider`, `tour_id`) VALUES
(1, 'Safari Jeep', 6, 'Wildlife Adventures Ltd', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_accounts`
--

CREATE TABLE `user_accounts` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `username` varchar(80) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`user_id`, `customer_id`, `username`, `password_hash`, `status`) VALUES
(1, 1, 'johndoe', 'hashedpassword123', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accommodation`
--
ALTER TABLE `accommodation`
  ADD PRIMARY KEY (`accommodation_id`),
  ADD KEY `fk_accommodation_destination` (`destination_id`);

--
-- Indexes for table `admin_accounts`
--
ALTER TABLE `admin_accounts`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `analytics`
--
ALTER TABLE `analytics`
  ADD PRIMARY KEY (`analytics_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `fk_booking_customer` (`customer_id`),
  ADD KEY `fk_booking_tour` (`tour_id`),
  ADD KEY `fk_booking_admin` (`approved_by`);

--
-- Indexes for table `cancelled_events`
--
ALTER TABLE `cancelled_events`
  ADD PRIMARY KEY (`cancelled_event_id`),
  ADD KEY `fk_cancelled_event` (`event_id`),
  ADD KEY `fk_cancelled_user` (`user_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`destination_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `fk_event_admin` (`created_by`);

--
-- Indexes for table `event_tickets`
--
ALTER TABLE `event_tickets`
  ADD PRIMARY KEY (`event_ticket_id`),
  ADD KEY `fk_eventticket_event` (`event_id`),
  ADD KEY `fk_eventticket_user` (`user_id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`faq_id`),
  ADD KEY `fk_faq_admin` (`created_by`);

--
-- Indexes for table `guides`
--
ALTER TABLE `guides`
  ADD PRIMARY KEY (`guide_id`);

--
-- Indexes for table `itineraries`
--
ALTER TABLE `itineraries`
  ADD PRIMARY KEY (`itinerary_id`),
  ADD KEY `fk_itinerary_tour` (`tour_id`);

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`match_id`),
  ADD UNIQUE KEY `event_id` (`event_id`);

--
-- Indexes for table `match_tickets`
--
ALTER TABLE `match_tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `fk_matchticket_match` (`match_id`),
  ADD KEY `fk_matchticket_user` (`user_id`);

--
-- Indexes for table `media_gallery`
--
ALTER TABLE `media_gallery`
  ADD PRIMARY KEY (`media_id`),
  ADD KEY `fk_media_tour` (`linked_tour_id`),
  ADD KEY `fk_media_destination` (`linked_destination_id`),
  ADD KEY `fk_media_admin` (`uploaded_by`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `fk_notification_user` (`user_id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`package_id`),
  ADD KEY `fk_package_admin` (`created_by`);

--
-- Indexes for table `package_accommodation`
--
ALTER TABLE `package_accommodation`
  ADD PRIMARY KEY (`package_id`,`accommodation_id`),
  ADD KEY `fk_packageaccommodation_accommodation` (`accommodation_id`);

--
-- Indexes for table `package_tours`
--
ALTER TABLE `package_tours`
  ADD PRIMARY KEY (`package_id`,`tour_id`),
  ADD KEY `fk_packagetour_tour` (`tour_id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`partner_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payment_booking` (`booking_id`),
  ADD KEY `fk_payment_admin` (`processed_by`);

--
-- Indexes for table `permits`
--
ALTER TABLE `permits`
  ADD PRIMARY KEY (`permit_id`),
  ADD KEY `fk_permit_tour` (`tour_id`),
  ADD KEY `fk_permit_admin` (`issued_by`);

--
-- Indexes for table `policies`
--
ALTER TABLE `policies`
  ADD PRIMARY KEY (`policy_id`),
  ADD KEY `fk_policy_admin` (`created_by`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `fk_review_customer` (`customer_id`),
  ADD KEY `fk_review_tour` (`tour_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `fk_staff_partner` (`partner_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `fk_support_user` (`user_id`),
  ADD KEY `fk_support_admin` (`handled_by`);

--
-- Indexes for table `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`tour_id`),
  ADD KEY `fk_tour_destination` (`destination_id`),
  ADD KEY `fk_tour_partner` (`partner_id`),
  ADD KEY `fk_tour_admin` (`created_by`);

--
-- Indexes for table `tour_events`
--
ALTER TABLE `tour_events`
  ADD PRIMARY KEY (`tour_event_id`),
  ADD KEY `fk_tourevent_tour` (`tour_id`),
  ADD KEY `fk_tourevent_event` (`event_id`);

--
-- Indexes for table `tour_guides`
--
ALTER TABLE `tour_guides`
  ADD PRIMARY KEY (`tour_id`,`guide_id`),
  ADD KEY `fk_tourguide_guide` (`guide_id`);

--
-- Indexes for table `transport`
--
ALTER TABLE `transport`
  ADD PRIMARY KEY (`transport_id`),
  ADD KEY `fk_transport_tour` (`tour_id`);

--
-- Indexes for table `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accommodation`
--
ALTER TABLE `accommodation`
  MODIFY `accommodation_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_accounts`
--
ALTER TABLE `admin_accounts`
  MODIFY `admin_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `analytics`
--
ALTER TABLE `analytics`
  MODIFY `analytics_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cancelled_events`
--
ALTER TABLE `cancelled_events`
  MODIFY `cancelled_event_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `destination_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `event_tickets`
--
ALTER TABLE `event_tickets`
  MODIFY `event_ticket_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `faq_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `guides`
--
ALTER TABLE `guides`
  MODIFY `guide_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `itineraries`
--
ALTER TABLE `itineraries`
  MODIFY `itinerary_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `matches`
--
ALTER TABLE `matches`
  MODIFY `match_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `match_tickets`
--
ALTER TABLE `match_tickets`
  MODIFY `ticket_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `media_gallery`
--
ALTER TABLE `media_gallery`
  MODIFY `media_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `package_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `partner_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permits`
--
ALTER TABLE `permits`
  MODIFY `permit_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `policies`
--
ALTER TABLE `policies`
  MODIFY `policy_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `ticket_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tours`
--
ALTER TABLE `tours`
  MODIFY `tour_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tour_events`
--
ALTER TABLE `tour_events`
  MODIFY `tour_event_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transport`
--
ALTER TABLE `transport`
  MODIFY `transport_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_accounts`
--
ALTER TABLE `user_accounts`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accommodation`
--
ALTER TABLE `accommodation`
  ADD CONSTRAINT `fk_accommodation_destination` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`) ON DELETE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_booking_admin` FOREIGN KEY (`approved_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_booking_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_booking_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `cancelled_events`
--
ALTER TABLE `cancelled_events`
  ADD CONSTRAINT `fk_cancelled_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cancelled_user` FOREIGN KEY (`user_id`) REFERENCES `user_accounts` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_event_admin` FOREIGN KEY (`created_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL;

--
-- Constraints for table `event_tickets`
--
ALTER TABLE `event_tickets`
  ADD CONSTRAINT `fk_eventticket_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_eventticket_user` FOREIGN KEY (`user_id`) REFERENCES `user_accounts` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `fk_faq_admin` FOREIGN KEY (`created_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL;

--
-- Constraints for table `itineraries`
--
ALTER TABLE `itineraries`
  ADD CONSTRAINT `fk_itinerary_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `fk_match_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `match_tickets`
--
ALTER TABLE `match_tickets`
  ADD CONSTRAINT `fk_matchticket_match` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_matchticket_user` FOREIGN KEY (`user_id`) REFERENCES `user_accounts` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `media_gallery`
--
ALTER TABLE `media_gallery`
  ADD CONSTRAINT `fk_media_admin` FOREIGN KEY (`uploaded_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_media_destination` FOREIGN KEY (`linked_destination_id`) REFERENCES `destinations` (`destination_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_media_tour` FOREIGN KEY (`linked_tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `user_accounts` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `packages`
--
ALTER TABLE `packages`
  ADD CONSTRAINT `fk_package_admin` FOREIGN KEY (`created_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL;

--
-- Constraints for table `package_accommodation`
--
ALTER TABLE `package_accommodation`
  ADD CONSTRAINT `fk_packageaccommodation_accommodation` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodation` (`accommodation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_packageaccommodation_package` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON DELETE CASCADE;

--
-- Constraints for table `package_tours`
--
ALTER TABLE `package_tours`
  ADD CONSTRAINT `fk_packagetour_package` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_packagetour_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payment_admin` FOREIGN KEY (`processed_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payment_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE;

--
-- Constraints for table `permits`
--
ALTER TABLE `permits`
  ADD CONSTRAINT `fk_permit_admin` FOREIGN KEY (`issued_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_permit_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `policies`
--
ALTER TABLE `policies`
  ADD CONSTRAINT `fk_policy_admin` FOREIGN KEY (`created_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_review_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_review_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `fk_staff_partner` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`partner_id`) ON DELETE SET NULL;

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `fk_support_admin` FOREIGN KEY (`handled_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_support_user` FOREIGN KEY (`user_id`) REFERENCES `user_accounts` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `tours`
--
ALTER TABLE `tours`
  ADD CONSTRAINT `fk_tour_admin` FOREIGN KEY (`created_by`) REFERENCES `admin_accounts` (`admin_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tour_destination` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`destination_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tour_partner` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`partner_id`) ON DELETE SET NULL;

--
-- Constraints for table `tour_events`
--
ALTER TABLE `tour_events`
  ADD CONSTRAINT `fk_tourevent_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tourevent_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `tour_guides`
--
ALTER TABLE `tour_guides`
  ADD CONSTRAINT `fk_tourguide_guide` FOREIGN KEY (`guide_id`) REFERENCES `guides` (`guide_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tourguide_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `transport`
--
ALTER TABLE `transport`
  ADD CONSTRAINT `fk_transport_tour` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`tour_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD CONSTRAINT `fk_user_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
