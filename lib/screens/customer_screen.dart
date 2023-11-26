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
  }

  InterstitialAd? _interstitialVideoAd;

  void loadInterVideoAd() {
    InterstitialAd.load(
        adUnitId: Ads().interstitialVideo,
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
                  loadInterVideoAd();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // ad.dispose();
                  loadInterVideoAd();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _interstitialVideoAd = ad;
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
                ElevatedButton(
                  onPressed: () => _interstitialVideoAd?.show(),
                  child: const Text("show add"),
                ),
                SignOutButton(context: context),
              ],
            )
          ],
        ),
      ),
    );
  }
}
