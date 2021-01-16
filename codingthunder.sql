-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 15, 2021 at 09:54 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` bigint(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'test name', 'test@email.com', 33333333, 'this is test msg', '2021-01-15 14:23:20');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `tag_line` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tag_line`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Let\'s learn about stock markets', 'This is the first post', 'first-post', 'Stock (also capital stock) of a corporation is all of the shares into which ownership of the corporation is divided.[1] In American English, the shares are collectively known as \"stock\".[1] A single share of the stock represents fractional ownership of the corporation in proportion to the total number of shares. This typically entitles the stockholder to that fraction of the company\'s earnings, proceeds from liquidation of assets (after discharge of all senior claims such as secured and unsecured debt),[2] or voting power, often dividing these up in proportion to the amount of money each stockholder has invested. Not all stock is necessarily equal, as certain classes of stock may be issued for example without voting rights, with enhanced voting rights, or with a certain priority to receive profits or liquidation proceeds before or after other classes of shareholders.\r\n\r\nStock can be bought and sold privately or on stock exchanges, and such transactions are typically heavily regulated by governments to prevent fraud, protect investors, and benefit the larger economy. The stocks are deposited with the depositories in the electronic format also known as Demat account. As new shares are issued by a company, the ownership and rights of existing shareholders are diluted in return for cash to sustain or grow the business. Companies can also buy back stock, which often lets investors recoup the initial investment plus capital gains from subsequent rises in stock price. Stock options, issued by many companies as part of employee compensation, do not represent ownership, but represent the right to buy ownership at a future time at a specified price. This would represent a windfall to the employees if the option is exercised when the market price is higher than the promised price, since if they immediately sold the stock they would keep the difference (minus taxes).', 'post-bg.jpg', '2021-01-15 11:01:15'),
(2, 'This is second post', 'This is the second post', 'second-post', 'Jinja2 being a templating language has no need for wide choice of loop types so we only get for loop.\r\n\r\nFor loops start with {% for my_item in my_collection %} and end with {% endfor %}. This is very similar to how you\'d loop over an iterable in Python.\r\n\r\nHere my_item is a loop variable that will be taking values as we go over the elements. And my_collection is the name of the variable holding reference to the iterated collection.\r\n\r\nInside of the body of the loop we can use variable my_item in other control structures, like if conditional, or simply display it using {{ my_item }} statement.\r\n\r\nOk, but where would you use loops you ask? Using individual variables in your templates works fine for the most part but you might find that introducing hierarchy, and loops, will help with abstracting your data model.', 'home-bg.jpg', '2021-01-14 20:18:52'),
(3, 'Less secure app access', 'Less secure app access', 'less-secure-app-access', 'Some apps and devices use less secure sign-in technology, which makes your account vulnerable. You can turn off access for these apps, which we recommend, or turn it on if you want to use them despite the risks. Google will automatically turn this setting OFF if it’s not being used.', 'about-bg.jpg', '2021-01-14 20:27:35'),
(4, 'Looping Over Dictionaries', 'Looping Over Dictionaries', 'looping-over-dictionaries', 'Let\'s now see how we can loop over dictionaries. We will again use for loop construct, remember, that\'s all we\'ve got!\r\n\r\nWe can use the same syntax we used for iterating over elements of the list but here we\'ll iterate over dictionary keys. To retrieve value assigned to the key we need to use subscript, i.e. [], notation.\r\n\r\nOne advantage of using dictionaries over lists is that we can use names of elements as a reference, this makes retrieving objects and their values much easier.\r\n\r\nSay we used list to represent our collection of interfaces:', 'post-bg.jpg', '2021-01-14 20:28:25'),
(5, 'Comparisons', 'Comparisons', 'comparisons', 'First thing we look at is comparing values with conditionals, these make use of ==, !=, >, >=, <, <= operators. These are pretty standard but I will show some examples nonetheless.\r\n\r\nOne common scenario where comparison is used is varying command syntax based on the version, or vendor, of the installed OS. For instance some time ago Arista had to change a number of commands due to the lawsuit and we could use a simple if statement to make sure our templates work with all of the EOS versions:\r\n\r\nTemplate, vars, and rendered template for host using EOS 4.19:', 'home-bg.jpg', '2021-01-14 20:29:14'),
(6, 'Jinja (template engine)', 'Jinja', 'jinja-template-engine', 'Jinja is a web template engine for the Python programming language. It was created by Armin Ronacher and is licensed under a BSD License. Jinja is similar to the Django template engine but provides Python-like expressions while ensuring that the templates are evaluated in a sandbox. It is a text-based template language and thus can be used to generate any markup as well as source code.\r\n\r\nThe Jinja template engine allows customization of tags,[2] filters, tests, and globals.[3] Also, unlike the Django template engine, Jinja allows the template designer to call functions with arguments on objects. Jinja is Flask\'s default template engine [4] and it is also used by Ansible [5] and Trac.', 'about-bg.jpg', '2021-01-14 20:30:22'),
(8, 'How are you', 'kkjhej iol nohowln ioheownf', 'helf-mw', 'how are you', 'img.png', '2021-01-15 10:47:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
