//
//  RTCEntranceViewController.swift
//  TRTCSimpleDemo
//
//  Copyright © 2020 tencent. All rights reserved.
//

import Cocoa

/*
  RTC视频通话的入口页面（可以设置房间id和用户id）
  RTC视频通话是基于房间来实现的，通话的双方要进入一个相同的房间id才能进行视频通话
*/
/*
 Room ID and user ID can be set on the RTC video call portal
 RTC video call is implemented based on room. Both parties must enter the same room ID to make a video call
*/

class RTCEntranceViewController: NSViewController {
    
    @IBOutlet weak var roomIdTextField: NSTextField!
    @IBOutlet weak var userIdTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        roomIdTextField.stringValue = String(arc4random())
        userIdTextField.stringValue = "\(UInt32(CACurrentMediaTime() * 1000))"
    }

    func roomIdRandom(roomIdRandom: String) -> String {
        var roomIdRandomInfo = roomIdRandom
        while (roomIdRandomInfo as NSString).integerValue <= 0 {
            let roomIdRandomInteger = (roomIdRandomInfo as NSString).integerValue
            if (roomIdRandomInfo as NSString).integerValue == 0 {
                roomIdRandomInfo = String(arc4random())
            } else {
                roomIdRandomInfo = String(-roomIdRandomInteger)
            }
        }
        return roomIdRandomInfo
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard segue.identifier == "enterRTCRoom" else {
            return
        }
        view.window?.makeFirstResponder(nil)
        guard let delegate = (NSApp.delegate as? AppDelegate) else { return }
        delegate.closeAllWindows()

        guard let nextWindowExistsController = segue.destinationController as? NSWindowController,
              let rtcNextViewController = nextWindowExistsController.contentViewController as? RTCViewController
        else {
            return
        }
 
        rtcNextViewController.userId = userIdTextField.stringValue
        rtcNextViewController.roomId = UInt32((roomIdRandom(roomIdRandom: roomIdTextField.stringValue) as NSString).integerValue)
    }
}
