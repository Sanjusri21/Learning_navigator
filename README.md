
# Beginner Learning Guide & Career Prep App 🚀

## Overview

The Beginner Learning Guide & Career Prep App is a Flutter and Firebase-based mobile application designed to help beginners start learning new skills and prepare for career opportunities through structured learning roadmaps and interview preparation resources.

The platform provides guided career-based learning paths, curated educational resources, progress tracking, Q&A support, and event participation features to bridge the gap between learning and employability.

---

# Problem Statement

Many beginners in online and self-paced learning environments face common challenges:

* Difficulty identifying where to start learning
* Lack of structured and beginner-friendly learning paths
* Uncertainty about skills required for specific career roles
* Limited guidance for interview preparation and career readiness

These challenges often result in confusion, inconsistent learning, and reduced confidence during job preparation.

---

# Proposed Solution

This application provides a centralized learning ecosystem that offers:

* Structured career-based learning roadmaps
* Step-by-step beginner learning guidance
* Curated learning resources and recommendations
* Practice exercises and quizzes
* Interview preparation materials
* Progress tracking and profile management
* Event participation and community engagement

The goal is to help users move from beginner-level learning to career readiness in an organized, interactive, and measurable way.

---

# Core Features

* Career Role Selection
* Personalized Learning Roadmaps
* Educational Resource Recommendations
* Practice Questions & Quizzes
* Interview Preparation
* Progress Tracking Dashboard
* Event Registration
* Introduction Videos
* Profile Management
* Feedback Collection
* Modern Settings System

---

# Tech Stack

| Technology      | Usage                    |
| --------------- | ------------------------ |
| Flutter         | Frontend Development     |
| Dart            | Programming Language     |
| Firebase        | Backend & Authentication |
| Cloud Firestore | Database                 |
| Material Design | UI Design                |

---

# Firebase Features

The application uses Firebase for:

* User Authentication
* Cloud Firestore Database
* Learning Progress Storage
* Real-time Data Synchronization
* Secure User Management

---

# Project Structure

## 1. Home Screen

The Home Screen serves as the central dashboard of the application. It provides users with an overview of their learning journey, displays available learning programs, highlights active enrollments, and offers quick access to important sections of the app.

---

## 2. Program List Screen

The Program List Screen allows users to explore all available learning programs. Each program is presented with relevant information to help learners choose a suitable learning path.

---

## 3. Program Details Screen

The Program Details Screen provides detailed information about selected programs, including descriptions, required skills, roadmaps, learning outcomes, difficulty levels, Q&A sections, and educational resources.

---

## 4. Roadmap Screen

Each learning program includes a structured roadmap that guides learners through different learning stages and milestones. Users can track progress and access related courses and learning materials through integrated resource links.

---

## 5. Resources Screen

The Resources Screen contains educational materials associated with each roadmap step, including:

* Google resource links
* Articles
* Tutorials
* Videos
* Documentation

These resources help learners complete each stage effectively.

---

## 6. Upcoming Events Screen

The Upcoming Events Screen displays workshops, webinars, bootcamps, and learning activities relevant to users.

---

## 7. Event Registration Form

Users can register for events directly through the application. After registration, an introduction video related to the selected program or event is displayed to provide guidance and expectations.

---

## 8. Profile Screen

The Profile Screen allows users to manage personal information, track learning progress, view achievements, and access enrolled programs.

---

## 9. Edit Profile Feature

Users can edit profile details and update personal information for a more personalized experience.

---

## 10. Upload Profile Image

Users can upload and update profile pictures directly from their device gallery.

---

## 11. Feedback Form

A Feedback Form is integrated within the Profile section, allowing users to submit suggestions, comments, and improvement requests.

---

## 12. Settings Screen

A Google-style Settings Screen provides users with a modern and familiar interface to manage:

* Account preferences
* Notification settings
* Privacy controls
* Application configurations

---

## 13. Navigation System

The application uses a bottom navigation bar consisting of:

* Home
* Programs
* Events
* Profile

This navigation system ensures smooth movement between screens and improves accessibility.

---

## 14. Conclusion

