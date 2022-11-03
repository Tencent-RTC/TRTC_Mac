# 腾讯云实时音视频 TRTC SDK

_[English](README.md) | 简体中文_

## 产品介绍

腾讯实时音视频（Tencent Real-Time Communication，TRTC），将腾讯多年来在网络与音视频技术上的深度积累，以多人音视频通话和低延时互动直播两大场景化方案，通过腾讯云服务向开发者开放，致力于帮助开发者快速搭建低成本、低延时、高品质的音视频互动解决方案，[更多](https://cloud.tencent.com/document/product/647/16788)...

> TRTC SDK 支持Web、Android、iOS、Mac、Windows以及Flutter、小程序等所有主流平台， [更多平台](https://github.com/LiteAVSDK?q=TRTC_&type=all&sort=)...



## 更新日志

### Version 10.8 @ 2022 10.31

**新特性**

- 全平台：新增搓碟音效，提供更加全面的在线 K 歌体验，详见：TXAudioEffectManager.[setMusicScratchSpeedRate](https://cloud.tencent.com/document/product/647/79623#314ea310a5f8f3a7c2d51599a47a4c99)。

**功能优化**

- Android：优化视频解码启动速度，有效提升画面秒开速度，最快可以达到 50ms。
- 全平台：优化 NTP 时间的准确性，详见：TXLiveBase.updateNetworkTime。

**缺陷修复**

- 全平台：修复下特定场景下（无音视频上行）[混流机器人](https://cloud.tencent.com/document/product/647/79626#ff59c8b94f588385a0ed3b39f6b6184a) 回推 TRTC 房间场景中，偶现的拉流异常以及回调错误的问题。
- 全平台：修复观众进房后切换角色时，因网络类型变化偶现的音视频上行失败问题。
- 全平台：修复在断网重连过程中出现的音质切换不生效问题。
- 全平台：修复在断网重连过程中偶现的上行无声问题。
- Android & iOS：修复当调用 muteRemoteVideoStream 时会移除最后一帧视频画面的问题。

更早期的版本更新历史请点击  [更多](https://cloud.tencent.com/document/product/647/46907)...


## 联系我们
- 如果你遇到了困难，可以先参阅 [常见问题](https://cloud.tencent.com/document/product/647/43018)；

- 如果你想了解TRTC SDK在复杂场景下的应用，可以参考[更多场景案例](https://cloud.tencent.com/document/product/647/57486)；

- 完整的 API 文档见 [SDK 的 API 文档](https://cloud.tencent.com/document/product/647/32258)；
- 如果需要售后技术支持, 你可以点击[这里](https://cloud.tencent.com/document/product/647/19906)；
- 如果发现了示例代码的 bug，欢迎提交 issue；
