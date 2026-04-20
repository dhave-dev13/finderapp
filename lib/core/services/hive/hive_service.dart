import 'package:finderapp/core/services/hive_adapters/location_record_adapter.dart';
import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/app_strings.dart';
import 'package:finderapp/features/tracker/data/models/location_record_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  final logger = AppLogger('HiveService');

  late final Box<LocationRecordModel> _locationRecordsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();

    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Open boxes
    _locationRecordsBox = await Hive.openBox<LocationRecordModel>(AppStrings.locationStorageName);

    logger.i('HiveService initialized successfully');
  }

  void _registerAdapters() {
    Hive.registerAdapter(LocationRecordAdapter());
  }

    // ============ LOCATION RECORDS METHODS ============
  Future<void> saveLocationRecord(LocationRecordModel record) async {
    try {
      // Using timestamp as key to ensure uniqueness
      await _locationRecordsBox.put(record.id, record);
      logger.i('Location record saved: ${record.id} at ${record.timestamp}');
    } catch (e) {
      logger.e('Error saving location record: $e');
      rethrow;
    }
  }

  Future<List<LocationRecordModel>> getLocationRecords({int? limit}) async {
    try {
      // Get all records from the box
      final records = _locationRecordsBox.values.toList();
      
      // Sort by timestamp descending (most recent first)
      records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      // limit data based on filtering
      if (limit != null && limit < records.length) {
        return records.take(limit).toList();
      }
      
      return records;
    } catch (e) {
      logger.e('Error getting location records: $e');
      return [];
    }
  }

  // Clear all records (if needed) .i.e. logout.
  Future<void> clearAllRecords() async {
    try {
      await _locationRecordsBox.clear();
      logger.i('All location records cleared');
    } catch (e) {
      logger.e('Error clearing records: $e');
      rethrow;
    }
  }


}
