import 'package:flutter/material.dart';
import 'package:google_login/model/text_widget.dart';
import 'package:google_login/screens/a1.dart';
import 'package:google_login/screens/a2.dart';
import 'package:google_login/screens/a3.dart';
import 'package:google_login/widgets/article_card.dart';
import 'package:google_login/widgets/constants.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: TextWidget(
                  fontsize: 24,
                  fontweight: FontWeight.w500,
                  text: "Women Safety Artices",
                  color: Color.fromARGB(255, 35, 34, 34)),
            ),
          ),
          AticleWidget(
            image: "assets/a1.jpg",
            name: "Safety tips for Women-I",
            page: Blogs1Screen(),
            website:
                'https://emptynestblessed.com/2020/10/14/safety-tips-for-women/',
          ),
          Row(
            children: [
              for (int i = 0; i < MediaQuery.of(context).size.width; i++)
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 1,
                  ),
                ),
            ],
          ),
          AticleWidget(
            image: "assets/a2.jpg",
            name: "Safety tips for women-II",
            page: Blogs2Screen(),
            website: 'https://paladinsecurity.com/safety-tips/for-women/',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (int i = 0; i < MediaQuery.of(context).size.width; i++)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 1,
                    ),
                  ),
              ],
            ),
          ),
          AticleWidget(
            image: "assets/a3.jpg",
            name: "Safety tips for Women-III",
            page: Blogs3Screen(),
            website:
                'https://timesofindia.indiatimes.com/blogs/the-next-step/safety-tips-for-women/',
          ),
        ],
      ),
    );
  }
}
