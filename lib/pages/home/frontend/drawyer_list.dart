import 'package:flutter/material.dart';
import 'package:portfolio_app/global/widgets/custom_text.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
  });
  final void Function()? onTap;
  final IconData icon;
  final String title;
  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: Icon(
        widget.icon,
        size: 20.0,
        color: const Color(0xffFBFBFD),
      ),
      title: CustomText01(
        text: widget.title,
        fontSize: 16.0,
        color: const Color(0xffFBFBFD),
      ),
      trailing: const Icon(
        Icons.navigate_next,
        color: Color(0xffFBFBFD),
      ),
    );
  }
}
