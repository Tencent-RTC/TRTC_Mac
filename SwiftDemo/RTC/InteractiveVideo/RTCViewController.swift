//
//  RTCViewController.swift
//  TRTCSimpleDemo
//
//  Copyright © 2020 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa

/*
 RTC视频通话的主页面
 包含如下简单功能：
 - 进入/退出视频通话房间
 - 打开/关闭摄像头
 - 打开/关闭麦克风
*/
/*
 The main page of an RTC video call
 Contains the following simple functions:
 - Enter/exit the video call room
 - Turn the camera on or off
 - Turn on/off the microphone
*/
let MAX_REMOTE_USER_NUM = 6
class RTCViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet var localVideoView: NSView!
    
    var roomId: UInt32 = 20200811
    var userId: String = "21917055"
    var remoteScreenController: NSWindowController?
    private lazy var remoteUids = NSMutableOrderedSet.init(capacity: MAX_REMOTE_USER_NUM)
    
    private lazy var trtcCloud: TRTCCloud = {
        let instance: TRTCCloud = TRTCCloud.sharedInstance()
        instance.delegate = self
        return instance
    }()
    
    override func viewWillAppear() {
        super.viewWillAppear()
        guard let window = view.window else { return }
        window.title = "视频通话--房间\(roomId)"
        
        let param = TRTCParams.init()
        param.sdkAppId = UInt32(SDKAppID)
        param.roomId   = roomId
        param.userId   = userId
        param.role     = TRTCRoleType.anchor
        param.userSig  = GenerateTestUserSig.genTestUserSig(identifier: param.userId)
        trtcCloud.enterRoom(param, appScene: .videoCall)
        
        let videoEncParam = TRTCVideoEncParam.init()
        videoEncParam.videoResolution = ._640_360
        videoEncParam.videoBitrate = 550
        videoEncParam.videoFps = 15
        trtcCloud.setVideoEncoderParam(videoEncParam)
        
        let beautyManager = trtcCloud.getBeautyManager()
        beautyManager.setBeautyStyle(.nature)
        beautyManager.setBeautyLevel(5)
        beautyManager.setWhitenessLevel(1)
        trtcCloud.startLocalAudio(.music)
        trtcCloud.startLocalPreview(localVideoView)
    }
    
    func windowWillClose(_ notification: Notification) {
        trtcCloud.exitRoom()
    }
    
    deinit {
        TRTCCloud.destroySharedIntance()
    }
    
    @IBAction func onExitRoomClicked(_ sender: NSButton) {
        view.window?.close()
    }
    
    @IBAction func onVideoCaptureClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.stopLocalPreview()
            sender.image = NSImage.init(named: "rtc_camera_off")
        } else {
            trtcCloud.startLocalPreview(localVideoView)
            sender.image = NSImage.init(named: "rtc_camera_on")
        }
    }
    
    @IBAction func onMicCaptureClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.stopLocalAudio()
            sender.image = NSImage.init(named: "rtc_mic_off")
        } else {
            trtcCloud.startLocalAudio(.music)
            sender.image = NSImage.init(named: "rtc_mic_on")
        }
    }
        
    @IBAction func onDashboardClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.showDebugView(Dashboard.fullVersion.rawValue)
        } else {
            trtcCloud.showDebugView(Dashboard.donotShow.rawValue)
        }
    }
}

extension RTCViewController: TRTCCloudDelegate {
    func onUserVideoAvailable(_ userId: String, available: Bool) {
        let index = remoteUids.index(of: userId)
        if available {
            guard NSNotFound == index else { return }
            remoteUids.add(userId)
            refreshRemoteVideoViews(from: remoteUids.count - 1)
        } else {
            guard NSNotFound != index else { return }
            trtcCloud.stopRemoteView(userId)
            remoteUids.removeObject(at: index)
            refreshRemoteVideoViews(from: index)
        }
    }
    
    func refreshRemoteVideoViews(from: Int) {
        for i in from..<remoteVideoView.subviews.count {
            if i < remoteUids.count {
                let remoteUid = remoteUids[i] as! String
                remoteVideoView.subviews[i].isHidden = false
                trtcCloud.startRemoteView(remoteUid, view: remoteVideoView.subviews[i])
            } else {
                remoteVideoView.subviews[i].isHidden = true
            }
        }
    }
    
    func onUserSubStreamAvailable(_ userId: String, available: Bool) {
        if available {
            if nil == remoteScreenController {
                let storyboard = NSStoryboard.init(name: "RTC", bundle: nil)
                remoteScreenController = storyboard.instantiateController(withIdentifier: "ShareScreenWindowControllerId") as? NSWindowController
            }
            if let vc = remoteScreenController?.contentViewController {
                trtcCloud.startRemoteSubStreamView(userId, view: vc.view)
                remoteScreenController?.showWindow(nil)
            }
        } else {
            trtcCloud.stopRemoteSubStreamView(userId)
            remoteScreenController?.close()
        }
    }
}
