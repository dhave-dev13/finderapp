import 'package:finderapp/features/tracker/presentation/cubit/tracker_cubit.dart';
import 'package:finderapp/features/tracker/presentation/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrackerToggleCubit, bool>(
      listener: (context, state) {
        if (state) {
          
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Location Tracker'), backgroundColor: Color(0xFFf2f7f6)),
        body: ListView(
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
                BlocBuilder<TrackerToggleCubit, bool>(
                  builder: (context, state) {
                    return ToggleSwitch(status: state, onToggle: (val) => context.read<TrackerToggleCubit>()..toggleLocationTracking());
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
