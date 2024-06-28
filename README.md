# Bank Queue Management Tool

Welcome to the Bank Queue Management Tool! This application is designed to help users avoid long queues in banks by allowing them to book appointments and manage their time more efficiently. Built with a powerful combination of Firebase and Flutter, this tool offers a seamless experience for both users and bank administrators.

## Features

- **User-Friendly Interface**: Designed with Flutter, providing a smooth and intuitive user experience.
- **Firebase Backend**: Reliable and scalable backend services using Firebase.
- **Queue Management**: Efficiently book and manage appointments to avoid long waits.
- **Notifications**: Real-time updates and notifications about your appointment status.
- **Ad Integration**: Monetized using Google AdMob for adverts.
- **Premium Membership**: Users can upgrade to a premium version with additional features through Flutterwave payments.

## Screenshots

-Screenshots are availed in the screenshots folder in the main branch.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase Account: [Firebase Signup](https://firebase.google.com/)
- Google AdMob Account: [AdMob Signup](https://admob.google.com/home/)
- Flutterwave Account: [Flutterwave Signup](https://www.flutterwave.com/)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/mukisaivan/queueingtool.git
    cd queueingtool
    ```

2. Install dependencies:

    ```bash
    flutter pub get
    ```

3. Set up Firebase:

    - Create a new project on Firebase.
    - Add your app to the Firebase project.
    - Download the `google-services.json` file for Android and place it in the `android/app` directory.
    - Download the `GoogleService-Info.plist` file for iOS and place it in the `ios/Runner` directory.

4. Set up Google AdMob:

    - Create ad units in your AdMob account.
    - Add the AdMob app ID to your AndroidManifest.xml and Info.plist files.

5. Set up Flutterwave Payments:

    - Follow Flutterwave documentation to integrate payment services.
    - Update your app with necessary configurations and keys.

6. Run the app:

    ```bash
    flutter run
    ```

## Usage

- **Booking an Appointment**: Users can select their preferred bank branch and time slot to book an appointment.
- **Managing Appointments**: Users can view, reschedule, or cancel their appointments through the app.
- **Notifications**: Users will receive push notifications about their appointment status.
- **Adverts and Monetization**: Free users will see ads, while premium users can enjoy an ad-free experience and additional features.

## Premium Membership

Upgrade to a premium membership to unlock:

- Ad-free experience.
- Priority booking.
- Extended appointment management features.

Payments are securely processed through Flutterwave.



## Contact

For any questions or feedback, please reach out to us at mukisaivan340@gmail.com.

---

Thank you for using the Bank Queue Management Tool! We hope it helps you save time and avoid the hassle of waiting in line at the bank.
