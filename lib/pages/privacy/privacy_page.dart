import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  final String intrduction =
      'At Flutter Pixabay, we are committed to protecting the privacy of our users. This Privacy Policy outlines how we collect, use, and disclose information in connection with our mobile application, Flutter Pixabay.';

  final String collect =
      "We do not collect any personal information from our users. We do not require users to create an account or provide any personal information to use our app. We do not collect any information about your device, location, or usage of our app.";

  final String userInfomation =
      'Since we do not collect any personal information, we do not use any information for any purpose.Disclosure of Information\nWe do not disclose any personal information to any third parties. We do not share any information with any advertisers, analytics providers, or other third parties.';

  final String security =
      "We take reasonable measures to protect the security of our users’ information. We use industry-standard encryption to protect any information that is transmitted between our app and our servers.";

  final String contactUs =
      "If you have any questions or concerns about our Privacy Policy, please contact us at 2492911339@qq.com.";

  final String change =
      "We may update our Privacy Policy from time to time. We will notify users of any changes by posting the updated Privacy Policy on our website. Users are encouraged to review the Privacy Policy periodically to stay informed about how we are protecting their privacy.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Privacy Policy for Flutter Pixabay App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                intrduction,
                style: const TextStyle(height: 1.8),
              ),
              const SizedBox(height: 8),
              const Text(
                "Information We Collect",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                collect,
                style: const TextStyle(height: 1.8),
              ),
              const SizedBox(height: 8),
              const Text(
                "Use of Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                userInfomation,
                style: const TextStyle(height: 1.8),
              ),
              const SizedBox(height: 8),
              const Text(
                "Security",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                security,
                style: const TextStyle(height: 1.8),
              ),
              const SizedBox(height: 8),
              const Text(
                "Contact Us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                contactUs,
                style: const TextStyle(height: 1.8),
              ),
              const SizedBox(height: 8),
              const Text(
                "Changes to Privacy Policy",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                change,
                style: const TextStyle(height: 1.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
