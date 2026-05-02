# 🍳 Recipes

A modern iOS application for discovering and managing recipes, built with SwiftUI and powered by **TheMealDB API**. This project demonstrates scalable architecture, robust networking, and modern SwiftUI patterns like `@Observable`.

## 📸 Screenshots


| Home Screen | Category Carousel | Recipe Details |
| :---: | :---: | :---: |
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-02 at 15 52 45" src="https://github.com/user-attachments/assets/14907ceb-5f01-4dc9-bfc6-c9e642238f25" /> |<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-02 at 15 53 00" src="https://github.com/user-attachments/assets/a85b5b8d-6577-4d1b-806a-084c506c2c92" />|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-02 at 15 52 53" src="https://github.com/user-attachments/assets/109e88c5-fc02-46ad-827b-014aef120ca5" />|

| *Featured Meals* | *Horizontal Snapping* | *Ingredients & Directions* |

## 🚀 Key Features

- **Custom Horizontal Carousel**: A snapping, side-by-side category selector optimized for quick navigation.
- **Modern Networking**: A protocol-oriented `RequestFactory` that handles dynamic endpoints and URL parameters safely.
- **Robust Data Parsing**: Implements a strict separation between **DTOs** (Data Transfer Objects) and **Display Models** to ensure UI stability.
- **Intelligent State Management**: Handles `.loading`, `.success`, and partial `.error` states to keep the UI interactive even during network failures.

## 🛠 Tech Stack

- **SwiftUI**: Using the latest `@Observable` macro (iOS 17+).
- **Concurrency**: Fully asynchronous data fetching with `async/await`.
- **Architecture**: MVVM + Repository Pattern with Dependency Injection.
- **Networking**: `URLSession` with a modular `EndpointProtocol` system.
