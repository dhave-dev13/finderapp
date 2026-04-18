import 'package:finderapp/core/enums.dart';
import 'package:finderapp/features/tracker/presentation/bloc/geolocator_bloc/geolocator_bloc.dart';
import 'package:finderapp/features/tracker/presentation/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GeolocatorBloc, GeolocatorState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.status == GeolocatorStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Location error')));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Location Tracker'), backgroundColor: Color(0xFFf2f7f6)),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Tracking',
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<GeolocatorBloc, GeolocatorState>(
                  builder: (context, state) {
                    return ToggleSwitch(
                      status: state.status == GeolocatorStatus.tracking,
                      onToggle: (value) {
                        if (value) {
                          context.read<GeolocatorBloc>().add(StartLocationTracking());
                        } else {
                          context.read<GeolocatorBloc>().add(StopLocationTracking());
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