The latest version of Learning Navigator provides a complete learning ecosystem by combining:

* Structured learning programs
* Roadmap-based guidance
* Educational resources
* Q&A support
* Event registration
* Introduction videos
* Profile customization
* Feedback collection
* Modern settings management

These features significantly improve the user experience and support the application's goal of delivering a guided, interactive, and organized learning platform.

---
# Testing & Quality Assurance
## Functional Testing
* Verified learning paths and roadmap functionality
* Tested progress tracking and resource access
* Verified event registration flow
## UI/UX Testing
* Responsive layout testing
* Consistent design verification
* User interaction testing
## Navigation Testing
* Verified smooth screen transitions
* Tested bottom navigation routing
## Form Validation Testing
* Empty field validation
* Email validation
# Input restriction testing
## User Testing
* Tested with beginner learners
* Collected usability feedback
* Improved navigation and accessibility

# 🐞 Issues Found & Fixes Applied

| Issues Found | Fixes Applied |
|--------------|----------------|
| Navigation issues between screens | Implemented proper Bottom Navigation and routing system |
| Duplicate `samplePaths` import conflicts | Centralized data into a single `local_data.dart` file |
| `ProfileScreen` missing required parameters | Added `userName` and `userEmail` constructor arguments |
| Progress screen navigation errors | Corrected navigation indexing and screen routing |
| UI overflow on smaller devices | Added responsive layouts and flexible widgets |
| Unused imports and warnings | Removed unnecessary imports and cleaned project structure |
| Resource links not opening | Integrated `url_launcher` package correctly |
| Form submission without validation | Added input validation for all forms |
| State update issues in roadmap completion | Implemented proper `setState()` updates |
| Profile image upload inconsistencies | Added gallery and camera support using `image_picker` |
| Bottom navigation rebuilding screens repeatedly | Implemented optimized navigation structure |
| Incorrect widget parameter usage | Fixed widget syntax and named parameter errors |
| Progress bar rendering issues | Corrected `LinearProgressIndicator` implementation |
| Dark mode UI inconsistencies | Improved conditional theme handling |
| Route transition issues | Implemented proper `Navigator.pushReplacement()` handling |
| Learning history screen not displaying data | Connected learning history with shared local data source |
| Firebase configuration issues | Configured Firebase initialization and dependencies properly |
| Card shadow and styling inconsistencies | Improved UI design using proper `BoxShadow` configuration |
| Event registration flow issues | Added proper navigation and form handling |
| Null safety warnings | Updated codebase to follow Dart null safety standards |

---

# Project Goals

* Simplify learning for beginners
* Provide structured learning guidance
* Improve learning consistency
* Bridge the gap between learning and employability
* Support interview preparation and career readiness
  
# Target Users
Beginners exploring new career paths
Students in virtual learning environments
Self-taught learners
Individuals preparing for tech interviews

# Future Enhancements

* AI-based personalized learning recommendations
* Gamification and achievement badges
* Resume builder integration
* Real-time mentorship support
* AI-generated interview preparation
* Adaptive learning systems

---

# Installation & Setup

## Clone the Repository

```bash
git clone https://github.com/Sanjusri21/Learning_navigator.git
```

## Navigate to the Project Directory

```bash
cd Learning_navigator
```

## Install Dependencies

```bash
flutter pub get
```

## Configure Firebase

1. Create a Firebase project
2. Add Android/iOS app to Firebase
3. Download configuration files:

   * `google-services.json`
   * `GoogleService-Info.plist`
4. Enable Firebase Authentication
5. Enable Cloud Firestore

---

## Run the Application

```bash
flutter run
```

---

# Contribution Guidelines

Contributions are welcome.

To contribute:

1. Fork the repository
2. Create a new feature branch
3. Follow clean coding practices
4. Submit a pull request for review

---

# License

This project is licensed under the MIT License.

---

# Author

Developed using Flutter & Firebase for structured learning and career preparation.
>>>>>>> 19b9ab356ef27081f615ca4771425df5e3064554
>>>>>>> 84c9ea14170aabac1e4f98a27558a727ec5087c6
