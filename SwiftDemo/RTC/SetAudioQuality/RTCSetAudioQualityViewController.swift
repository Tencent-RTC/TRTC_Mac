//
//  RTCSetAudioQualityViewController.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/7/26.
//  Copyright © 2022 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa

/*
 Setting Audio Quality
  TRTC Audio Quality Setting
  1. Set audio quality: trtcCloud.startLocalAudio(.music)
  2. Set the key code of TRTC : setupTRTCCloud()
  This document shows how to integrate the audio quality setting feature.
  Documentation: https://cloud.tencent.com/document/product/647/32258
 */

struct TRTCAudioConfig {
    var tonequalityName = "默认音质"
    var tonequalityDesc = "默认音质：采样率：48k - 单声道 - 编码码率：50kbps"
    var tonequality = TRTCAudioQuality.default
}

class RTCSetAudioQualityViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet weak var tonequalityListView: NSScrollView!
    @IBOutlet weak var tonequalityButton: NSButton!
    @IBOutlet weak var localVideoView: NSView!

    var remoteScreenController: NSWindowController?
    var roomId: UInt32 = 20200811
    var userId: String = "21917055"
    private lazy var remoteUids = NSMutableOrderedSet.init(capacity: MAX_REMOTE_USER_NUM)
    
    private lazy var trtcCloud: TRTCCloud = {
        let instance: TRTCCloud = TRTCCloud.sharedInstance()
        instance.delegate = self
        return instance
    }()
    
    private lazy var audioConfigs: [TRTCAudioConfig] = {
        return [
            TRTCAudioConfig(tonequalityName: "人声模式", tonequalityDesc: "人声模式：采样率：16k - 单声道 - 编码码率：16kbps", tonequality: TRTCAudioQuality.speech),
            TRTCAudioConfig(tonequalityName: "默认音质", tonequalityDesc: "默认音质：采样率：48k - 单声道 - 编码码率：50kbps", tonequality: TRTCAudioQuality.default),
            TRTCAudioConfig(tonequalityName: "音乐模式", tonequalityDesc: "音乐模式：采样率：48k - 全频带立体声 - 编码码率：128kbps", tonequality: TRTCAudioQuality.music)
        ]
    }()
    private var audioEncParam = TRTCAudioConfig.init()
    
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
        
        trtcCloud.startLocalAudio(.music)
        trtcCloud.startLocalPreview(localVideoView)
    }
    
    func windowWillClose(_ notification: Notification) {
        trtcCloud.exitRoom()
        remoteScreenController?.close()
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
    
    @IBAction func onTonequalityClicked(_ sender: NSButton) {
        if tonequalityListView.isHidden {
            guard let tableView = tonequalityListView.contentView.documentView as? NSTableView else { return }
            tableView.reloadData()
        }
        tonequalityListView.isHidden = !tonequalityListView.isHidden
    }

    @IBAction func onDashboardClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.showDebugView(Dashboard.fullVersion.rawValue)
        } else {
            trtcCloud.showDebugView(Dashboard.donotShow.rawValue)
        }
    }
}

extension RTCSetAudioQualityViewController: NSTableViewDelegate, NSTableViewDataSource {
        
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        trtcCloud.stopLocalAudio()
        tonequalityButton.title = audioConfigs[row].tonequalityName
        tonequalityListView.isHidden = true
        audioEncParam.tonequality = audioConfigs[row].tonequality
        trtcCloud.startLocalAudio(audioConfigs[row].tonequality)
        return false
    }
        
    func numberOfRows(in tableView: NSTableView) -> Int {
        return audioConfigs.count
    }
        
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TonequalityCellId"), owner: nil) as? NSTableCellView
        if row < audioConfigs.count {
            cellView?.textField?.stringValue = audioConfigs[row].tonequalityDesc
            if audioConfigs[row].tonequality == audioEncParam.tonequality {
                cellView?.textField?.textColor = NSColor.init(red: 0, green: 166/255.0, blue: 107/255.0, alpha: 1)
            } else {
                cellView?.textField?.textColor = NSColor.white
            }
        }
        return cellView
    }
}

extension RTCSetAudioQualityViewController: TRTCCloudDelegate {
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
