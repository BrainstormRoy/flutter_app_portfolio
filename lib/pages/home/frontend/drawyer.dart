import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/widgets/custom_text.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  bool _switchValue = true;

  setValue(bool switchValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric', switchValue);
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? value = prefs.getBool('biometric');
    setState(() {
      _switchValue = value ?? false;
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xff1C1E33),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                ListTile(
                  enabled: _switchValue,
                  leading: const Icon(
                    Icons.lock_outlined,
                    size: 20.0,
                    color: Color(0xffFBFBFD),
                  ),
                  title: const CustomText01(
                    text: 'Authenticate',
                    fontSize: 16.0,
                    color: Color(0xffFBFBFD),
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.amber,
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = !_switchValue;
                        setValue(_switchValue);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// color: Color(0xffFBFBFD),
// Color(0xffEE3A57),