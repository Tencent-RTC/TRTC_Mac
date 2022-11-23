//
//  RTCLocalRecordViewController.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/7/28.
//  Copyright © 2022 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa

/*
 本地媒体录制示例
 TRTC APP 支持本地媒体录制功能
 本文件展示如何集成本地媒体录制功能
 1、进入TRTC房间。 API:trtcCloud.enterRoom(params, appScene: .videoCall)
 2、开启本地录制。  API:trtcCloud.startLocalRecording(recordParams)
 3、结束本地录制。  API:trtcCloud.stopLocalRecording()
 4、设置TRTC的关键代码。  API：viewWillAppear()
 参考文档：https://cloud.tencent.com/document/product/647/32258
 */
/*
 Local Recording
 The TRTC app supports local recording.
 This document shows how to integrate the local recording feature.
 1. Enter a room: trtcCloud.enterRoom(params, appScene: .videoCall)
 2. Start local recording: trtcCloud.startLocalRecording(recordParams)
 3. Stop local recording: trtcCloud.stopLocalRecording()
 4. Set the key code of TRTC : viewWillAppear()
 Documentation: https://cloud.tencent.com/document/product/647/32258
 */

class RTCLocalRecordViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet weak var localVideoView: NSView!
    @IBOutlet weak var recordAddressTextField: NSTextField!
    
    var roomId: UInt32 = 20200811
    var userId: String = "21917055"
    var isRecording: Bool = true
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
        param.sdkAppId = UInt32(SDKAPPID)
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
    
    @IBAction func onStartRecordClicked(_ sender: NSButton) {
        var filename = recordAddressTextField.stringValue
        if ((filename.hasSuffix(".mp4")) != nil){
            filename = (filename ?? "") + ".mp4"
        }
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let cachePath = (path.last ?? "") as String
        guard let fileURL = URL(string: cachePath) else { return }
        let filePath = fileURL.appendingPathComponent(filename)
        
        let recordParams = TRTCLocalRecordingParams()
        recordParams.interval = 1000
        recordParams.filePath = filePath.absoluteString
        recordParams.recordType = .both
        trtcCloud.startLocalRecording(recordParams)
        isRecording = true
    }
    
    @IBAction func onStopRecordClicked(_ sender: NSButton) {
        trtcCloud.stopLocalRecording()
        isRecording = false
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

extension RTCLocalRecordViewController: TRTCCloudDelegate {
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
