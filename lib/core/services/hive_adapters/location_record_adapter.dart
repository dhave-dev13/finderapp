import 'package:finderapp/features/tracker/data/models/location_record_model.dart';
import 'package:hive/hive.dart';

class LocationRecordAdapter extends TypeAdapter<LocationRecordModel>{

  @override
  int get typeId => 1;

  @override
  LocationRecordModel read(BinaryReader reader) {
    return LocationRecordModel(
      id: reader.read(),
      timestamp: reader.read(),
      latitude: reader.read(),
      longitude: reader.read(),
      distance: reader.read(),
      formattedDistance: reader.read(),
      targetId: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, LocationRecordModel obj) {
    writer.write(obj.id);
    writer.write(obj.timestamp);
    writer.write(obj.latitude);
    writer.write(obj.longitude);
    writer.write(obj.distance);
    writer.write(obj.formattedDistance);
    writer.write(obj.targetId);
  }
  
}