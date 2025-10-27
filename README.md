# 🧸 Flutter Bear Login Animation

A Flutter login screen featuring an **interactive bear 🐻 animation** that reacts to your typing, success, and failure events.

---

## 📝 Short Description

This app provides a lively login interface using **Rive animations**.  
- 🐻 The bear follows your typing when entering the **email**.  
- 🙈 The bear covers its eyes while typing the **password**.  
- ✅ Plays a success animation when login is valid.  
- ❌ Plays a failure animation when login fails.  

---

## 🎨 What is Rive?

**Rive 🤖** is a tool for creating **interactive, real-time animations** that respond to user actions. Unlike GIFs or videos, `.riv` files can be fully controlled via code, allowing animations to react instantly.

---

## 🧠 What is a State Machine?

A **State Machine** in Rive acts as the "brain" of the animation. It controls different states (e.g., `idle`, `typing`, `success`, `fail`) and the transitions between them.  
Inputs from Flutter (`isTyping`, `isError`) determine which animation is played automatically.

---

## 🛠️ Tech Stack

- **Flutter** 🐦 – UI framework for cross-platform apps  
- **Dart** 💻 – Programming language  
- **Rive** 🎨 – Tool to create and control interactive animations  

Dependencies in `pubspec.yaml`:

`yaml`
`dependencies:
  ``flutter:`
    ``sdk: flutter
  ``rive: ^0.13.20`

---
🚀 Getting Started

Installation:
# Clone the repository
git clone <project_url>

# Go into the project directory
cd flutter_bear_login

# Install dependencies
flutter pub get

# Run the app
flutter run

---
📂 Project Structure
## 📂 Project Structure

```text
flutter_bear_login/
├── android/                    # Android platform code
├── ios/                        # iOS platform code
├── assets/                     # Static assets
│   └── bear_login.riv          # Rive animation file
├── lib/                        # Dart source code
│   ├── screens/
│   │   └── login_screen.dart   # Main UI and Rive logic
│   └── main.dart               # App entry point
├── test/                       # Unit and widget tests
├── .gitignore
├── pubspec.yaml                # Project dependencies
└── README.md
````
---
🎮 How to Use

Email Field: Tap on the email input. The bear looks toward the field and follows your typing (isChecking).

Password Field: Tap on the password input. The bear covers its eyes (isHandsUp).

Live Validation: While typing the password, the validation criteria update in real time.

Trigger Failure: Enter an invalid email or password and press Login. The bear plays the failure animation (trigFail).

Trigger Success: Enter a valid email and password, then press Login. The bear celebrates with the success animation (trigSuccess).


---

## 🎬 Demo
![Demostración de la aplicación](demo.gif)



---
🎓 Academic Information

Subject: Graficación

Instructor: Rodrigo Fidel Gaxiola Sosa
---
🙌 Credits

Original animation: Remix of Login Machine

Created and published on Rive Marketplace
