# 腾讯云实时音视频 TRTC SDK

_[English](README.md) | 简体中文_

## 产品介绍

腾讯实时音视频（Tencent Real-Time Communication，TRTC），将腾讯多年来在网络与音视频技术上的深度积累，以多人音视频通话和低延时互动直播两大场景化方案，通过腾讯云服务向开发者开放，致力于帮助开发者快速搭建低成本、低延时、高品质的音视频互动解决方案，[更多](https://cloud.tencent.com/document/product/647/16788)...

> TRTC SDK 支持Web、Android、iOS、Mac、Windows以及Flutter、小程序等所有主流平台， [更多平台](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=)...

## 更新日志
### Version 11.0 @ 2023.03.08

**新特性**
- Android：接口变更，TXLiveBase.setLibraryPath 返回类型调整为 bool，表示加载 SDK 动态库是否成功。

**功能优化**
- 全平台：提升弱网情况下在线 BGM 的播放成功率。
- 全平台：优化了 VideoCall 进房场景下，首帧播放流畅度。
- Android：优化音频兼容性，减少电流杂音、无声类问题。

**缺陷修复**
- 全平台：修复了使用 sendCustomCmdMsg 功能时，在频繁进退房情况下偶现的 crash 问题。
- 全平台：修复了本地退房时，错误回调远端主播的 onRemoteUserLeaveRoom、 onUserVideoAvailable、onUserAudioAvailable 问题。
- 全平台：修复了远端主播静音时，可能听到杂音的问题。

更早期的版本更新历史请点击  [更多](https://cloud.tencent.com/document/product/647/46907)...


## 联系我们
- 如果你遇到了困难，可以先参阅 [常见问题](https://cloud.tencent.com/document/product/647/43018)；

- 如果你想了解TRTC SDK在复杂场景下的应用，可以参考[更多场景案例](https://cloud.tencent.com/document/product/647/57486)；

- 完整的 API 文档见 [SDK 的 API 文档](https://cloud.tencent.com/document/product/647/32258)；
- 如果需要售后技术支持, 你可以点击[这里](https://cloud.tencent.com/document/product/647/19906)；
- 如果发现了示例代码的 bug，欢迎提交 issue；

>**提示:** 
> OCDemo 和 SwiftDemo仅支持MacOS 13.0 及以上版本。 