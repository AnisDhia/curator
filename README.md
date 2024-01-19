# Curator - Library Management Desktop App

## Overview
Curator is a library management desktop application built with Flutter that aims to simplify the process of managing library resources, documents, subscribers, and book lending. While the project is currently unfinished, it provides a functional interface to view documents, track subscribers, monitor book lending, and analyze various statistics related to library activities.

## Features
- **Document Management:** Browse and view all available documents in the library.

- **Subscriber Tracking:** Keep track of library subscribers and their information.

- **Book Lending:** Monitor the lending status of books and keep records of borrowed items.

- **Statistics:** View various statistics related to library activities, including the number of books lent, overdue books, and more.

## Screenshots
![Screenshot 1](/screenshots/Screenshot%202024-01-19%20173407.png?raw=true "Screenshot 1")

Dashboard view of Curator.

![Screenshot 2](/screenshots/Screenshot%202024-01-19%20173447.png?raw=true "Screenshot 2")

Document management view of Curator.


## Getting Started
**Prerequisites**
- Flutter installed on your system. [Install Flutter](https://flutter.dev/docs/get-started/install)
- MySQL server set up and running.

**Installation**
1. Clone the repository:
```bash
git clone https://github.com/your-username/curator.git
```
2. Navigate to the project directory:

```bash
cd curator
```
3. Install dependencies:

```bash
flutter pub get
```
4. Configure MySQL connection:
Open the **lib/data/api/mysql_api.dart** file.
Update the MySQL connection details (host, username, password, database) in the DatabaseHelper class.

5. Run the application:

```bash
flutter run
```
## Contribution
Contributions to Curator are welcome! Feel free to submit issues, feature requests, or pull requests. For major changes, please open an issue first to discuss the proposed changes.

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Acknowledgments
- Thanks to the Flutter and Dart communities for providing excellent resources and documentation.
- Special thanks to MySQL for powering the database backend of Curator.
## Disclaimer
Curator is an unfinished project, and some features may not work as expected. Use it at your own risk.

**Happy reading and library management with Curator! 📚**
