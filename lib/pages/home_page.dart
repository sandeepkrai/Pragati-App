import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack/Community/MainPage.dart';
import 'package:hack/Courses/Course_Home.dart';
import 'package:hack/Management/Management/financeManagement.dart';
import 'package:hack/firebase/auth.dart';
import 'package:hack/firebase/db.dart';
import 'package:hack/harsh/lib/providers/cart_provider.dart';
import 'package:hack/harsh/lib/screen/home/home_page.dart';
import 'package:hack/pages/Users_Profile.dart';
import 'package:hack/pages/coming_soon.dart';
import 'package:hack/pages/home.dart';
import 'package:hack/pages/profile.dart';
import 'package:hack/pages/profile_setup.dart';
import 'package:hack/pages/settings.dart';
import 'package:provider/provider.dart';

class Friend {
  final String name;
  final String imageUrl;

  Friend({required this.name, required this.imageUrl});
}

class HomePage_Main extends StatefulWidget {
  @override
  _HomePage_MainState createState() => _HomePage_MainState();
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  const Pair(this.first, this.second);
}

class _HomePage_MainState extends State<HomePage_Main> {
  int _currentIndex = 0;

  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    switch (index) {
      case 1:
        {
          activities.insert(activities.length, "Visited Stores");
          setState(() {});
          final cart = Provider.of<Cart>(context, listen: false);

          await cart.storeAllItems();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage2()),
          );
        }
        break;
      case 2:
        {
          activities.insert(activities.length, "Visited Courses Page");
          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage_Course()),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ComingSoonPage()),
          // );
        }
        break;
      case 3:
        {
          activities.insert(activities.length, "Visited Community Page");
          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ComingSoonPage()),
          // );
        }
        break;
      case 4:
        {
          activities.insert(activities.length, "Visited Finance Page");
          setState(() {});
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => financeHomepage()),
          );
        }
    }
  }

  final List<Pair<String, int>> features = [
    Pair('FOMO Pvt. Ltd.', 0),
    Pair('XYZ Ltd.', 1),
    Pair('Baylink.in', 2),
  ];

  final List<String> activities = [];
  final List<Friend> friends = [
    Friend(name: 'John Doe', imageUrl: 'https://picsum.photos/id/237/200/300'),
    Friend(name: 'Jane Doe', imageUrl: 'https://picsum.photos/id/238/200/300'),
    Friend(name: 'Bob Smith', imageUrl: 'https://picsum.photos/id/239/200/300'),
    Friend(
        name: 'Alice Jones', imageUrl: 'https://picsum.photos/id/240/200/300'),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context, listen: false);
    return FutureBuilder(
        future: DataServices().isNewUser(user!.uid),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data == true) {
              return const ProfileSetup();
            } else {
              return Scaffold(
                backgroundColor: const Color.fromRGBO(250, 248, 241, 1),
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(206, 111, 89, 1),
                  title: Text('Home'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        // TODO: handle profile icon press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileInfoPage(
                                  userName: "Sandeep Rai",
                                  userEmail: "contact4rai@gmail.com")),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        // TODO: handle settings icon press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                  ],
                ),
                body: Container(
                  height: 800,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        items: features
                            .map((feature) => _buildFeatureCard(
                                feature.first, feature.second))
                            .toList() as List<Widget>?,
                        options: CarouselOptions(
                          height: 175.0,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Recent Activities',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      activities.length > 0
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: activities.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(activities[
                                        activities.length - 1 - index]),
                                    subtitle: Text('Today'),
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          Color.fromRGBO(206, 111, 89, 1),
                                      child: Text((index + 1).toString()),
                                    ),
                                    onTap: () {
                                      // Open activity detail page
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(
                              child: Text("No Recent Activity!!"),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'Make New Friends',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(friends[index].imageUrl),
                              ),
                              title: Text(friends[index].name),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  // TODO: add friend logic
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LinkedInProfileScreen(),
                                    ),
                                  );
                                },
                                child: Text('Add Friend'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(206, 111, 89, 1))),
                              ),
                            ),
                          );
                        },
                      )),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                      backgroundColor: Color.fromRGBO(206, 111, 89, 1),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.business),
                      label: 'Business',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      label: 'School',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.group),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.money),
                      label: 'Finance',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  onTap: _onItemTapped,
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        });
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Tab'),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorites Tab'),
    );
  }
}

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Tab'),
    );
  }
}

Widget _buildFeatureCard(String feature, int index) {
  List<Map<String, String>> items = [
    {
      'image':
          'https://media.licdn.com/dms/image/D4D12AQGlJXVjrRVQHA/article-cover_image-shrink_600_2000/0/1704220908258?e=2147483647&v=beta&t=1MRgNEJbhv-1h0L5w0bwIW6nRZxPwFM-5hDFpMMPnWI',
      'title': 'Fomo Pvt. Ltd.',
      'description': 'Founded by Sandeep Rai'
    },
    {
      'image':
          'https://theacademicinsights.com/wp-content/uploads/2021/03/women-empowerment-in-india.jpg',
      'title': 'Baylink.in',
      'description': 'Business Networking Platform'
    },
    {
      'image':
          'https://static.businessworld.in/article/article_extra_large_image/1615186282_J8GCFG_Women_entrepreneur_Nino_.jpg',
      'title': 'Nino Pvt. Ltd.',
      'description': 'Founded by Nino'
    },
  ];

  return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(206, 111, 89, 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 300,
              child: Image.network(
                items[index]['image']!,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10),
            Text(
              items[index]['title']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              items[index]['description']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ));
}
