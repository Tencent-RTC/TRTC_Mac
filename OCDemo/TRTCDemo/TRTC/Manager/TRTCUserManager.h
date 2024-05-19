//
//  TRTCUserManager.h
//  TXLiteAVMacDemo
//
//  Created by Xiaoya Liu on 2020/2/28.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDKHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class TXRenderView;

@interface TRTCUserConfig : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic) BOOL isAudioAvailable;
@property (nonatomic) BOOL isAudioMuted;

@property (nonatomic) BOOL isVideoAvailable;
@property (nonatomic) BOOL isVideoMuted;

@property (nonatomic) BOOL isAudioOn;
@property (nonatomic) BOOL isVideoOn;

@property (nonatomic, strong) TXRenderView *renderView;

@end


@interface TRTCUserManager : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, TRTCUserConfig *> *userList;

// Observable for userList
@property (nonatomic, strong) NSArray<TRTCUserConfig *> *userConfigs;

- (instancetype)initWithUserId:(NSString *)userId;

- (void)addUser:(NSString *)userId;

- (void)removeUser:(NSString *)userId;

- (void)setUser:(NSString *)userId videoAvailable:(BOOL)videoAvailable;

- (void)setUser:(NSString *)userId audioAvailable:(BOOL)audioAvailable;

- (void)muteVideo:(BOOL)isMuted withUser:(NSString *)userId;

- (void)muteAudio:(BOOL)isMuted withUser:(NSString *)userId;

- (void)muteAllRemoteVideo:(BOOL)isMuted;

- (void)muteAllRemoteAudio:(BOOL)isMuted;

- (void)setVolumes:(NSArray<TRTCVolumeInfo *> *)userVolumes;

- (void)setLocalNetQuality:(TRTCQualityInfo *)quality;

- (void)setRemoteNetQuality:(NSArray<TRTCQualityInfo *> *)remoteQuality;

/// Temporarily stop videos that do not appear on the interface
- (void)hideRenderViewExceptUser:(NSString *)userId;

/// Resume temporarily stopped video
- (void)recoverAllRenderViews;

@end

NS_ASSUME_NONNULL_END
