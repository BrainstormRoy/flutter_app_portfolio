import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Overlay background color
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xffEE3A57),
        ),
      ),
    );
  }
}
// if (isLoading) const LoadingIndicator(),
