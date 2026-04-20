import 'package:finderapp/core/services/hive/hive_service.dart';

class GlobalHive{
  HiveService? _globalHive;
  HiveService get globalHive{
    assert(_globalHive != null, 'Initialize the global hive first before using it '
        'by using GetIt.instance<HiveService>().init(context);');
    return _globalHive!;
  }

  Future<void> init(HiveService hiveService) async {
    await hiveService.init();
    _globalHive = hiveService;
  }
}