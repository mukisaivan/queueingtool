import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:queueingtool/ads/ads.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/methods/customer_order_methods.dart';

class CustomerScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreen();
}

class _CustomerScreen extends State<CustomerScreen> {
  @override
  void initState() {
    super.initState();
    loadInterVideoAd();
    Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      _interstitialVideoAd?.show();
    });
  }

  InterstitialAd? _interstitialVideoAd;

  void loadInterVideoAd() {
    InterstitialAd.load(
        adUnitId: Ads().interstitialVideo,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  _interstitialVideoAd!.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  _interstitialVideoAd!.dispose();
                },
                onAdClicked: (ad) {});
            _interstitialVideoAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer's Orders Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: CustomerOrderMethods().fetchOrders(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SignOutButton(context: context),
              ],
            )
          ],
        ),
      ),
    );
  }
}
