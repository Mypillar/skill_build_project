import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  int currentIndex = 2; // Index for Support tab

  void onTabTapped(int index) {
    setState(() => currentIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/mycourse');
        break;
      case 2:
        break; // Already on support screen
      case 3:
        Navigator.pushReplacementNamed(context, '/myprofile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 180,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                child: Icon(BootstrapIcons.headset),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Support", style: TextStyle(fontSize: 12)),
                  Text("Need Help?", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            Text("How can we help you?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Feel free to reach out for technical support, account issues, or course help.",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(BootstrapIcons.envelope),
              title: Text("support@example.com"),
              subtitle: Text("Send us an email"),
            ),
            ListTile(
              leading: Icon(BootstrapIcons.phone),
              title: Text("+1 234 567 890"),
              subtitle: Text("Call our support team"),
            ),
            ListTile(
              leading: Icon(BootstrapIcons.chat_dots),
              title: Text("Live Chat"),
              subtitle: Text("Start a live conversation"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.house_fill),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.play_circle_fill),
            label: "My Course",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.headset),
            label: "Support",
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.person_circle),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
