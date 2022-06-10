import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sertinary/constants/color_constants.dart';
import 'package:sertinary/constants/gradient_constants.dart';
import 'package:sertinary/screens/social_screens/widgets/circular_picture.dart';

class SocialProfile extends StatefulWidget {
  const SocialProfile({Key? key}) : super(key: key);

  @override
  State<SocialProfile> createState() => _SocialProfileState();
}

class _SocialProfileState extends State<SocialProfile> {
  ImageProvider<Object>? pfp;

  //AssetImage('assets/images/TempBackground.jpg')

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        foregroundColor: ColorConstants.mono95,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: GradientConstants.gradient1,
              ),
            ),
            Container(
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      pfp ?? const AssetImage('assets/images/Transparent.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 210,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30.0)),
                  color: ColorConstants.mono10,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 210 - 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularPicture(
                    height: 150,
                    width: 150,
                    image: null,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 9),
                  Text(
                    'Torpid Darren',
                    style: GoogleFonts.montserrat(
                      color: ColorConstants.mono95,
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 0),
                  Text(
                    'Selina\'s\n"Assistant"',
                    style: GoogleFonts.montserrat(
                      color: ColorConstants.mono70,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 9),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    color: ColorConstants.mono80,
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              '69',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.mono95,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Posts',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.mono70,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '420',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.mono95,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Followers',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.mono70,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '0',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.mono95,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Likes',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.mono70,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 2 * 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstants.accent50,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.mono00,
                                  spreadRadius: 3,
                                  blurRadius: 6,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                              gradient: GradientConstants.gradient1,
                            ),
                            child: Transform.scale(
                              scaleX: -1.2,
                              scaleY: 1.2,
                              child: Icon(
                                Icons.logout,
                                color: ColorConstants.mono05,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstants.accent50,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.mono00,
                                  spreadRadius: 3,
                                  blurRadius: 6,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                              gradient: GradientConstants.gradient1,
                            ),
                            child: Transform.scale(
                              scaleX: -1.2,
                              scaleY: 1.2,
                              child: Icon(
                                Icons.edit_outlined,
                                color: ColorConstants.mono05,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
