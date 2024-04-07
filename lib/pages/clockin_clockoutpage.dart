import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClockInClockOutPage extends StatefulWidget {
  @override
  _ClockInClockOutPageState createState() => _ClockInClockOutPageState();
}

class _ClockInClockOutPageState extends State<ClockInClockOutPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isClockedIn = false;
  bool _isLoading = false;

  void _recordEvent(String type) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No authenticated user found')),
      );
      return;
    }
    try {
      setState(() => _isLoading = true);
      await _firestore.collection('time_events').add({
        'userId': user.uid,
        'timestamp': Timestamp.now(),
        'type': type,
      });
      setState(() => _isClockedIn = type == 'Clock In');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully recorded $type event')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to record event: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isLoading)
          CircularProgressIndicator(),
        if (!_isLoading && !_isClockedIn)
          ElevatedButton(
            onPressed: () => _recordEvent('Clock In'),
            child: Text('Clock In'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        if (!_isLoading && _isClockedIn)
          ElevatedButton(
            onPressed: () => _recordEvent('Clock Out'),
            child: Text('Clock Out'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}




