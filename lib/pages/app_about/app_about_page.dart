import 'package:flutter/material.dart';

class AppAboutPage extends StatefulWidget {
  const AppAboutPage({super.key});

  @override
  State<AppAboutPage> createState() => _AppAboutPageState();
}

class _AppAboutPageState extends State<AppAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(""),
            ],
          ),
        ),
      ),
    );
  }

  final String text =
      '''Flutter Pixabay is a free mobile application developed by coderGhl that allows users to easily search and download high-quality images and videos from the Pixabay website. With a user-friendly interface and powerful search capabilities, this app is perfect for anyone looking for stunning visuals to use in their projects.

Thanks to the Pixabay API, all of the images and videos available on the website can be downloaded and used for free, making it an excellent resource for designers, bloggers, and content creators. Whether you’re looking for beautiful landscapes, cute animals, or stunning abstract art, you’re sure to find something that catches your eye on Pixabay.

With Flutter Pixabay, you can search for images and videos by keyword, browse popular categories, or even search by color. Once you’ve found the perfect image or video, you can download it directly to your device and use it however you like.

If you have any questions or issues with the app, please don’t hesitate to contact us at 2492911339@qq.com. We’re always happy to help! And if you’re interested in contributing to the development of Flutter Pixabay, be sure to check out our GitHub repository at https://github.com/coderghl/flutter_pixabay.

  ''';
}
