import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  DateTime? _selectedDate;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _widgetOptions = [
      Text(
        'Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
      Theme(
        data: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        child: CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          onDateChanged: (newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
        ),
      ),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? 'No Email';

    const Color mcdRed = Color.fromARGB(255, 255, 193, 35);
    const Color mcdYellow = Color.fromARGB(255, 40, 38, 35);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcdRed,
        title: Text('Welcome, $userEmail', style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: mcdYellow,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Text(
          'View and edit your profile any time.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 32),
        Text(
          'Personal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Divider(color: Colors.green),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          title: Text(
            'Dan Davidson',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Wholesale Manager'),
        ),
        ListTile(
          title: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Active'),
        ),
        ListTile(
          title: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('dan.davidson@heliumcoffee.com'),
        ),
        ListTile(
          title: Text('Office', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Head Office'),
        ),
        ListTile(
          title: Text('Report to', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Tamira Johnson'),
        ),
        SizedBox(height: 24),
        Text(
          'Basic information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Divider(color: const Color.fromARGB(255, 0, 0, 0)),
        ListTile(
          title: Text('First name', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Dan'),
          trailing: TextButton(
            onPressed: () {
            },
            child: Text('Edit', style: TextStyle(color: const Color.fromARGB(255, 135, 76, 175))),
          ),
        ),
        ListTile(
          title: Text('Last name', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Davidson'),
        ),
        ListTile(
          title: Text('Phone (work)', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('416-659-1543'),
        ),

      ],
    );
  }
}
