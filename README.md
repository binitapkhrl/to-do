# Flutter To-Do App (Learning Project)

This repository contains a **learning-focused Flutter To-Do application**.  
The goal is to practice and understand ** Riverpod, and Beamer**, while building a clean architecture Flutter app.

---

## 🧱 Project Structure

```text
lib/
 ├── app/               # App-level setup & router
 │    ├── app.dart
 │    └── router/
 ├── features/
 │    └── todo/         # Todo feature
 │         ├── model/
 │         ├── bloc/
 │         ├── repository/
 │         └── ui/
 ├── providers/         # Riverpod providers
 └── main.dart
