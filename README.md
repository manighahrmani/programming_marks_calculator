# Programming Marks Calculator

This is a Flutter app that calculates the total marks for a programming course based on various assessments and their respective weights.

## Getting Started

To run this app on your local machine, follow these steps:

1. Make sure you have Flutter installed. If not, follow the official installation guide: [Flutter Installation](https://flutter.dev/docs/get-started/install)

2. Clone this repository using Visual Studio Code:
   - Open Visual Studio Code.
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS) to open the command palette.
   - Type "Git: Clone" and press Enter.
   - Paste the repository URL: `https://github.com/manighahrmani/programming_marks_calculator`
   - Choose a location to save the cloned repository.
   - Click "Open" to open the cloned repository in Visual Studio Code.

3. Install the necessary extensions in Visual Studio Code:
   - Dart
   - Flutter

4. Open the terminal in Visual Studio Code (`Ctrl+Shift+P` and type "Terminal: Create New Integrated Terminal") and navigate to the project directory:
   ```
   cd programming_marks_calculator
   ```

5. Run the following command to get the dependencies:
   ```
   flutter pub get
   ```

6. Connect a device or start an emulator.

7. Run the app using the following command:
   ```
   flutter run
   ```

## App Structure

The app consists of three main parts:

1. **Data**: The [`lib/data/assessment_data.dart`](https://github.com/manighahrmani/programming_marks_calculator/tree/main/lib/data/assessment_data.dart) file contains the data for the assessments and their corresponding weights.

2. **Backend**: The [`lib/backend/marks_calculator.dart`](https://github.com/manighahrmani/programming_marks_calculator/tree/main/lib/backend/marks_calculator.dart) file contains the logic for calculating the total marks based on the entered marks and the assessment weights.

3. **UI**: The [`lib/ui/home_page.dart`](https://github.com/manighahrmani/programming_marks_calculator/tree/main/lib/ui/home_page.dart) file defines the user interface of the app. It includes text fields for entering marks and a button to calculate the total marks.

The UI communicates with the backend by passing the entered marks to the `MarksCalculator` class, which performs the calculations and returns the result. The data is kept separate in the `assessment_data.dart` file, promoting separation of concerns.

## Hosting on Firebase (for free!)

To host your Flutter app as a website on Firebase, follow these steps:

1. Create a new Firebase project on the Firebase Console: [Firebase Console](https://console.firebase.google.com/)

2. Install the Firebase CLI by running the following command:
   ```
   npm install -g firebase-tools
   ```

3. Log in to Firebase using the CLI:
   ```
   firebase login
   ```

4. In your Flutter project directory, initialize Firebase:
   ```
   firebase init
   ```
   Select "Hosting" and follow the prompts to set up hosting.

5. Build your Flutter app for the web:
   ```
   flutter build web
   ```

6. Deploy your app to Firebase Hosting:
   ```
   firebase deploy
   ```

7. Your app will be hosted at the provided URL, which will look like: `https://your-project-id.web.app`

## Live App

You can test the live version of the Programming Marks Calculator app hosted on Firebase: [Programming Marks Calculator](https://programming-marks-calculator.web.app)

Feel free to explore the app and provide feedback!