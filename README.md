# Paysky Summer Training

## 📌 Task 1 – Flutter E-Commerce Application

A Flutter application that simulates a basic **e-commerce experience** with product browsing, cart management, and Stripe payment integration.

---

### 🔹 1. API Information

- **Mock API**: Provides a list of products using **Postman Mock Servers**
- **Endpoint**: [`https://b5a0bfa1-6d8b-4c44-862b-68d03d2d4521.mock.pstmn.io/products`](https://b5a0bfa1-6d8b-4c44-862b-68d03d2d4521.mock.pstmn.io/products)
- **Method**: `GET`

---

### 🔹 2. Payment Gateway API (Stripe – Test Mode)

- **PaymentIntent** (server-side creation)
- **Client Secret** (returned to app)
- **Stripe Test Cards** (`4242 4242 4242 4242`)

---

### 🔹 3. App Features

- **Product Catalog Screen** – displays items from mock API
- **Shopping Cart** – add, remove, update quantity, and show totals
- **Checkout & Payment** – integrated with Stripe PaymentSheet
- **Order Confirmation Screen** – shows after successful payment

---

### 🔹 4. Technical Details

- **Framework**: Flutter
- **Language**: Dart
- **Networking**: [http](https://pub.dev/packages/http) (^1.5.0)
- **Payment**: [flutter_stripe](https://pub.dev/packages/flutter_stripe) (^11.5.0)

---

### 🔹 5. Architecture Pattern

- **Data Layer**

  - `cart_model.dart` – product fetching, cart logic
  - `stripe_service.dart` – payment handling

- **Components Layer**

  - `keys.dart` – API/Stripe keys
  - `products_items.dart` – reusable product widget

- **UI Layer**
  - `intro_page.dart` – intro/splash
  - `home_page.dart` – product catalog
  - `cart_page.dart` – shopping cart and checkout

---

### 🚀 How to Set Up and Run

1. Clone the repo:

```
   git clone https://github.com/Hisham700/paysky-summer-training.git
```

2.  Setup Android Studio for flutter .
3.  run the app with Emulator or on your android phone (phone in Developer mode).

---

## 🎥 Demo Video

https://github.com/user-attachments/assets/846f22b2-e3a3-488f-953b-2319f8d693e4
