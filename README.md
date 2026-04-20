# finderapp

An App that basically gets your device location (latitude,longitude) and also a specific target location (latitude,longitude) from mock api and calculates its distance and displayed on your app via list.

<h3>Folder Structure</h3>
<p>I'm using clean architecure with bloc for this simple app to show indicate the capability of this app to upscale whenever. </p>

lib/
├── util
├── presentation/
│   ├── bloc/
│   │   ├── geolocator_bloc.dart
│   │   ├── geolocator_event.dart
│   │   └── geolocator_state.dart
│   └── pages/
│       └── location_page.dart
├── domain/
│   ├── entities/
│   │   └── location_entity.dart
│   ├── repositories/
│   │   └── location_repository.dart
│   └── usecases/
│       ├── start_location_tracking.dart
│       ├── stop_location_tracking.dart
│       └── get_location_permission.dart
├── data/
│   ├── repositories/
│   │   └── location_repository_impl.dart
│   ├── datasources/
│   │   └── location_remote_datasource.dart
│   └── models/
│       └── location_model.dart
└── injection/
    └── injection_container.dart
