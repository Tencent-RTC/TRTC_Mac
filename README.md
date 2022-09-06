# TRTC SDK

_[简体中文](README-zh_CN.md) | English_
## Overview

Leveraging Tencent's many years of experience in network and audio/video technologies, Tencent Real-Time Communication (TRTC) offers solutions for group audio/video calls and low-latency interactive live streaming. With TRTC, you can quickly develop cost-effective, low-latency, and high-quality interactive audio/video services. [Learn more](https://www.tencentcloud.com/document/product/647/35078).

> We offer SDKs for web, Android, iOS, macOS, Windows, Flutter, WeChat Mini Program, and [other mainstream platforms](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=).



## Changelog
### Version 10.6 @ 2022.09.05

**Function optimization:**

- All platforms: Improved the room entry speed in the IPv6 network environment.
-  All platforms: Optimized the recovery efficiency of audio and the synchronization effect of audio and video in weak network environment to improve the call experience.
- All platforms: Optimized the connection retention ability in weak network environment and reduce the probability of disconnection and reconnection.
- All platforms: Optimized the problem of low volume in the Music gear (specified in startLocalAudio) to improve user experience.
- Mac: Optimized the communication experience when using a Bluetooth headset, with less noise and clearer sound.
- Android: Optimized the compatibility of stereo capture and support more models.
-  Android: Optimized the occasional echo leakage problem and improve the communication experience;

**Bug fixes:**

- Android & iOS: Fixed the occasional missing word problem in Speech gear (specified in startLocalAudio).
- Mac: Fixed occasional echo cancellation failure when switching between microphones.

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
