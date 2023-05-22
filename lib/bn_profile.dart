import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_room_services/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'aboutus.dart';
import 'bn_home.dart';
import 'bn_order.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'contactus.dart';
import 'edit_profile.dart';
import 'manage/static_method.dart';
import 'notification.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfilePage();
  }
}

final Uri _url = Uri.parse('https://thecarsdoctor.com/privacy');
final Uri refund = Uri.parse('https://thecarsdoctor.com/refund');
final Uri _urlterms = Uri.parse('https://thecarsdoctor.com/terms');
final Uri _urlyoutube =
    Uri.parse('https://www.youtube.com/channel/UC7RAD6UOCeRRfFORLvqWyoQ');
final Uri _urlfacebook =
    Uri.parse('https://www.facebook.com/profile.php?id=100086849307467');
final Uri _urlinstagram = Uri.parse(
    'https://www.instagram.com/thecarsdoctor?r=nametag');

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url,mode: LaunchMode.externalNonBrowserApplication)) {
    throw 'Could not launch $_url';
  }
}

class ProfilePage extends State<Profile> {
  late BuildContext ctx;

  String? name;
  String? mobile;
  String? email;

  void getProfileData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (await getLoginSession()) {
      setState(() {
        name = sp.getString("user_name").toString();
        mobile = sp.getString("user_mobile").toString();
        email = sp.getString("user_email").toString();
      });
    } else {
      // errorAlert(context, "Please login in order to continue");
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getProfileData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Clr().screenBackground,
      bottomNavigationBar: bottomBarLayout(ctx, 2),
      body: bodyLayout(),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        leading: InkWell(
          onTap: () {
            STM().back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffE48260),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
        ),
      ),
    );
  }

  //Body
  Widget bodyLayout() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name.toString(),
                              style: Sty().mediumText.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            InkWell(
                              onTap: () {
                                STM().redirect2page(ctx, EditProfile());
                              },
                              child: SvgPicture.asset('assets/edit.svg'),
                            ),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Image.asset('assets/car.png'),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Color(0xffE48260),
                            width: 20,
                            height: 4,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                'assets/mail (2).svg',
                              )),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(email.toString()),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 13),
                              child: SvgPicture.asset(
                                'assets/call (8).svg',
                              )),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text(mobile.toString()),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dim().d20)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              STM().redirect2page(ctx, Notifications());
                            },
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    'assets/Bell2.svg',
                                    color: Color(0xffE48260),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Notifications',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              STM().redirect2page(ctx, Order());
                            },
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    'assets/My Leads.svg',
                                    color: Color(0xffE48260),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'My Leads',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(onTap: (){
                            _launchUrl(Uri.parse("https://thecarsdoctor.com/assets/inspection_report_8168127.pdf"));
                          },
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    'assets/Download Sample Report (1).svg',
                                    color: Color(0xffE48260),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Download Sample Report',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child:
                                            Icon(Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              STM().redirect2page(ctx, Aboutus());
                            },
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                      'assets/about.svg',
                                      color: Color(0xffE48260),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'About Us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              STM().redirect2page(ctx, Contactus());
                            },
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child:
                                    SvgPicture.asset(
                                      'assets/phone.svg',
                                      height: Dim().d24,
                                      color: Color(0xffE48260),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Contact Us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _launchUrl(_url);
                            },
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                      'assets/privacy.svg',
                                      color: Color(0xffE48260),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _launchUrl(refund);
                            },
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                      'assets/refund.svg',
                                      color: Color(0xffE48260),
                                      height: Dim().d24,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Refund Policy',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // STM().redirect2page(ctx, MyOrder());
                              launchUrl(_urlterms);
                            },
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                      'assets/terms.svg',
                                      color: Color(0xffE48260),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () async {
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            setLoginFalse();
                            sp.clear();
                            STM().gotoPage(context, SignIn());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset(
                                    'assets/log out (4).svg',
                                    color: Color(0xffE48260),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded)))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          launchUrl(_urlyoutube);
                        },
                        child: SvgPicture.asset('assets/youtube.svg')),
                    InkWell(
                        onTap: () {
                          launchUrl(_urlfacebook);
                        },
                        child: SvgPicture.asset('assets/facebook.svg')),
                    InkWell(
                        onTap: () {
                          launchUrl(_urlinstagram);
                        },
                        child: SvgPicture.asset('assets/instagram.svg'),),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
