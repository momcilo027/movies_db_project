-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 08, 2020 at 10:13 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movies`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `full_search` (IN `movie_title` VARCHAR(255), IN `movie_year` INT, IN `movie_ac_fname` VARCHAR(255), IN `movie_ac_lname` VARCHAR(255), IN `movie_rating` INT, IN `movie_price` INT, IN `movie_genre` INT, IN `movie_oscar` INT)  BEGIN
   SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar,m.price
   FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
   ON m.genre_id = g.id AND m.oscar_id = o.id
   WHERE m.title = movie_title AND m.year = movie_year AND m.fname = movie_ac_fname AND m.lname = movie_ac_lname AND m.rating = movie_rating AND m.price = movie_price AND m.genre_id = movie_genre AND m.oscar_id = movie_oscar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `min_max` (IN `min` INT, IN `max` INT)  BEGIN
	SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar, m.price
    FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
    ON m.genre_id = g.id AND m.oscar_id = o.id
	WHERE m.price < max AND m.price > min
	ORDER BY m.price ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `m_actor` (IN `actor_fname` VARCHAR(255), IN `actor_lname` VARCHAR(255))  BEGIN
	SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar, m.price
    FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
    ON m.genre_id = g.id AND m.oscar_id = o.id
	WHERE m.fname = actor_fname OR m.lname = actor_lname
	ORDER BY m.rating ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `m_full_actor` (IN `actor_fname` VARCHAR(255), IN `actor_lname` VARCHAR(255))  BEGIN
	SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar, m.price
    FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
    ON m.genre_id = g.id AND m.oscar_id = o.id
	WHERE m.fname = actor_fname AND m.lname = actor_lname
	ORDER BY m.rating ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `m_rating` (IN `movie_rating` INT)  BEGIN
	SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar, m.price
    FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
    ON m.genre_id = g.id AND m.oscar_id = o.id
	WHERE m.rating = movie_rating
	ORDER BY m.year ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `m_title` (IN `movie_title` VARCHAR(255))  BEGIN
	SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar, m.price
    FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
    ON m.genre_id = g.id AND m.oscar_id = o.id
	WHERE INSTR(m.title, movie_title) > 0
	ORDER BY m.rating ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `m_year` (IN `movie_year` INT)  BEGIN
	SELECT m.id, m.title, g.genre, m.year, m.fname, m.lname, m.rating, o.oscar, m.price
    FROM the_movies AS m INNER JOIN genres AS g INNER JOIN oscars AS o
    ON m.genre_id = g.id AND m.oscar_id = o.id
	WHERE m.year = movie_year
	ORDER BY m.rating ASC;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `full_name` (`f_name` CHAR(255), `l_name` CHAR(255)) RETURNS CHAR(255) CHARSET utf8mb4 RETURN CONCAT(f_name, ' ', l_name)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `action_view`
-- (See below for the actual view)
--
CREATE TABLE `action_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `comedy_view`
-- (See below for the actual view)
--
CREATE TABLE `comedy_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `genre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `genre`) VALUES
(0, 'Comedy'),
(1, 'Action'),
(2, 'Horror'),
(3, 'Sci-Fi'),
(4, 'Romantic'),
(5, 'Mystery');

-- --------------------------------------------------------

--
-- Stand-in structure for view `genre_view`
-- (See below for the actual view)
--
CREATE TABLE `genre_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `horror_view`
-- (See below for the actual view)
--
CREATE TABLE `horror_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mystery_view`
-- (See below for the actual view)
--
CREATE TABLE `mystery_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `oscars`
--

