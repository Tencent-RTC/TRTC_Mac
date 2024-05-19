/*
 * Module: TRTCNewWindowController
 *
 * Function: This interface allows the user to enter a [room number] and a [user name]
 *
 * Notice:
 *
 * (1) The room number is of numeric type, and the user name is of string type.
 *
 * (2) In real usage scenarios, most room numbers are not manually entered by the user, but assigned by the system.
 * For example, the conference number in the video conference is pre-booked by the conference control system, and the room number in the customer service system is also determined based on the customer service employee's work number.
 */

#import "TRTCNewWindowController.h"
#import "SDKHeader.h"
#import "GenerateTestUserSig.h"
#import "TRTCSettingWindowController.h"

@interface TRTCNewWindowController()
{
    NSArray *_users;
    TRTCAppScene _scene;
}
@end

@implementation TRTCNewWindowController

- (void)windowDidLoad {
    [super windowDidLoad];

    NSMutableString *alertMessage = [[NSMutableString alloc] init];
    if (_SDKAppID == 0) {
        [alertMessage appendString:@"请在 GenerateTestUserSig.h 中填写 _SDKAppID。"];
    }
    if (_SDKSECRETKEY.length == 0) {
        [alertMessage appendString:@"请在 GenerateTestUserSig.h 中填写 _SDKSECRETKEY。"];
    }
    if (alertMessage.length > 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = alertMessage;
        [alert runModal];
    }

    [TRTCCloud setLogCompressEnabled:NO];
    [TRTCCloud setConsoleEnabled:YES];
}

- (void)alert:(NSString *)message {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:message];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert runModal];
}

- (IBAction)onSelectRoomScene:(NSButton *)sender {
    if (sender.tag == 0) {
        _scene = TRTCAppSceneLIVE;
    } else {
        _scene = TRTCAppSceneVideoCall;
    }
}

- (void)controlTextDidChange:(NSNotification *)notification {
    if (notification.object == self.roomidField) {
        NSInteger roomID = self.roomidField.integerValue;
        if (roomID > 0) {
            self.roomidField.stringValue = @(self.roomidField.integerValue).stringValue;
        } else {
            self.roomidField.stringValue = @"";
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.roomidField.stringValue
                                                  forKey:@"login_roomID"];
    }
}

/**
 * Function: Read user input and create (or join) audio and video rooms
 *
 * The main function of this sample code is to assemble the TRTCParams required by TRTC SDK to enter the room.
 *
 * TRTCParams.sdkAppId => Can be obtained from Tencent Cloud real-time audio and video console (https://console.cloud.tencent.com/rav)
 * TRTCParams.userId => This is the username entered by the user, which is a string
 * TRTCParams.roomId => This is the audio and video room number entered by the user, such as 125
 * TRTCParams.userSig => The sample code here shows two ways to obtain usersig, one is to obtain it from [Console] and the other is to obtain it from [Server]
 *
 * (1) Console acquisition: You can obtain several groups of generated userids and usersig. They will be placed in a json format configuration file, which is only suitable for debugging.
 * (2) Server acquisition: Use the source code we provide directly on the server side to calculate usersig in real time based on userid. This method is safe and reliable and suitable for online use.
 *
 * Reference document: https://cloud.tencent.com/document/product/647/17275
 */
- (IBAction)enter:(id)sender {
    if (self.roomidField.stringValue.length == 0) {
        [self alert: @"请输入正确的房间号"];
        return;
    }
    NSInteger roomID = self.roomidField.integerValue;
    if (roomID < 0) {
        [self alert: @"房间号必须是正整数"];
        return;
    }

    if (self.useridField.stringValue.length == 0) {
        [self alert: @"请输入正确的房间号和用户名"];
        return;
    }
    [self loginWithAppID:_SDKAppID roomID:self.roomidField.stringValue userID:self.useridField.stringValue];
}

- (void)enterRoomWithParam:(TRTCParams *)params {
    if (self.onLogin) {
        self.onLogin(params);
    }
}

- (void)loginWithAppID:(UInt32)sdkAppID roomID:(NSString *)roomID userID:(NSString *)userID {
    TRTCParams *param = [[TRTCParams alloc] init];
    param.sdkAppId = sdkAppID;
    param.userId = userID;
    param.userSig = [GenerateTestUserSig genTestUserSig:userID];
    param.roomId = (UInt32)roomID.integerValue;
    param.role = TRTCSettingWindowController.isAudience ? TRTCRoleAudience : TRTCRoleAnchor;
    [self enterRoomWithParam:param];
}

@end
