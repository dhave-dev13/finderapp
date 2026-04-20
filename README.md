# finderapp

An App that basically gets your device location (latitude,longitude) and also a specific target location (latitude,longitude) from mock api and calculates its distance and displayed on your app via list.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

You need to have the Flutter SDK installed on your machine. For instructions on how to install Flutter, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

1.  Clone the repository:
    ```sh
    git clone https://github.com/dhave-dev13/finderapp.git
    ```
2.  Change to the project directory:
    ```sh
    cd finderapp
    ```
3.  Install the dependencies:
    ```sh
    flutter pub get
    ```

# Using VSCode,

Specificy in configuration argument to include ```sh "--dart-define-from-file=.env.dev"``` as specified in
```project/.vscode/launch.json```

<h3>Folder Structure</h3>
<p>I'm using clean architecure with bloc (https://resocoder.com/flutter-clean-architecture-tdd/) for this simple app to show indicate the capability of this app to upscale whenever. </p>

```sh
lib/
├── core
│   ├── api
│   │   └── api_interceptor.dart
│   ├── config
│   │   └── app_config.dart /// app instances, services, and dio 
│   ├── error
│   │   └── failure.dart /// for Either usecase in dartz
│   ├── locator.dart /// get_it for dependency management
│   ├── params
│   │   └── params.dart
│   ├── services
│   │   ├── hive /// app storage using hive
│   │   └── hive_adapters /// hive adapters -> model parsing
│   ├── usecase.dart 
│   └── utils
│       ├── app_logger.dart /// app global logger
│       ├── app_strings.dart /// app global strings
│       ├── distance_calculator.dart /// distance calculator for geolocation
│       ├── enums.dart 
│       └── helpers.dart /// string helper, 
├── features
│   └── tracker /// tracker feature
│       ├── data
│       ├── domain
│       └── presentation
└── main.dart
```

<h2>Mock API Setup</h2>
Using https://www.mockapi.com/auth/login, i have setup a mock api with the following endpoint:

https://api.mockapi.com/api/v1, the token is defined in .env.dev file.


https://github.com/user-attachments/assets/0fbb7354-7c83-4055-bdee-864f681fb099







