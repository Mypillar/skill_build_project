import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import Support and Profile pages
import 'support.dart';
import 'myprofile.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({super.key});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  late VideoPlayerController _controller;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    try {
      _controller = VideoPlayerController.asset('sample_course.mp4')
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            _controller.setLooping(true);
            _controller.setVolume(1.0);
          }
        }).catchError((error) {
          print("Video initialization error: $error");
        });
    } catch (e) {
      print("Error initializing video: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  void onTabTapped(int index) {
    setState(() => currentIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
      // Already on My Course, do nothing
        break;
      case 2:
      // Navigate to Support page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Support()),
        );
        break;
      case 3:
      // Navigate to Profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyProfile()),
        );
        break;
    }
  }

  Widget buildVideoControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: const VideoProgressColors(
            playedColor: Colors.teal,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: IconButton(
            iconSize: 50,
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
          ),
        ),
      ],
    );
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
                child: Icon(BootstrapIcons.person_fill),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("My Course", style: TextStyle(fontSize: 12)),
                  Text("Mobile App Dev",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(BootstrapIcons.box_arrow_right),
            tooltip: "Logout",
            onPressed: logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: _controller.value.isInitialized
                    ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: buildVideoControls(),
                    ),
                  ],
                )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Mobile App Development",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Instructor: John Doe"),
                    SizedBox(height: 10),
                    LinearProgressIndicator(value: 0.35, color: Colors.teal),
                    SizedBox(height: 5),
                    Text("Progress: 35%"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Continue Watching...",
                    style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black26,
                ),
                child: const Center(
                  child: Icon(Icons.play_circle_fill,
                      color: Colors.white, size: 60),
                ),
              ),
            ),
            const SizedBox(height: 30),
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
