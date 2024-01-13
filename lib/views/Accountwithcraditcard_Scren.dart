import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../firabaseServices.dart';

class Accountwithcraditcard_Screen extends StatefulWidget {
  const Accountwithcraditcard_Screen({Key? key}) : super(key: key);

  @override
  State<Accountwithcraditcard_Screen> createState() =>
      _Accountwithcraditcard_ScreenState();
}

class _Accountwithcraditcard_ScreenState
    extends State<Accountwithcraditcard_Screen> {
  ///================================================================================///

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  ///================================================================================///

  ///================================== Banner ads ==================================///

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<void> initBannerAd() async {
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref('googleAds');
    Map? allData = await FirebaseServices.getData(databaseReference);
    _bannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: allData!['banner'],
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, LoadAdError error) {
          print("Failed to Load A Banner Ad${error.message}");
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request: const AdRequest());
    if (allData["showAds"] == true) {
      _bannerAd.load();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ad is not open"),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Color(0xff005D91),
            title: Text('Account With Credit Card',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color(0xffFFFFFF))),
            leading: Icon(
              Icons.home,
              color: Color(0xffFFFFFF),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset('asserts/images/AccountCreation.png',
                    width: 40),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 580,
                width: 340,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color(0xffBA65BD),
                        width: 2.5,
                        style: BorderStyle.solid)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'PayPal has become a popular and prevalent way of paying for items on the internet; it`s not just for eBay. Setting up an account isn`t difficult, but it does involve several steps. You`ll need to choose the type of account you want, link a debit or credit card or bank account, and select your options and settings.',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('* visit the paypal website:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'go to the official paypal website (www.paypal.com)',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('* sign up for free:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            'click on the sign up or ‘sign up for free’ button to start the registration process.',
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                letterSpacing: 1,
                                wordSpacing: 2,
                                height: 1.5)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(),
          if (_isBannerAdReady)
            SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),
    );
  }
}
