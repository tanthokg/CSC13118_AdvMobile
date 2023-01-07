import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/country_list.dart';
import 'package:lettutor/src/constants/user_level.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/user_service.dart';
import 'package:lettutor/src/widgets/select_date.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final _nameController = TextEditingController();
  String emailAddress = '';
  String phoneNumber = '';
  String birthday = '';
  String country = '';
  String level = '';
  List<int> chosenTopicIndexes = [];
  List<int> chosenTestPreparationIndexes = [];

  // bool _isLoading = true;
  bool _isInitiated = false;
  bool _isLoading = true;

  void _initiateUserProfile(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;
    final user = await UserService.getUserInfo(token);

    _nameController.text = user?.name ?? 'null name';
    emailAddress = user?.email ?? 'null email';
    phoneNumber = user?.phone ?? 'null phone number';
    birthday = user?.birthday ?? 'yyyy-MM-dd';
    country = user?.country ?? 'US';
    level = user?.level ?? 'BEGINNER';
    // _nameController.text = authProvider.currentUser.name ?? 'null name';
    // emailAddress = authProvider.currentUser.email ?? 'null email';
    // phoneNumber = authProvider.currentUser.phone ?? 'null phone number';
    // birthday = authProvider.currentUser.birthday ?? 'yyyy-MM-dd';
    // country = authProvider.currentUser.country ?? 'US';
    // level = authProvider.currentUser.level ?? 'BEGINNER';

    chosenTopicIndexes.clear();
    chosenTestPreparationIndexes.clear();
    for (int i = 0; i < authProvider.currentUser.learnTopics!.length; ++i) {
      final topicsName = authProvider.learnTopics.map((e) => e.name).toList();
      final userTopicName = authProvider.currentUser.learnTopics![i].name;
      if (topicsName.contains(userTopicName)) {
        chosenTopicIndexes.add(i);
      }
    }
    for (int i = 0; i < authProvider.currentUser.testPreparations!.length; ++i) {
      final topicsName = authProvider.testPreparations.map((e) => e.name).toList();
      final userTopicName = authProvider.currentUser.testPreparations![i].name;
      if (topicsName.contains(userTopicName)) {
        chosenTestPreparationIndexes.add(i);
      }
    }
    print(chosenTopicIndexes);
    print(chosenTestPreparationIndexes);

    setState(() {
      _isInitiated = true;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isInitiated = false;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (!_isInitiated) {
      _initiateUserProfile(authProvider);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: 108,
                          height: 108,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            authProvider.currentUser.avatar ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person_rounded),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 18,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _nameController,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Email Address',
                    style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                  ),
                  const SizedBox(height: 4),
                  Text(emailAddress),
                  const SizedBox(height: 16),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(phoneNumber),
                  const SizedBox(height: 16),
                  Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    value: countryList[country],
                    items: countryList.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (value) {
                      final chosenCountry = countryList.keys.firstWhere(
                        (element) => countryList[element] == value,
                        orElse: () => 'US',
                      );
                      setState(() {
                        country = chosenCountry;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Birthday',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  SelectDate(date: birthday),
                  const SizedBox(height: 16),
                  Text(
                    'Level',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    value: userLevels[level],
                    items: userLevels.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (value) {
                      final chosenLevel = userLevels.keys.firstWhere(
                        (element) => userLevels[element] == value,
                        orElse: () => 'BEGINNER',
                      );
                      setState(() {
                        level = chosenLevel;
                      });
                    },
                  ),
                  // DropdownButtonFormField(
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //       vertical: 4,
                  //       horizontal: 8,
                  //     ),
                  //     hintStyle: TextStyle(color: Colors.grey[400]),
                  //     border: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey, width: 2),
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  //   items: levels
                  //       .map((e) => DropdownMenuItem(
                  //             value: e,
                  //             child: Text(e),
                  //           ))
                  //       .toList(),
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(height: 16),
                  Text(
                    'Topic',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                      authProvider.learnTopics.length,
                      (index) => ChoiceChip(
                        backgroundColor: Colors.grey[100],
                        selectedColor: Colors.lightBlue[100],
                        selected: chosenTopicIndexes.contains(index),
                        label: Text(
                          authProvider.learnTopics[index].name ?? 'null',
                          style: TextStyle(
                            fontSize: 14,
                            color: chosenTopicIndexes.contains(index)
                                ? Colors.blue[700]
                                : Colors.black54,
                          ),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              chosenTopicIndexes.add(index);
                            } else {
                              chosenTopicIndexes.remove(index);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  // DropdownButtonFormField(
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //       vertical: 4,
                  //       horizontal: 8,
                  //     ),
                  //     hintStyle: TextStyle(color: Colors.grey[400]),
                  //     border: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey, width: 2),
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  //   items: learnTopics.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(height: 16),
                  Text(
                    'Test Preparation',
                    style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: List<Widget>.generate(
                      authProvider.testPreparations.length,
                      (index) => ChoiceChip(
                        backgroundColor: Colors.grey[100],
                        selectedColor: Colors.lightBlue[100],
                        selected: chosenTestPreparationIndexes.contains(index),
                        label: Text(
                          authProvider.testPreparations[index].name ?? 'null',
                          style: TextStyle(
                            fontSize: 14,
                            color: chosenTestPreparationIndexes.contains(index)
                                ? Colors.blue[700]
                                : Colors.black54,
                          ),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              chosenTestPreparationIndexes.add(index);
                            } else {
                              chosenTestPreparationIndexes.remove(index);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  // DropdownButtonFormField(
                  //   decoration: InputDecoration(
                  //     contentPadding: const EdgeInsets.symmetric(
                  //       vertical: 4,
                  //       horizontal: 8,
                  //     ),
                  //     hintStyle: TextStyle(color: Colors.grey[400]),
                  //     border: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.grey, width: 2),
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  //   items:
                  //       testPreparations.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
