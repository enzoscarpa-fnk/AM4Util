# ✈️ AM4 Utility

<div align="center">

![Vue.js](https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D)
![TailwindCSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

A lightweight web application for managing airline ticket pricing calculations and seat allocation optimization.

[Live Demo](https://am4.studiofnk.be) • [Report Bug](https://github.com/enzoscarpa-fnk/AM4Util/issues) • [Request Feature](https://github.com/enzoscarpa-fnk/AM4Util/issues)

</div>

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Demo](#-demo)
- [Usage](#-usage)
- [Contributing](#-contributing)
- [License](#-license)

## 🎯 About

**AM4 Utility** is a web application built with Vue.js 3 and Tailwind CSS, designed to simplify airline ticket pricing management and seat distribution optimization across the three in-game classes: Economy (Y), Business (J), and First (F).

The application provides an intuitive and reactive user interface for performing real-time calculations without requiring page reloads.

## ✨ Features

### 🎫 Ticket Price Calculator

Automatically calculate final ticket prices based on class-specific multipliers:

- **Y Class (Economy)**: Base price × 1.10
- **J Class (Business)**: Base price × 1.08
- **F Class (First)**: Base price × 1.06

Results are rounded down to prevent triggering the "Price too high" notification..

### 💺 Seat Optimizer

Optimize seat distribution based on passenger demand and total aircraft capacity:

- Total seats calculation: `totalSeats = Y + (J × 2) + (F × 3)`
- Proportional distribution for each class
- Results rounded to the nearest integer

### 🔒 Data Validation

- Accepts **integers only**
- Real-time filtering of non-numeric characters
- Placeholders set to `0` with initially empty fields
- Quick reset button for each module

## 🛫 Demo

The application is deployed and accessible at:

**🔗 [https://am4.studiofnk.be](https://am4.studiofnk.be)**

### Screenshots

Add screenshots here

## 💻 Usage

### Ticket Price Calculator

1. Enter the base price for each class (Y, J, F)
2. Calculated prices display automatically
3. Use the **×** button to reset the fields

### Seat Optimizer

1. Enter passenger demand for each class
2. Specify the total number of seats in the aircraft
3. Optimal distribution displays instantly
4. Click **×** to clear all data

## 🤝 Contributing

Contributions are welcome! Here's how you can participate:

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

---

<div align="center">

Built with ❤️ by [FNK](https://github.com/enzoscarpa-fnk)

[⬆ Back to top](#am4-vuejs-utility)

</div>
