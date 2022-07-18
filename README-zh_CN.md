# 腾讯云实时音视频 TRTC SDK

_[English](README.md) | 简体中文_

## 产品介绍

腾讯实时音视频（Tencent Real-Time Communication，TRTC），将腾讯多年来在网络与音视频技术上的深度积累，以多人音视频通话和低延时互动直播两大场景化方案，通过腾讯云服务向开发者开放，致力于帮助开发者快速搭建低成本、低延时、高品质的音视频互动解决方案，[更多](https://cloud.tencent.com/document/product/647/16788)...

> TRTC SDK 支持Web、Android、iOS、Mac、Windows以及Flutter、小程序等所有主流平台， [更多平台](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=)...



## 更新日志
### Version 10.3 @ 2022.07.06

**新特性：**

- Windows：新增录制本地录制功能，可用于在本地录制互动直播或音视频通话完整内容。详见 ITXLiteAVLocalRecord；
- Windows&Mac：新增参数支持在startMicDeviceTest 接口中开启/关闭 播放麦克风检测时麦克风采集到的声音。详见 startMicDeviceTest；

**功能优化:**

- 全平台：优化 Music 音质下的声音效果；

**缺陷修复:**

- 全平台：修复房间用户列表偶现的回调异常问题；
- Windows：修复视频播放过程偶现的画面卡住问题；
- Windows：修复视频播放过程偶现的播放失败问题；
- Windwos：修复音频自定义采集场景中出现回声的问题；

更早期的版本更新历史请点击  [更多](https://cloud.tencent.com/document/product/647/46907)...


## 联系我们
- 如果你遇到了困难，可以先参阅 [常见问题](https://cloud.tencent.com/document/product/647/43018)；

- 如果你想了解TRTC SDK在复杂场景下的应用，可以参考[更多场景案例](https://cloud.tencent.com/document/product/647/57486)；

- 完整的 API 文档见 [SDK 的 API 文档](http://doc.qcloudtrtc.com/md_introduction_trtc_Android_%E6%A6%82%E8%A7%88.html)；
- 如果需要售后技术支持, 你可以点击[这里](https://cloud.tencent.com/document/product/647/19906)；
- 如果发现了示例代码的 bug，欢迎提交 issue；
