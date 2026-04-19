import 'package:finderapp/core/services/hive_adapters/location_record_adapter.dart';
import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/app_strings.dart';
import 'package:finderapp/features/tracker/data/models/location_record_model.dart';
import 'package:finderapp/features/tracker/data/models/target_location_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  final logger = AppLogger('HiveService');

  late final BoxCollection _collection;
  late final CollectionBox<LocationRecordModel> _locationRecordsBox;

  static const String targetLocationKey = 'current_target';

  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();

    final directory = await getApplicationDocumentsDirectory();

    // Open the collection (database)
    _collection = await BoxCollection.open('/app_box', {
      AppStrings.locationStorageName, // For location records
      'target_location_box', // For target location data
    }, path: directory.path);

    // Open boxes
    _locationRecordsBox = await _collection.openBox<LocationRecordModel>(AppStrings.locationStorageName);

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
      logger.i('Location record saved: ${record.id}');
    } catch (e) {
      logger.e('Error saving location record: $e');
      rethrow;
    }
  }

  Future<List<LocationRecordModel>> getLocationRecords({int? limit}) async {
    try {
      // Get all records from the box
      dynamic records = _locationRecordsBox.get(AppStrings.locationStorageName);

      List<LocationRecordModel> locationRecordData = [...records];
      
      // Sort by timestamp descending (most recent first)
      locationRecordData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      if (limit != null && limit < records.length) {
        return locationRecordData.take(limit).toList();
      }
      return locationRecordData;
    } catch (e) {
      logger.e('Error getting location records: $e');
      return [];
    }
  }
}
