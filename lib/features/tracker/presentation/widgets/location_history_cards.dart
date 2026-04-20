import 'package:finderapp/core/utils/helpers.dart';
import 'package:finderapp/features/tracker/domain/entities/location_record_entity.dart';
import 'package:flutter/material.dart';

class LocationHistoryCards extends StatelessWidget {
  final int index;
  final LocationRecordEntity record;
  const LocationHistoryCards({super.key, this.index = 0, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFF66d9b1),
          child: Text('${index + 1}', style: const TextStyle(fontSize: 14, fontFamily: 'Poppins')),
        ),
        title: Text(
          record.formattedDistance,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatTimestamp(record.timestamp), style: const TextStyle(fontSize: 12, fontFamily: 'Poppins')),
            Text(
              '${record.latitude.toStringAsFixed(6)}, ${record.longitude.toStringAsFixed(6)}',
              style: const TextStyle(fontSize: 12, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
