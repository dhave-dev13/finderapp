import 'package:finderapp/features/tracker/presentation/bloc/geolocator_bloc/geolocator_bloc.dart';
import 'package:finderapp/features/tracker/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GeolocatorBloc>(create: (context) => GeolocatorBloc()),
      ],
      child: MaterialApp(home: Scaffold(body: HomePage())),
    );
  }
}
