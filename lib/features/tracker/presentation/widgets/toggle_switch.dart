import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final bool status;
  final Function(bool)? onToggle;
  const ToggleSwitch({super.key, this.status = false, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: status,
          onChanged: onToggle,
          activeThumbColor: Color(0xFF42f5b3),
          activeTrackColor: Color(0xFFF2F2F2),
          inactiveThumbColor: Color(0xFFB8B8B8),
          inactiveTrackColor: Color(0xFFF2F2F2),
          trackOutlineColor: WidgetStatePropertyAll(status ? Color(0xFFF2F2F2) : Color(0xFFF2F2F2)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          thumbIcon: WidgetStatePropertyAll(Icon(Icons.circle, color: Colors.transparent)),
        ),

        /// Status
        Text(status ? 'ON' : 'OFF', style: TextStyle(fontSize: 14, color: status ? Color(0xFF35a67c) : Color(0xFFB8B8B8), fontWeight: FontWeight.w700, fontFamily: 'Poppins')),
      ],
    );
  }
}
