// import 'package:flutter/material.dart';

// Widget _buildPasswordStrengthIndicator({required double strength}) {
//   return LinearProgressIndicator(
//     value: strength,
//     backgroundColor: Colors.grey[300],
//     color: _getStrengthColor(),
//     minHeight: 6,
//   );
// }

// Widget _buildPasswordStrengthText({required double strength}) {
//   String text;
//   if (strength == 0) {
//     text = '';
//   } else if (strength < 0.3) {
//     text = 'Weak';
//   } else if (strength < 0.6) {
//     text = 'Fair';
//   } else if (strength < 0.8) {
//     text = 'Good';
//   } else {
//     text = 'Strong';
//   }

//   return Text(
//     text,
//     style: TextStyle(
//       color: _getStrengthColor(),
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Color _getStrengthColor() {
//   if (_strength < 0.3) return Colors.red;
//   if (_strength < 0.6) return Colors.orange;
//   if (_strength < 0.8) return Colors.blue;
//   return Colors.green;
// }