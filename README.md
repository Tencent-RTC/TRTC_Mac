# TRTC SDK

_[简体中文](README-zh_CN.md) | English_
## Overview

Leveraging Tencent's many years of experience in network and audio/video technologies, Tencent Real-Time Communication (TRTC) offers solutions for group audio/video calls and low-latency interactive live streaming. With TRTC, you can quickly develop cost-effective, low-latency, and high-quality interactive audio/video services. [Learn more](https://cloud.tencent.com/document/product/647/16788).

> We offer SDKs for web, Android, iOS, macOS, Windows, Flutter, WeChat Mini Program, and [other mainstream platforms](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=).



## Changelog
### Version 10.4 @ 2022.07.21

**New features:**
- iOS & Android: Support RGBA32 format in custom video capture, see: sendCustomVideoData;
- Windows & Mac: Support local preview when setting Watermark, see: setWaterMark;

**Function optimization:**
- Android: Optimized the compatibility of low-latency in-ear return and binaural capture;
- Android: Optimize the strategy of switching from hard decoding to soft decoding to improve decoding performance;
- iOS: Optimized the problem of low volume for iPad acquisition;

**Bug fixes:**

- All platforms: Fixed the occasional check-in and check-out callback exception;
- Windows: Fixed the problem that the content of the new window is clipped when switching the sharing window;

For the release notes of earlier versions, click [More](https://cloud.tencent.com/document/product/647/46907).


## Contact Us
- If you have questions, see [FAQs](https://cloud.tencent.com/document/product/647/43018).

- To learn about how the TRTC SDK can be used in different scenarios, see [Sample Code](https://intl.cloud.tencent.com/document/product/647/42963).

- For complete API documentation, see [SDK API Documentation](http://doc.qcloudtrtc.com/md_introduction_trtc_Android_%E6%A6%82%E8%A7%88.html).
- For aftersales technical support, please [contact us](https://intl.cloud.tencent.com/contact-us).
- To report bugs in our sample code, please create an issue.
