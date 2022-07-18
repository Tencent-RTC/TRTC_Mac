# TRTC SDK

_[简体中文](README-zh_CN.md) | English_
## Overview

Leveraging Tencent's many years of experience in network and audio/video technologies, Tencent Real-Time Communication (TRTC) offers solutions for group audio/video calls and low-latency interactive live streaming. With TRTC, you can quickly develop cost-effective, low-latency, and high-quality interactive audio/video services. [Learn more](https://cloud.tencent.com/document/product/647/16788).

> We offer SDKs for web, Android, iOS, macOS, Windows, Flutter, WeChat Mini Program, and [other mainstream platforms](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=).



## Changelog
### Version 10.3 @ 2022.07.06

**New features:**

- Windows: Add local recording function, which can be used to record the full content of live or calls. See: ITXLiteAVLocalRecord;

- Windows&Mac: Add parameter in the startMicDeviceTest interface to enable/disable play the sound collected by the microphone during microphone detection. See: startMicDeviceTest

**Function optimization:**

- All platforms: Optimize the sound effect for Music quality;

**Bug fixes:**

- All platforms: Fixed the occasional callback exception in the room user list;

- Windows: Fixed the occasional screen freeze problem during video playback;

- Windows: Fixed the occasional playback failure during video playback;

- Windows: Fixed the problem of echo in custom audio capture scene;

For the release notes of earlier versions, click [More](https://cloud.tencent.com/document/product/647/46907).


## Contact Us
- If you have questions, see [FAQs](https://cloud.tencent.com/document/product/647/43018).

- To learn about how the TRTC SDK can be used in different scenarios, see [Sample Code](https://intl.cloud.tencent.com/document/product/647/42963).

- For complete API documentation, see [SDK API Documentation](http://doc.qcloudtrtc.com/md_introduction_trtc_Android_%E6%A6%82%E8%A7%88.html).
- For aftersales technical support, please [contact us](https://intl.cloud.tencent.com/contact-us).
- To report bugs in our sample code, please create an issue.
