# TRTC SDK

_[简体中文](README-zh_CN.md) | English_
## Overview

Leveraging Tencent's many years of experience in network and audio/video technologies, Tencent Real-Time Communication (TRTC) offers solutions for group audio/video calls and low-latency interactive live streaming. With TRTC, you can quickly develop cost-effective, low-latency, and high-quality interactive audio/video services. [Learn more](https://www.tencentcloud.com/document/product/647/35078).

> We offer SDKs for web, Android, iOS, macOS, Windows, Flutter, WeChat Mini Program, and [other mainstream platforms](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=).



## Changelog

### Version 11.2 @ 2023.06.05

**New features**

 - Cross-platform: Supports seamless switching between instrumentals and original vocals of BGM in duet scenes. See `setMusicTrack` for details.
 - Android: To be compatible with the foreground service launch restrictions on Android 12 and above, a foreground service is initiated during screen capture. See `enableForegroundService` for details.
 - iOS: Supports use in the Xcode simulator running on Apple chip hardware.
 - Mac: `TRTCScreenSourceInfo` adds property value width and height.

**Improvements**

- Cross-platform: Optimized sound quality in duet scenes, and reduced end-to-end latency.
- Cross-platform: Optimized performance when turning on/off microphone, providing a smoother experience.
- Cross-platform: Optimized audio experience under extremely bad networks.
- Cross-platform: Optimized weak network experience when broadcast live stream only.
- Cross-platform: Optimized the smoothness of switching high-quality and low-quality remote video streams.
- Android & iOS: Optimized audio quality in music scenes.
- Android & iOS: Optimized the experience with Bluetooth headphones.
- Android: Optimized hardware decoder latency, improving the speed of rendering the first video image.
- Android: Optimized the in-ear monitoring feature, enhancing the experience when switching on/off in-ear monitoring.
- Android: Optimized the audio devices capture compatibility.
- iOS: Optimized quality of video, enhancing image clarity.

For the release notes of earlier versions, click [More](https://www.tencentcloud.com/document/product/647/39426).


## Contact Us
- If you have questions, see [FAQs](https://www.tencentcloud.com/document/product/647/36057).

- To learn about how the TRTC SDK can be used in different scenarios, see [Sample Code](https://www.tencentcloud.com/document/product/647/42963).

- For complete API documentation, see [SDK API Documentation](https://www.tencentcloud.com/document/product/647/35119).

- Communication & Feedback   
Welcome to join our Telegram Group to communicate with our professional engineers! We are more than happy to hear from you~
Click to join: [https://t.me/+EPk6TMZEZMM5OGY1](https://t.me/+EPk6TMZEZMM5OGY1)   
Or scan the QR code   
  <img src="https://qcloudimg.tencent-cloud.cn/raw/79cbfd13877704ff6e17f30de09002dd.jpg" width="300px">    

>**Notice:** 
> OCDemo and SwiftDemo only support MacOS 13.0 and above.
