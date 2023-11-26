import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  String mobileAppId = "ca-app-pub-4958641753656414~4032058437";
  String iosAppid = "ca-app-pub-4958641753656414~3788515852";
  String mobilebanner1Id = "ca-app-pub-4958641753656414/4142032785";
  String appOpen = "ca-app-pub-3940256099942544/9257395921";
  String adaptiveBanner = "ca-app-pub-3940256099942544/9214589741";
  String banner = "ca-app-pub-3940256099942544/6300978111";
  String interstitial = "ca-app-pub-3940256099942544/1033173712";
  String interstitialVideo = "ca-app-pub-3940256099942544/8691691433";
  String rewarded = "ca-app-pub-3940256099942544/5224354917";
  String rewardedInterstitial = "ca-app-pub-3940256099942544/5354046379";
  String nativeAdvanced = "ca-app-pub-3940256099942544/2247696110";
  String nativeAdvancedVideo = "ca-app-pub-3940256099942544/1044960115";

  displayNativeAd() {
    var nativeAdvanced = NativeAd(
      adUnitId: Ads().nativeAdvanced,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print("$ad loaded");
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    nativeAdvanced.load();
  }
}

// class AdDisplay extends StatefulWidget {
//   const AdDisplay({super.key});

//   @override
//   State<AdDisplay> createState() => _AdDisplayState();
// }

// class _AdDisplayState extends State<AdDisplay> {
//   @override
//   void initState() {
//     Ads().displaybannerAd(bannerAd);
//     super.initState();
//   }

//   var adSize = AdSize.banner;

//   late final bannerAd = BannerAd(
//     size: adSize,
//     adUnitId: Ads().mobilebanner1Id,
//     request: const AdRequest(),
//     listener: BannerAdListener(
//       onAdLoaded: (ad) {},
//       onAdFailedToLoad: (ad, err) {
//         ad.dispose();
//       },
//     ),
//   );

//   @override
//   @override
//   void dispose() {
//     bannerAd.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         width: adSize.width.toDouble(),
//         height: adSize.height.toDouble(),
//         child: bannerAd == null
//             // Nothing to render yet.
//             ? const SizedBox()
//             // The actual ad.
//             : AdWidget(ad: bannerAd),
//       ),
//     );
//   }
// }

class AdDisplay extends StatefulWidget {
  const AdDisplay({Key? key}) : super(key: key);

  @override
  State<AdDisplay> createState() => _AdDisplayState();
}

class _AdDisplayState extends State<AdDisplay> {
  late final BannerAd bannerAd;

  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Ads().mobilebanner1Id,
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

    // Load the ad before the widget is inserted into the tree.
    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: bannerAd.size.width.toDouble(),
        height: bannerAd.size.height.toDouble(),
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
