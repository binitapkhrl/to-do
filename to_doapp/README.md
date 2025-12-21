# Todo Architecture (Flutter)

A learning-focused Flutter application built to deeply understand and practice:

- BLoC for business logic
- Riverpod for dependency injection and global state ownership
- Beamer for declarative navigation


## 🎯 Goals

- Learn how to structure a real Flutter application
- Clearly separate UI, state, and business logic
- Understand *why* each tool is used, not just *how*

---

## 🧱 Architecture Overview

```text
UI
 ↓
BLoC (Behavior)
 ↓
Repository (Data source)
 ↓
Models

Riverpod → owns dependencies & global state  
Beamer → controls navigation flow
