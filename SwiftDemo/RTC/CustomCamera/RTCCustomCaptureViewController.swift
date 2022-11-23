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
 自定义视屏采集和渲染示例
 TRTC APP 支持自定义视频数据采集, 本文件展示如何发送自定义采集数据
 1、进入TRTC房间     API:trtcCloud.enterRoom(params, appScene: .LIVE)
 2、打开自定义采集功能 API:trtcCloud.enableCustomVideoCapture(.big, enable: true)
 3、发送自定义采集数据 API:trtcCloud.enableCustomVideoCapture(.big, enable: true)
 更多细节，详见：https://cloud.tencent.com/document/product/647/34066
 */
/*
 Custom Video Capturing and Rendering
 The TRTC app supports custom video capturing and rendering. This document shows how to send custom video data.
 1. Enter a room: trtcCloud.enterRoom(params, appScene: .LIVE)
 2. Enable custom video capturing: trtcCloud.enableCustomVideoCapture(.big, enable: true)
 3. Send custom video data: trtcCloud.enableCustomVideoCapture(.big, enable: true)
 For more information, please see https://cloud.tencent.com/document/product/647/34066
 */

class RTCCustomCaptureViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet weak var localVideoView: NSImageView!
    
    var roomId: UInt32 = 20200811
    var userId: String = "21917055"
    let cameraHelper = RTCCustomCameraHelper.init()
    let customFrameRender = RTCCustomCameraFrameRender()
    var remoteScreenController: NSWindowController?
    private lazy var remoteUids = NSMutableOrderedSet.init(capacity: MAX_REMOTE_USER_NUM)
    
    private lazy var trtcCloud: TRTCCloud = {
        let instance: TRTCCloud = TRTCCloud.sharedInstance()
        instance.delegate = self
        return instance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraHelper.delegate = self
        cameraHelper.createSession()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        guard let window = view.window else { return }
        window.title = "视频通话--房间\(roomId)"
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        cameraHelper.startCameraCapture()
        customFrameRender.start(userId: "", videoView: localVideoView)
    }
    
    func windowWillClose(_ notification: Notification) {
        trtcCloud.exitRoom()
    }
    
    deinit {
        TRTCCloud.destroySharedIntance()
    }
    
    @IBAction func onCustomPushClicked(_ sender: NSButton) {
        let param = TRTCParams.init()
        param.sdkAppId = UInt32(SDKAPPID)
        param.roomId   = roomId
        param.userId   = userId
        param.role     = TRTCRoleType.anchor
        param.userSig  = GenerateTestUserSig.genTestUserSig(identifier: param.userId)
        trtcCloud.enterRoom(param, appScene: .videoCall)
        trtcCloud.delegate = self

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
        trtcCloud.enableCustomVideoCapture(.big, enable: true)
        trtcCloud.setLocalVideoRenderDelegate(self, pixelFormat: ._NV12, bufferType: .pixelBuffer)
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

extension RTCCustomCaptureViewController: TRTCVideoRenderDelegate {
    func onRenderVideoFrame(_ frame: TRTCVideoFrame, userId: String?, streamType: TRTCVideoStreamType) {
        customFrameRender.onRenderVideoFrame(frame: frame, userId: userId ?? "", streamType: streamType)
    }
}

extension RTCCustomCaptureViewController : CustomCameraHelperSampleBufferDelegate {
    func onVideoSampleBuffer(videoBuffer: CMSampleBuffer) {
        let videoFrame = TRTCVideoFrame()
        videoFrame.bufferType = .pixelBuffer
        videoFrame.pixelFormat = ._NV12
        videoFrame.pixelBuffer = CMSampleBufferGetImageBuffer(videoBuffer)
        trtcCloud.sendCustomVideoData(.big, frame: videoFrame)
    }
}

extension RTCCustomCaptureViewController: TRTCCloudDelegate {
    func onUserVideoAvailable(_ userId: String, available: Bool) {
        let index = remoteUids.index(of: userId)
        if available {
            guard NSNotFound == index else { return }
            remoteUids.add(userId)
            refreshRemoteVideoViews(from: remoteUids.count - 1)
        } else {
            guard NSNotFound != index else { return }
            trtcCloud.stopRemoteView(userId, streamType: .big)
            remoteUids.removeObject(at: index)
            refreshRemoteVideoViews(from: index)
        }
    }
    
    func refreshRemoteVideoViews(from: Int) {
        for i in from..<remoteVideoView.subviews.count {
            if i < remoteUids.count {
                let remoteUid = remoteUids[i] as! String
                remoteVideoView.subviews[i].isHidden = false
                trtcCloud.startRemoteView(remoteUid, streamType: .big, view: remoteVideoView.subviews[i])
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
                trtcCloud.startRemoteSubStreamView(userId,view: vc.view)
                remoteScreenController?.showWindow(nil)
            }
        } else {
            trtcCloud.stopRemoteSubStreamView(userId)
            remoteScreenController?.close()
        }
    }
}