CREATE TABLE `oscars` (
  `id` int(11) NOT NULL,
  `oscar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oscars`
--

INSERT INTO `oscars` (`id`, `oscar`) VALUES
(0, 'No'),
(1, 'Yes');

-- --------------------------------------------------------

--
-- Stand-in structure for view `o_no_view`
-- (See below for the actual view)
--
CREATE TABLE `o_no_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `o_yes_view`
-- (See below for the actual view)
--
CREATE TABLE `o_yes_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `romantic_view`
-- (See below for the actual view)
--
CREATE TABLE `romantic_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `scifi_view`
-- (See below for the actual view)
--
CREATE TABLE `scifi_view` (
`id` int(11)
,`title` varchar(255)
,`genre` varchar(255)
,`year` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`rating` int(11)
,`oscar` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `the_movies`
--

CREATE TABLE `the_movies` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `oscar_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `the_movies`
--

INSERT INTO `the_movies` (`id`, `title`, `year`, `fname`, `lname`, `rating`, `price`, `genre_id`, `oscar_id`) VALUES
(12, 'INCEPTION', 2010, 'Leonardo', 'Di Caprio', 10, 700, 3, 1),
(13, 'THIS MEANS WAR', 2012, 'Tom', 'Hardy', 8, 350, 4, 0),
(14, 'SHUTTER ISLAND', 2010, 'Leonardo', 'Di Caprio', 9, 400, 5, 0),
(16, 'BLADE', 2006, 'Weasly', 'Snipes', 7, 300, 2, 0),
(32, 'IRON MAN', 2008, 'Robert', 'Downey JR', 9, 500, 3, 0),
(55, 'JUMANJI : WELCOM TO THE JUNGLE', 2017, 'Dwayne', 'Johnson', 7, 450, 0, 1),
(56, 'THOR : RANGAROK', 2017, 'Chris', 'Hemsworth', 8, 700, 0, 0),
(57, 'THE DICTATOR', 2012, 'Sacha', 'Baron', 6, 480, 0, 1),
(58, 'WAR DOGS', 2016, 'Jonah', 'Hill', 7, 500, 0, 0),
(59, 'CENTRAL INTELLIGENCE', 2016, 'Dwayne', 'Johnson', 6, 300, 0, 0),
(60, 'TED', 2012, 'Mark', 'Wahlberg', 10, 950, 0, 1),
(61, '21 JUMP STREET', 2012, 'Jonah', 'Hill', 9, 1000, 0, 1),
(62, '22 JUMP STREET', 2014, 'Jonah', 'Hill', 8, 600, 0, 0),
(63, 'TED 2', 2015, 'Mark', 'Wahlberg', 8, 450, 0, 0),
(64, 'TITANIC', 1997, 'Leonardo', 'Di Caprio', 10, 1000, 4, 1),
(65, 'THE REVENANT', 2015, 'Leonardo', 'Di Caprio', 8, 950, 1, 1),
(66, 'THE WOLF OF WALL STREET', 2013, 'Leonardo', 'Di Caprio', 9, 950, 0, 1),
(67, 'THE GREAT GATSBY', 2013, 'Leonardo', 'Di Caprio', 7, 350, 4, 0),
(68, 'BLOOD DIAMOND', 2006, 'Leonardo', 'Di Caprio', 9, 900, 1, 1),
(69, 'THE DEPARTED', 2006, 'Leonardo', 'Di Caprio', 9, 850, 5, 0),
(70, 'AVENGERS : END GAME', 2019, 'Robert', 'Downey JR', 10, 1100, 1, 0),
(71, 'SHERLOCK HOLMES', 2009, 'Robert', 'Downey JR', 6, 300, 5, 0),
(72, 'GOTHIKA', 2003, 'Robert', 'Downey JR', 9, 800, 5, 0),
(73, 'TRANSFORMERS : THE LAST KNIGHT', 2017, 'Mark', 'Wahlberg', 7, 350, 1, 0),
(74, '2 GUNS', 2013, 'Mark', 'Wahlberg', 8, 500, 1, 0),
(75, 'PAIN & GAIN', 2013, 'Mark', 'Wahlberg', 7, 850, 1, 1),
(76, 'THE FIGHTER', 2010, 'Mark', 'Wahlberg', 6, 300, 1, 0),
(77, 'THE CURIOUS CASE OF BENJAMIN BUTTON', 2008, 'Brad', 'Pitt', 8, 900, 4, 1),
(78, 'PASSENGERS', 2016, 'Jennifer', 'Lawrence', 9, 1000, 4, 1),
(79, 'I ORIGINS', 2016, 'Michael', 'Pitt', 7, 450, 4, 0),
(80, 'CLOSER', 2004, 'Natalie', 'Portman', 7, 300, 4, 0),
(81, 'CRAZY HEART', 2009, 'Jeff', 'Bridges', 7, 450, 4, 0),
(82, 'THE INVISIBLE MAN', 2020, 'Elisabeth', 'Moss', 7, 500, 2, 0),
(83, 'THE PLATFORM', 2019, 'Ivan', 'Massague', 7, 550, 2, 0),
(84, 'US', 2019, 'Lupita', 'Nyongo', 7, 550, 2, 0),
(85, 'HALLOWEEN', 2018, 'Jamie Lee', 'Curtis', 8, 800, 2, 0),
(86, 'KNIVES OUT', 2019, 'Daniel', 'Craig', 8, 750, 5, 0),
(87, 'AD ASTRA', 2019, 'Brad', 'Pitt', 6, 300, 5, 0),
(88, 'THE PRESTIGE', 2006, 'Christian', 'Bale', 9, 1000, 5, 1),
(89, 'THE CLOVERFIELD PARADOX', 2018, 'Daniel', 'Bruhi', 9, 650, 3, 0),
(90, 'CLOVERFIELD', 2008, 'Mike', 'Vogel', 7, 750, 3, 0),
(91, '10 CLOVERFIELD LANE', 2016, 'John', 'Goodman', 8, 800, 3, 0);

--
-- Triggers `the_movies`
--
DELIMITER $$
CREATE TRIGGER `tr_title` BEFORE INSERT ON `the_movies` FOR EACH ROW SET NEW.title = UPPER(NEW.title)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_title_update` BEFORE UPDATE ON `the_movies` FOR EACH ROW SET NEW.title = UPPER(NEW.title)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `action_view`
--
DROP TABLE IF EXISTS `action_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `action_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `g`.`genre` = 'Action' and `m`.`genre_id` = 1 and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `comedy_view`
--
DROP TABLE IF EXISTS `comedy_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `comedy_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `g`.`genre` = 'Comedy' and `m`.`genre_id` = 0 and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `genre_view`
--
DROP TABLE IF EXISTS `genre_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `genre_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `m`.`genre_id` = `g`.`id` and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `horror_view`
--
DROP TABLE IF EXISTS `horror_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horror_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `g`.`genre` = 'Horror' and `m`.`genre_id` = 2 and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `mystery_view`
--
DROP TABLE IF EXISTS `mystery_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mystery_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `g`.`genre` = 'Mystery' and `m`.`genre_id` = 5 and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `o_no_view`
--
DROP TABLE IF EXISTS `o_no_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `o_no_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `o`.`oscar` = 'No' and `m`.`oscar_id` = 0 and `m`.`genre_id` = `g`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `o_yes_view`
--
DROP TABLE IF EXISTS `o_yes_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `o_yes_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `o`.`oscar` = 'Yes' and `m`.`oscar_id` = 1 and `m`.`genre_id` = `g`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `romantic_view`
--
DROP TABLE IF EXISTS `romantic_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `romantic_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `g`.`genre` = 'Romantic' and `m`.`genre_id` = 4 and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `scifi_view`
--
DROP TABLE IF EXISTS `scifi_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `scifi_view`  AS  select `m`.`id` AS `id`,`m`.`title` AS `title`,`g`.`genre` AS `genre`,`m`.`year` AS `year`,`m`.`fname` AS `fname`,`m`.`lname` AS `lname`,`m`.`rating` AS `rating`,`o`.`oscar` AS `oscar`,`m`.`price` AS `price` from ((`the_movies` `m` join `genres` `g`) join `oscars` `o`) where `g`.`genre` = 'Sci-Fi' and `m`.`genre_id` = 3 and `m`.`oscar_id` = `o`.`id` order by `m`.`id` desc ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oscars`
--
ALTER TABLE `oscars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `the_movies`
--
ALTER TABLE `the_movies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genre_id` (`genre_id`),
  ADD KEY `oscar_id` (`oscar_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oscars`
--
ALTER TABLE `oscars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `the_movies`
--
ALTER TABLE `the_movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `the_movies`
--
ALTER TABLE `the_movies`
  ADD CONSTRAINT `the_movies_ibfk_1` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  ADD CONSTRAINT `the_movies_ibfk_2` FOREIGN KEY (`oscar_id`) REFERENCES `oscars` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
