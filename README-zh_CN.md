# 腾讯云实时音视频 TRTC SDK

_[English](README.md) | 简体中文_

## 产品介绍

腾讯实时音视频（Tencent Real-Time Communication，TRTC），将腾讯多年来在网络与音视频技术上的深度积累，以多人音视频通话和低延时互动直播两大场景化方案，通过腾讯云服务向开发者开放，致力于帮助开发者快速搭建低成本、低延时、高品质的音视频互动解决方案，[更多](https://cloud.tencent.com/document/product/647/16788)...

> TRTC SDK 支持Web、Android、iOS、Mac、Windows以及Flutter、小程序等所有主流平台， [更多平台](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=)...



## 更新日志
### Version 10.6 @2022.09.05

**功能优化:** 

- 全平台：提升在 IPv6 网络环境下的进房速度。
- 全平台：优化弱网络环境下音频的恢复效率以及音画同步效果，提升通话体验。
- 全平台：优化弱网络环境下的连接保持能力，减少断网重连概率。
- 全平台：优化 Music 档位（在 startLocalAudio 时指定）下音量较小的问题，提升用户体验。
- Mac：优化使用蓝牙耳机时的沟通体验，杂音更少，声音更清晰。
- Android：优化立体声采集的兼容性，支持更多机型。
- Android：优化偶现的漏回声问题，提升沟通体验；

**缺陷修复:** 

- Android & iOS：修复在 Speech 档位（在 startLocalAudio 时指定）下偶现的漏字问题。
- Mac：修复切换麦克风时偶现的回声消除失效的问题。

更早期的版本更新历史请点击  [更多](https://cloud.tencent.com/document/product/647/46907)...


## 联系我们
- 如果你遇到了困难，可以先参阅 [常见问题](https://cloud.tencent.com/document/product/647/43018)；

- 如果你想了解TRTC SDK在复杂场景下的应用，可以参考[更多场景案例](https://cloud.tencent.com/document/product/647/57486)；

- 完整的 API 文档见 [SDK 的 API 文档](https://cloud.tencent.com/document/product/647/32258)；
- 如果需要售后技术支持, 你可以点击[这里](https://cloud.tencent.com/document/product/647/19906)；
- 如果发现了示例代码的 bug，欢迎提交 issue；
