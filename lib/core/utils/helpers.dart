  String formatTimestamp(DateTime timestamp) {
    return '${timestamp.month}/${timestamp.day} ${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }