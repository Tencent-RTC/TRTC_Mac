/*
 * Module: TRTCNewWindowController
 *
 * Function: This interface allows the user to enter a [room number] and a [user name]
 *
 * Notice:
 *
 * (1) The room number is of numeric type, and the user name is of string type.
 *
 * (2) In real usage scenarios, most room numbers are not manually entered by users, but are directly assigned by the backend business server.
 * For example, the conference number in the video conference is pre-booked by the conference control system, and the room number in the customer service system is also determined based on the customer service employee's work number.
 */

#import <Cocoa/Cocoa.h>
#import "TRTCMainWindowController.h"
#import "SDKHeader.h"
// Log in
@interface TRTCNewWindowController : NSWindowController
{
    TRTCMainWindowController *_wc;
}
// Room number input box
@property (strong) IBOutlet NSTextField *roomidField;
@property (strong) IBOutlet NSTextField *useridField;
@property BOOL audioOnly;
- (IBAction)onSelectRoomScene:(id)sender;
@property (copy, nonatomic) void(^onLogin)(TRTCParams *param);
@end

