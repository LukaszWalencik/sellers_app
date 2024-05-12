import 'package:flutter/material.dart';
import 'package:sellers_app/screens/authentication/auth_screen.dart';
import 'package:sellers_app/screens/global/global.dart';
import 'package:sellers_app/screens/home_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(80),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString('sellerAvatarURL')!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  sharedPreferences!.getString('sellerName')!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: 'Train'),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(
              top: 1,
            ),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'My earnings',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'New orders',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.local_shipping,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'History - Orders',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                          ),
                        );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
