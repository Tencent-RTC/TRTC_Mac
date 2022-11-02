//
//  StringRoomId.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/7/22.
//  Copyright © 2022 tencent. All rights reserved.
//

import Cocoa

class RTCStringRoomIdController: NSViewController {
    
    @IBOutlet weak var roomIdTextField: NSTextField!
    @IBOutlet weak var userIdTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomIdTextField.stringValue = String(arc4random())
        userIdTextField.stringValue = "\(UInt32(CACurrentMediaTime() * 1000))"
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard segue.identifier == "enterRTCStringRoom" else {
            return
        }
        view.window?.makeFirstResponder(nil)
        guard let delegate = (NSApp.delegate as? AppDelegate) else { return }
        delegate.closeAllWindows()

        guard let nextWindowExistsController = segue.destinationController as? NSWindowController,
              let rtcNextViewController = nextWindowExistsController.contentViewController as? RTCStringRoomIdViewController
        else {
            return
        }

        rtcNextViewController.userId = userIdTextField.stringValue
        rtcNextViewController.roomId = roomIdTextField.stringValue
    }
}
