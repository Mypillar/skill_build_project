import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mycourse.dart';
import 'support.dart';  // Import Support screen
import 'myprofile.dart'; // Import Profile screen

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  String userFullName = 'ChrisTech';
  int selectedCategoryIndex = -1; // For category selection state

  @override
  void initState() {
    super.initState();
    loadUserFullName();
  }

  Future<void> loadUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userFullName = prefs.getString('fullname') ?? 'ChrisTech';
    });
  }

  final List<Map<String, String>> popularCourses = [
    {"title": "Data Analytics", "image": "assets/data.jpg", "price": "\$19.99"},
    {"title": "Digital Marketing", "image": "assets/digital.jpg", "price": "\$14.99"},
    {"title": "UI/UX Design", "image": "assets/uiux.jpg", "price": "\$17.99"},
    {"title": "Machine Learning", "image": "assets/ml.jpg", "price": "\$21.99"},
    {"title": "Ai Essentials", "image": "assets/ai.jpg", "price": "\$25.99"},
    {"title": "Web Development", "image": "assets/webdev.jpg", "price": "\$18.99"},
    {"title": "Game Development", "image": "assets/gamedev.jpg", "price": "\$22.99"},
    {"title": "Cloud Computing", "image": "assets/cloud.jpg", "price": "\$19.99"},
    {"title": "Blockchain", "image": "assets/blockchain.jpg", "price": "\$30.99"},
    {"title": "Cybersecurity", "image": "assets/cybersecurity.jpg", "price": "\$27.99"},
    {"title": "Mobile App", "image": "assets/mobiledev.jpg", "price": "\$23.99"},
  ];

  final List<String> categories = [
    "Marketing",
    "Engineering",
    "Sales",
    "Product Management",
    "Data Science",
    "Customer Service",
    "UI/UX",
    "Programming",
  ];

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              logoutUser();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });

    // Navigate or update UI based on tab
    switch (index) {
      case 0:
      // Home, just stay here
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MyCourse()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const Support()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MyProfile()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                child: Icon(BootstrapIcons.person_fill),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Welcome $userFullName",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(BootstrapIcons.box_arrow_right),
            tooltip: "Logout",
            onPressed: confirmLogout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for courses...',
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(BootstrapIcons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),

            SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: popularCourses.length,
                controller: PageController(viewportFraction: 0.85),
                itemBuilder: (context, index) {
                  final course = popularCourses[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Selected course: ${course['title']}")),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          )
                        ],
                        image: DecorationImage(
                          image: AssetImage(course['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                        child: Text(
                          course['title']!,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Popular Courses", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("See All", style: TextStyle(color: Colors.teal)),
              ],
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularCourses.length,
                itemBuilder: (context, index) {
                  final course = popularCourses[index];
                  return InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Clicked on ${course['title']}")),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              course["image"]!,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(course["title"]!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(course["price"]!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),

            Text("Categories", style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = index == selectedCategoryIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(categories[index]),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategoryIndex = selected ? index : -1;
                        });
                      },
                      selectedColor: Colors.teal,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: isSelected ? 4 : 0,
                      // ignore: deprecated_member_use
                      shadowColor: Colors.teal.withOpacity(0.4),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(BootstrapIcons.house), label: "Home"),
          BottomNavigationBarItem(icon: Icon(BootstrapIcons.collection), label: "My Course"),
          BottomNavigationBarItem(icon: Icon(BootstrapIcons.headset), label: "Support"),
          BottomNavigationBarItem(icon: Icon(BootstrapIcons.person), label: "Profile"),
        ],
      ),
    );
  }
}
