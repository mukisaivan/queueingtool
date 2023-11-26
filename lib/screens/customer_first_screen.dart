import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:queueingtool/ads/ads.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/screens/customer_screen.dart';
import 'package:queueingtool/screens/service_widgets.dart';
import 'package:queueingtool/screens/turnto_premium_screen.dart';

class CustomerFirstScreen extends StatefulWidget {
  static const routeName = "/customer-first-screen";
  const CustomerFirstScreen({super.key});

  @override
  State<CustomerFirstScreen> createState() => _CustomerFirstScreenState();
}

class _CustomerFirstScreenState extends State<CustomerFirstScreen> {
  final BannerAd _bannerAd = BannerAd(
    size: AdSize.banner,
    adUnitId: Ads().banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        print("$ad loaded");
      },
      onAdFailedToLoad: (ad, err) {
        ad.dispose();
      },
    ),
  );

  @override
  void initState() {
    super.initState();

    _bannerAd.load();
    loadInterAd();
  }

  Future<Widget> checkUserAccountStatus() async {
    var userSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    var data = userSnap.data();
    var accountType = data!['accountType'];
    if (accountType != "Premium") {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, TurnToPremiumScreen.routeName);
        },
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 255, 179, 0))),
        child: const Text("Update to Premium"),
      );
    } else {
      return const SizedBox();
    }
  }

  InterstitialAd? _interstitialAd;

  void loadInterAd() {
    InterstitialAd.load(
        adUnitId: Ads().interstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // ad.dispose();
                  loadInterAd();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // ad.dispose();
                  loadInterAd();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Order Screen"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 255, 112, 160),
          Color.fromARGB(255, 234, 112, 255),
        ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: _bannerAd.size.height.toDouble(),
                  width: _bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd)),
              const SizedBox(height: 50),
              const ServiceSelectionWidget(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SignOutButton(context: context),
                  ElevatedButton(
                      onPressed: () {
                        _interstitialAd?.show();
                        Navigator.pushNamed(context, CustomerScreen.routeName);
                      },
                      child: const Text("Move To Orders Screen"))
                ],
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: checkUserAccountStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? const SizedBox();
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // void dispose() {
  //   _interstitialAd?.dispose();
  //   super.dispose();
  // }
}
