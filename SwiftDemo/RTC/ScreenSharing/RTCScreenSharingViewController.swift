//
//  RTCViewController.swift
//  TRTCSimpleDemo
//
//  Copyright © 2020 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa

/*
 屏幕分享功能示例
 TRTC APP 支持设置屏幕分享功能
 本文件展示如何集成设置屏幕分享功能
 1、进入TRTC房间     API:trtcCloud.enterRoom(param, appScene: .videoCall)
 2、打开屏幕分享功能  API:onShareScreenClicked(_ sender: NSButton)
 */
/*
 Example of screen sharing
 TRTC APP supports setting screen sharing function
 This document shows how to integrate screen sharing
 1. Enter TRTC room : trtcCloud. EnterRoom (Param, appScene:.videocall)
 2. open the screen sharing : onShareScreenClicked (_ sender: NSButton)
*/

class RTCScreenSharingViewController: NSViewController {
    
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
    
    @IBAction func onShareScreenClicked(_ sender: NSButton) {
        if sender.state == .on {
            let captureSources = trtcCloud.getScreenCaptureSources(withThumbnailSize: CGSize(width: 10, height: 10),
                                                                            iconSize: CGSize(width: 10, height: 10))
            if let windowSource = captureSources.filter({ (sourceInfo) -> Bool in
                return  sourceInfo.type == .screen
            }).first {
                trtcCloud.selectScreenCaptureTarget(windowSource,
                                                    rect: CGRect.zero,
                                                    capturesCursor: true, highlight: true)
                trtcCloud.startScreenCapture(nil)
            }
        } else {
            trtcCloud.stopScreenCapture()
        }
    }
}

extension RTCScreenSharingViewController: TRTCCloudDelegate {
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
