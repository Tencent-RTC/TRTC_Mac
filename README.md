# TRTC SDK

_[简体中文](README-zh_CN.md) | English_
## Overview

Leveraging Tencent's many years of experience in network and audio/video technologies, Tencent Real-Time Communication (TRTC) offers solutions for group audio/video calls and low-latency interactive live streaming. With TRTC, you can quickly develop cost-effective, low-latency, and high-quality interactive audio/video services. [Learn more](https://www.tencentcloud.com/document/product/647/35078).

> We offer SDKs for web, Android, iOS, macOS, Windows, Flutter, WeChat Mini Program, and [other mainstream platforms](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=).



## Changelog
### **Version 10.7 @ 2022.09.20**

**New features:**

- All platforms: Mixing Stream supports adjusting the volume of each input stream, see [TRTCMixUser](https://cloud.tencent.com/document/product/647/79626#5934a926ba45ac0d5c9bd8632d3d44b5).soundLevel.
- All platforms: Added [onRemoteAudioStatusUpdated](https://cloud.tencent.com/document/product/647/79621#80ffbac8268b90337b6e8d4a8af2f997) callback, which can be used to better identify and monitor remote audio stream status.

**Function optimization:**

- All platforms: Upgraded the encoding core to improve the picture quality of screen sharing scenes.
- All platforms: Optimized the encoding code control effect under weak network.

**Bug fixes:**

- iOS: Fixed the issue that the volume of some iPad devices was low.
- Android: Fixed the problem that the bluetooth headset is occasionally connected but the sound is played out.
- All platforms: Fixed the occasional crash problem in frequent check-in and check-out scenarios.

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
