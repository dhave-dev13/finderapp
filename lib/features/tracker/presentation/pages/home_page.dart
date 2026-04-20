import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/enums.dart';
import 'package:finderapp/features/tracker/presentation/bloc/geolocator_bloc/geolocator_bloc.dart';
import 'package:finderapp/features/tracker/presentation/bloc/target_location/target_location_bloc.dart';
import 'package:finderapp/features/tracker/presentation/widgets/location_history_cards.dart';
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
            if (state.status == GeolocatorStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Location error')));
            }
          },
        ),
        // Listen to TargetLocation errors
        BlocListener<TargetLocationBloc, TargetLocationState>(
          listenWhen: (previous, current) => current.status == FetchStatus.failed,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Failed to load target location'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        //
        BlocListener<TargetLocationBloc, TargetLocationState>(
          listenWhen: (previous, current) => previous.status != FetchStatus.loaded && current.status == FetchStatus.loaded && current.data != null,
          listener: (context, state) {
            // Start location tracking
            context.read<GeolocatorBloc>().add(StartLocationTracking());
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Location Tracker'), backgroundColor: Color(0xFFf2f7f6)),
        body: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<TargetLocationBloc, TargetLocationState>(
              builder: (context, targetState) {
                String trackingStatus = '';
                if (targetState.status == FetchStatus.loading) {
                  trackingStatus = 'Loading target location...';
                } else if (targetState.status == FetchStatus.loaded) {
                  trackingStatus = 'Tracking...';
                } else {
                  trackingStatus = 'Tracking is Off';
                }
                return Center(
                  child: Text(
                    trackingStatus,
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<GeolocatorBloc, GeolocatorState>(
                  builder: (context, state) {
                    return ToggleSwitch(
                      status: state.status == GeolocatorStatus.tracking,
                      onToggle: (value) async {
                        if (value) {
                          /// get target locations
                          context.read<TargetLocationBloc>().add(GetTargetLocation());
                        } else {
                          context.read<GeolocatorBloc>().add(StopLocationTracking());
                          context.read<TargetLocationBloc>().add(ResetTargetLocation());
                        }
                      },
                    );
                  },
                ),
                // IconButton(onPressed: () => context.read<GeolocatorBloc>().add(ClearLocationHistory()), icon: Icon(Icons.delete_forever_rounded))
              ],
            ),

            const SizedBox(height: 10),
            // Target Location Info
            BlocBuilder<TargetLocationBloc, TargetLocationState>(
              builder: (context, state) {
                return state.data != null
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Target: ${state.data?.targetLat!}, '
                          '${state.data?.targetLng}',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),

            // 5. Filtering Dropdown
            // Provide a control that lets the user filter the displayed list to show only the most recent N
            // readings, where N can be:
            // • 5 readings
            // • 10 readings
            // • 15 readings
            // • 20 readings
            BlocBuilder<GeolocatorBloc, GeolocatorState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Show: '),
                      DropdownButton<int>(
                        value: state.filterLimit,
                        items: const [
                          DropdownMenuItem(value: 5, child: Text('5')),
                          DropdownMenuItem(value: 10, child: Text('10')),
                          DropdownMenuItem(value: 15, child: Text('15')),
                          DropdownMenuItem(value: 20, child: Text('20')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            context.read<GeolocatorBloc>().add(UpdateFilterLimit(value));
                          }
                        },
                      ),
                      const Text(' most recent'),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            ///
            BlocBuilder<GeolocatorBloc, GeolocatorState>(
              builder: (context, state) {
                return Expanded(
                  child: state.records.isEmpty
                      ?
                        /// Best practice null screen for empty records
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_off, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                state.status == GeolocatorStatus.tracking
                                    ? 'Waiting for location updates...'
                                    : 'No records yet.\nStart tracking to see data.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        )
                      :
                        // 4. UI Display
                        // Display all captured readings in a scrollable list. Each list item must show:
                        // • Timestamp
                        // • Latitude and longitude
                        // • Computed distance from the target
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.filteredRecords.length,
                          itemBuilder: (context, index) {
                            final record = state.filteredRecords[index];
                            return LocationHistoryCards(index: index, record: record);
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
