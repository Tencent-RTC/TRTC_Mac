/*
 * Module: TRTCMainWindowController
 *
 * Function: Use TRTC SDK to complete 1v1 and 1vn video call functions
 *
 * 1. Supports two different video screen layout methods: nine-square tiles and front-to-back overlay. This part uses the _layoutInBounds method to calculate the position, arrangement and size of each video screen.
 *
 * 2. Supports adjusting the resolution, frame rate and smooth mode of video calls. This part is implemented by TRTCSettingViewController
 *
 * 3. To create or join a call room, you need to specify roomid and userid first. This part is implemented by TRTCNewWindowController
 */

#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>
#import "SDKHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface TRTCMainWindowController : NSWindowController

/// Screen recording preview window
@property (strong) IBOutlet NSWindow *screenShareWindow;

/// Inter-room call window
@property (strong) IBOutlet NSWindow *connectRoomWindow;
@property (strong) NSString *connectRoomId;
@property (strong) NSString *connectUserId;
@property (assign, nonatomic, readonly) BOOL canConnectRoom;
@property (assign, nonatomic) BOOL connectingRoom;

/// Audio device selection list
@property (strong) IBOutlet NSTableView *audioSelectView;

/// Video equipment selection list
@property (strong) IBOutlet NSTableView *videoSelectView;

/// beauty window
@property (strong) IBOutlet NSPanel *beautyPanel;

///Whether to turn on beauty treatment (dermabrasion)
@property BOOL beautyEnabled;

// The following are beauty parameters
@property NSInteger beautyLevel;
@property NSInteger rednessLevel;
@property NSInteger whitenessLevel;
@property TRTCBeautyStyle beautyStyle;

@property (copy, nonatomic) void(^onVideoSettingsButton)(void);
@property (copy, nonatomic) void(^onAudioSettingsButton)(void);

- (instancetype)initWithEngine:(TRTCCloud *)engine params:(TRTCParams *)params scene:(TRTCAppScene)scene audioOnly:(BOOL)audioOnly;

@end

NS_ASSUME_NONNULL_END
