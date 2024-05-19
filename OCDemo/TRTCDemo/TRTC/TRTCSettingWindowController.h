//
//  TRTCSettingWindowController.h
//  TXLiteAVMacDemo
//
//  Created by ericxwli on 2018/10/17.
//  Copyright © 2018 Tencent. All rights reserved.
//

// Used to adjust the resolution, frame rate and smooth mode of video calls, and supports recording these settings

#import <Cocoa/Cocoa.h>
#import "SDKHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TXAVSettingTabIndex) {
    TXAVSettingTabIndexGeneral,
    TXAVSettingTabIndexVideo,
    TXAVSettingTabIndexAudio
};

@interface TRTCSettingWindowController : NSWindowController
@property (class, readonly) int fps;
@property (class, readonly) TRTCVideoResolution resolution;
@property (class, readonly) int bitrate;
@property (class, readonly) TRTCVideoResolutionMode resolutionMode;
@property (class, readonly) TRTCVideoQosPreference qosPreference;
@property (class, readonly) TRTCQosControlMode qosControlMode;
@property (class, readonly) BOOL isAudience;

@property (class, readonly) BOOL pushDoubleStream;
@property (class, readonly) BOOL playSmallStream;
@property (class, readonly) TRTCAppScene scene;
@property (class, readonly) BOOL showVolume;
@property (class, readonly) TRTCTranscodingConfigMode mixMode;


@property (nonatomic, strong, nullable) NSString *userID;
@property (nonatomic, strong, nullable) NSString *roomID;

// Call scene button
@property (strong) IBOutlet NSButton *callSceneButton;
// Live scene button
@property (strong) IBOutlet NSButton *liveSceneButton;

// Prioritize smooth button
@property (strong) IBOutlet NSButton *smoothBtn;
//Prioritize clear button
@property (strong) IBOutlet NSButton *clearBtn;

//Client control
@property (strong) IBOutlet NSButton *clientBtn;
// Cloud control
@property (strong) IBOutlet NSButton *cloudBtn;

// Horizontal screen
@property (strong) IBOutlet NSButton *portraitResolutionBtn;
@property (strong) IBOutlet NSButton *landscapeResolutionBtn;
//vertical screen

//General settings interface
@property (strong) IBOutlet NSView *generalSettingView;

//Audio setting interface
@property (strong) IBOutlet NSView *audioSettingView;
//Video setting interface
@property (strong) IBOutlet NSView *videoSettingView;
//Set interface container
@property (strong) IBOutlet NSView *settingField;
// Video settings interface preview view
@property (strong) IBOutlet NSView *cameraPreview;
// left menu
@property (strong) IBOutlet NSTableView *sidebarMenu;
//Whether video or audio is currently selected
@property (assign, nonatomic) TXAVSettingTabIndex tabIndex;
//Camera selection control
@property (strong) IBOutlet NSPopUpButton *cameraItems;
// Speaker selection control
@property (strong) IBOutlet NSPopUpButton *speakerItems;
// Microphone selection control
@property (strong) IBOutlet NSPopUpButton *micItems;
//Resolution selection control
@property (strong) IBOutlet NSPopUpButton *resolutionItems;
// fps selection control
@property (strong) IBOutlet NSPopUpButton *fpsItems;
// code rate display
@property (strong) IBOutlet NSTextField *bitrateLabel;
// code rate slider
@property (strong) IBOutlet NSSlider *bitrateSlider;
//Microphone volume slider
@property (strong) IBOutlet NSSlider *micVolumeSlider;
// Speaker volume slider
@property (strong) IBOutlet NSSlider *speakerVolumeSlider;
//Recording volume indicator
@property (weak) IBOutlet NSLevelIndicator *volumeMeter;
// Speaker volume indicator
@property (weak) IBOutlet NSLevelIndicator *speakerVolumeMeter;
// Share button
@property (weak) IBOutlet NSButton *shareButton;
//Set BGM playback volume
@property (strong) IBOutlet NSSlider *BGMVolumeSlider;
//Set BGM remote playback volume
@property (strong) IBOutlet NSSlider *BGMPublishVolumeSlider;
//Device BGM local playback volume
@property (strong) IBOutlet NSSlider *BGMPlayoutVolumeSlider;

// For Cocoa Bindings
// Push settings
@property (assign, nonatomic) BOOL pushDoubleStream;
@property (assign, nonatomic) BOOL playSmallStream;
@property (assign, nonatomic) BOOL showVolume;
// Enable cloud mixing
@property (assign, nonatomic) TRTCTranscodingConfigMode mixMode;
@property (assign, nonatomic) BOOL isAudience;

- (instancetype)initWithWindowNibName:(NSNibName)windowNibName engine:(TRTCCloud *)engine;

- (IBAction)onSelectScene:(NSButton *)sender;

- (IBAction)onRoleBtnClicked:(NSButton *)sender;

- (IBAction)onSelectResolutionMode:(NSButton *)sender;

- (IBAction)onSelectCamera:(id)sender;

- (IBAction)onSelectSpeaker:(id)sender;

- (IBAction)onSelectMic:(id)sender;
//Change speaker volume
- (IBAction)onSpeakerVolumChange:(id)sender;
//Change microphone volume
- (IBAction)onMicVolumChange:(id)sender;
// Resolution selection
- (IBAction)onSelectResolution:(id)sender;
// Frame rate selection
- (IBAction)onSelectFps:(NSPopUpButton *)sender;
//bitrate selection
- (IBAction)onSelectBitrate:(id)sender;
// Microphone test
- (IBAction)onClickMicTest:(id)sender;
// Start speaker test
- (IBAction)onClickSpeakerTest:(NSButton *)sender;
//Change the flow control mode, smooth or clear
- (IBAction)onClickQOSPreference:(NSButton *)sender;
// Change the flow control method, use SDK fixed configuration or use distributed configuration
- (IBAction)onClickQOSControlMode:(NSButton *)sender;
//Response to share play address button
- (IBAction)onClickShowCloudMixURL:(id)sender;
@end

NS_ASSUME_NONNULL_END
