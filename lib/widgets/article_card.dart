import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_login/model/text_widget.dart';

class AticleWidget extends StatelessWidget {
  final name;
  final image;
  final page;
  final website;
  const AticleWidget(
      {super.key, this.name, required this.image, this.page, this.website});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 240,
                //width: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        image,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                height: 240,
                //width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black45.withOpacity(0.3),
                      Colors.black54.withOpacity(0.3),
                      Colors.black38.withOpacity(0.3),
                    ],
                    stops: [0.1, 0.5, 0.7, 0.8],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Column(
                  children: [
                    TextWidget(
                        fontsize: 24,
                        fontweight: FontWeight.w500,
                        text: name,
                        color: Color.fromARGB(255, 219, 216, 216)),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 24,
                    color: Colors.white,
                    onPressed: () async {
                      await Share.share(website,
                          subject: "Safety tips for women");
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
