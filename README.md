# Up the Shelf

<p align="center">
  <img src="./docs/uptheshelf-logo.png" alt="Up the Shelf logo"/>
</p>

## Purpose

This app is created with Flutter (v 2.5.2). It is the take home assignment for App and Up. The purpose was to build a book app that interacts with Google Books Api and Firestore.

The name comes from: App and Up + a bookshelf

### screenshots

<p align="center">
  <img style="width:15rem; height: 35rem" src="./docs/screenshot1.png" alt="Up the Shelf screenshot"/>
    <img style="width:15rem; height: 35rem" src="./docs/screenshot2.png" alt="Up the Shelf screenshot"/>
      <img style="width:15rem; height: 35rem" src="./docs/screenshot3.png" alt="Up the Shelf screenshot"/>
</p>

## Features

The project status and features were tracked in a github project: [https://github.com/dee-deee/up_the_shelf/projects/1](https://github.com/dee-deee/up_the_shelf/projects/1). You can see which issues are still open and I was not able to complete.

## Getting Started

Required: Flutter tooling + Firebase files for ios and android (GoogleService-Info.plist/ google-services.json)

**Step 1:**

Download or clone this repo

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

Run on your device:

```
flutter run -d <deviceId>
```

In case you want to run for the web:

```
flutter run -d chrome --web-hostname localhost --web-port 5000 --web-renderer html
```

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
