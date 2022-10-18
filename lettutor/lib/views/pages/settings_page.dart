import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/user-avatar-01.png'),
            ),
          ),
          const SizedBox(height: 12),
          Align(
              alignment: Alignment.center,
              child: Text(
                'Huỳnh Tấn Thọ',
                style: Theme.of(context).textTheme.headline3,
              )),
          //const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.userProfile);
            },
            child: const Text('Edit Profile'),
          ),
          // Functions Starts Here
          const SizedBox(height: 16),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.history,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'History',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.assignment,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Become A Tutor',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.manage_accounts,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Account',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.language,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Language',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.privacy_tip_outlined,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.newspaper_outlined,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.contact_mail_outlined,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Contact',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: const [
                  Icon(
                    Icons.contact_support_outlined,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Guide',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              backgroundColor: const Color.fromRGBO(255, 0, 0, 0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
