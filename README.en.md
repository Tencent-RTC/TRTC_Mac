# TRTC SDK

## Overview

Leveraging Tencent's many years of experience in network and audio/video technologies, Tencent Real-Time Communication (TRTC) offers solutions for group audio/video calls and low-latency interactive live streaming. With TRTC, you can quickly develop cost-effective, low-latency, and high-quality interactive audio/video services. [Learn more](https://cloud.tencent.com/document/product/647/16788).

> We offer SDKs for web, Android, iOS, macOS, Windows, Flutter, WeChat Mini Program, and [other mainstream platforms](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=).



## Changelog

### Version 9.7 released on April 6, 2022

**Improvement:** 
- iOS and Android: Optimized the effect of the Music sound quality.
  > Note: The Music sound quality can be enabled with the [TRTCCloud.startLocalAudio (TRTCAudioQualityMusic)](https://liteav.sdk.qcloud.com/doc/api/zh-cn/group__TRTCCloud__android.html#a1dadf09b10a2d128e4cef11707934329) API on all platforms.
- Windows: Optimized the capturing and playing effects under the Music sound quality to reduce the damage to the sound quality.
- Windows: Optimized the compatibility with certain professional sound cards to effectively improve the sound quality.
- Windows: Optimized audio mixing for third-party processes to adapt this feature to more scenarios.

**Bug fixes:**
- All platforms: Fixed occasional blurred screens during CDN playback.
- iOS and Android: Fixed the issue where the switch between receiver and speaker didn't work during live playback.
- iOS and Android: Fixed the issue where the actual sound quality didn't meet expectations when the Music sound quality was set through the API.
- iOS: Fixed occasional memory leaks during software encoding.
- iOS: Fixed the occasional issue where there was no first frame callback during local video rendering.
- Windows: Fixed the occasional crashes of cursor capturing in screen sharing mode.
- Windows: Fixed the issue where the speaker didn't work normally under the Music sound quality.
- Windows: Fixed the issue where certain cameras couldn't be turned on normally with `startCameraDeviceTest`.

For the release notes of earlier versions, click [More](https://cloud.tencent.com/document/product/647/46907).


## Contact Us
- If you have questions, see [FAQs](https://cloud.tencent.com/document/product/647/43018).

- To learn about how the TRTC SDK can be used in different scenarios, see [Sample Code](https://intl.cloud.tencent.com/document/product/647/42963).

- For complete API documentation, see [SDK API Documentation](http://doc.qcloudtrtc.com/md_introduction_trtc_Android_%E6%A6%82%E8%A7%88.html).
- For aftersales technical support, please [contact us](https://intl.cloud.tencent.com/contact-us).
- To report bugs in our sample code, please create an issue.
