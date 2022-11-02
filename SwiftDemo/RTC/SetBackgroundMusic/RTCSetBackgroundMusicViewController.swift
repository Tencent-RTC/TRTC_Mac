//
//  RTCSetBackgroundMusicViewController.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/7/27.
//  Copyright © 2022 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa

/*
 设置背景音乐功能示例
 TRTC APP 支持设置背景音乐功能
 本文件展示如何集成设置背景音乐功能
 1、进入TRTC房间 API: trtcCloud.enterRoom(params, appScene: .LIVE)
 2、播放背景音乐 API:
 trtcCloud.getAudioEffectManager().startPlayMusic(bgmParam) { errCode in } onProgress: { progressMs, durationMs in } onComplete: { errCode in }
 3、设置TRTC的关键代码 API: startPushStream()
 API:trtcCloud.getAudioEffectManager().startPlayMusic(bgmParam) { errCode in } onProgress: { progressMs, durationMs in } onComplete: { errCode in }
 参考文档：https://cloud.tencent.com/document/product/647/32258
 */
/*
 Setting Background Music
 The TRTC app supports background music setting.
 This document shows how to integrate the background music setting feature.
 1. Enter a room: trtcCloud.enterRoom(param, appScene: .LIVE)
 2. Play background music:
 trtcCloud.getAudioEffectManager().startPlayMusic(bgmParam) { errCode in } onProgress: { progressMs, durationMs in } onComplete: { errCode in }
 3. Set the key code of TRTC : viewWillAppear()
 Documentation: https://cloud.tencent.com/document/product/647/32258
 */

struct TRTCAudioBackgroundMusicConfig {
    var backgroundMusicName = "背景音乐1"
    var backgroundMusicDesc = "高清：540*960"
    var path = "PositiveHappyAdvertising.mp3"
}

class RTCSetBackgroundMusicViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet weak var backgroundButton: NSButton!
    @IBOutlet weak var backgroundListView: NSScrollView!
    @IBOutlet weak var localVideoView: NSView!

    let bgmParam = TXAudioMusicParam()
    var roomId: UInt32 = 20200811
    var userId: String = "21917055"

    private lazy var audioBGMConfigs: [TRTCAudioBackgroundMusicConfig] = {
        return [
            TRTCAudioBackgroundMusicConfig(backgroundMusicName: "默认音乐1",
                                           backgroundMusicDesc: "背景音乐1-PositiveHappyAdvertising",
                                           path: "PositiveHappyAdvertising.mp3"),
            TRTCAudioBackgroundMusicConfig(backgroundMusicName: "默认音乐2",
                                           backgroundMusicDesc: "背景音乐2-SadCinematicPiano",
                                           path: "SadCinematicPiano.mp3"),
            TRTCAudioBackgroundMusicConfig(backgroundMusicName: "默认音乐3",
                                           backgroundMusicDesc: "背景音乐3-WonderWorld",
                                           path: "WonderWorld.mp3")
        ]
    }()
    
    private var path = ""
    private var pathEnd = ""
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
        trtcCloud.enterRoom(param, appScene: .LIVE)

        let videoEncParam = TRTCVideoEncParam.init()
        videoEncParam.videoResolution = ._960_540
        videoEncParam.videoBitrate = 1200
        videoEncParam.videoFps = 15
        trtcCloud.setVideoEncoderParam(videoEncParam)

        let beautyManager = trtcCloud.getBeautyManager()
        beautyManager.setBeautyStyle(.smooth)
        beautyManager.setBeautyLevel(5)
        beautyManager.setWhitenessLevel(1)
        path = "https://sdk-liteav-1252463788.cos.ap-hongkong.myqcloud.com/app/res/bgm/trtc/PositiveHappyAdvertising.mp3"
        pathEnd = "PositiveHappyAdvertising.mp3"
        bgmParam.path = path
        trtcCloud.getAudioEffectManager().startPlayMusic(bgmParam) { errCode in
            
        } onProgress: { progressMs, durationMs in
            
        } onComplete: { errCode in
            
        }
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
    
    @IBAction func onBackgroundClicked(_ sender: NSButton) {
        if backgroundListView.isHidden {
            guard let tableView = backgroundListView.contentView.documentView as? NSTableView else { return }
            tableView.reloadData()
        }
        backgroundListView.isHidden = !backgroundListView.isHidden
    }
    
    @IBAction func onDashboardClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.showDebugView(Dashboard.fullVersion.rawValue)
        } else {
            trtcCloud.showDebugView(Dashboard.donotShow.rawValue)
        }
    }
}

extension RTCSetBackgroundMusicViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        backgroundButton.title = audioBGMConfigs[row].backgroundMusicName
        backgroundListView.isHidden = true
        path = "https://sdk-liteav-1252463788.cos.ap-hongkong.myqcloud.com/app/res/bgm/trtc/" + audioBGMConfigs[row].path
        pathEnd = audioBGMConfigs[row].path
        bgmParam.path = path
        trtcCloud.getAudioEffectManager().startPlayMusic(bgmParam) { errCode in
            
        } onProgress: { progressMs, durationMs in
            
        } onComplete: { errCode in
            
        }
        return false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return audioBGMConfigs.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("BackgroundMusicCellId"), owner: nil) as? NSTableCellView
        if row < audioBGMConfigs.count {
            cellView?.textField?.stringValue = audioBGMConfigs[row].backgroundMusicDesc
            if audioBGMConfigs[row].path == pathEnd {
                cellView?.textField?.textColor = NSColor.init(red: 0, green: 166/255.0, blue: 107/255.0, alpha: 1)
            } else {
                cellView?.textField?.textColor = NSColor.white
            }
        }
        return cellView
    }
}

extension RTCSetBackgroundMusicViewController: TRTCCloudDelegate {
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

