//
//  RTCSetAudioEffectViewController.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/7/26.
//  Copyright © 2022 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa

/*
 设置音效功能示例
 TRTC APP 支持设置音效功能
 本文件展示如何集成设置音效功能
 1、进入TRTC房间  API: trtcCloud.enterRoom(param, appScene: .LIVE)
 2、选择变声  API: trtcCloud.sharedInstance().getAudioEffectManager().setVoiceChangerType(voicechange)
 3、选择混响  API: trtcCloud.sharedInstance().getAudioEffectManager().setVoiceReverbType(reverb)
 参考文档：https://cloud.tencent.com/document/product/647/32258
 */
/*
 Setting Audio Effects
 The TRTC app supports audio effect setting.
 This document shows how to integrate the audio effect setting feature.
 1. Enter a room: trtcCloud.enterRoom(param, appScene: .LIVE)
 2. Select a voice change effect: trtcCloud.sharedInstance().getAudioEffectManager().setVoiceChangerType(voicechange)
 3. Select a reverb effect: trtcCloud.sharedInstance().getAudioEffectManager().setVoiceReverbType(reverb)
 Documentation: https://cloud.tencent.com/document/product/647/32258
 */

struct TRTCVoicechangeConfig {
    var soundName = "原声"
    var soundDesc = "原声（变声效果）"
    var sound = TXVoiceChangeType._0
}

struct TRTCReverbConfig {
    var soundName = "无效果"
    var soundDesc = "无效果（混响效果）"
    var sound = TXVoiceReverbType._0
}

class RTCSetAudioEffectViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet weak var reverbsoundButton: NSButton!
    @IBOutlet weak var reverbsoundListView: NSScrollView!
    @IBOutlet weak var voicechangesoundListView: NSScrollView!
    @IBOutlet weak var voicechangesoundButton: NSButton!
    @IBOutlet weak var localVideoView: NSView!

    var roomId: UInt32 = 20200811
    var userId: String = "21917055"
    
    private lazy var voicechangeConfigs: [TRTCVoicechangeConfig] = {
        return [
            TRTCVoicechangeConfig(soundName: "原声", soundDesc: "原声（变声效果）", sound: ._0),
            TRTCVoicechangeConfig(soundName: "熊孩子", soundDesc: "熊孩子（变声效果）", sound: ._1),
            TRTCVoicechangeConfig(soundName: "萝莉", soundDesc: "萝莉（变声效果）", sound: ._2),
            TRTCVoicechangeConfig(soundName: "大叔", soundDesc: "大叔（变声效果）", sound: ._3),
            TRTCVoicechangeConfig(soundName: "重金属", soundDesc: "重金属（变声效果）", sound: ._4)
        ]
    }()

    private lazy var reverbConfigs: [TRTCReverbConfig] = {
        return [
            TRTCReverbConfig(soundName: "无效果", soundDesc: "无效果（混响效果）", sound: ._0),
            TRTCReverbConfig(soundName: "KTV", soundDesc: "KTV（混响效果）", sound: ._1),
            TRTCReverbConfig(soundName: "小房间", soundDesc: "小房间（混响效果）", sound: ._2),
            TRTCReverbConfig(soundName: "大会堂", soundDesc: "大会堂（混响效果）", sound: ._3),
            TRTCReverbConfig(soundName: "低沉", soundDesc: "低沉（混响效果）", sound: ._4)
        ]
    }()
    
    private var voicechange = TXVoiceChangeType._0
    private var reverb = TXVoiceReverbType._0
    private var chooseType = true
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
        videoEncParam.videoResolution = TRTCVideoResolution._960_540
        videoEncParam.videoBitrate = 1200
        videoEncParam.videoFps = 15
        trtcCloud.setVideoEncoderParam(videoEncParam)
        
        let beautyManager = trtcCloud.getBeautyManager()
        beautyManager.setBeautyStyle(.smooth)
        beautyManager.setBeautyLevel(5)
        beautyManager.setWhitenessLevel(1)
        trtcCloud.getAudioEffectManager().setVoiceChangerType(voicechange)
        trtcCloud.getAudioEffectManager().setVoiceReverbType(reverb)
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
    
    @IBAction func onVoicechangesoundClicked(_ sender: NSButton) {
        if voicechangesoundListView.isHidden {
            chooseType = true
            guard let tableView = voicechangesoundListView.contentView.documentView as? NSTableView else { return }
            tableView.reloadData()
        }
        voicechangesoundListView.isHidden = !voicechangesoundListView.isHidden
    }

    @IBAction func onReverbsoundClicked(_ sender: NSButton) {
        if reverbsoundListView.isHidden {
            chooseType = false
            guard let tableView = reverbsoundListView.contentView.documentView as? NSTableView else { return }
            tableView.reloadData()
        }
        reverbsoundListView.isHidden = !reverbsoundListView.isHidden
    }
    
    @IBAction func onDashboardClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.showDebugView(Dashboard.fullVersion.rawValue)
        } else {
            trtcCloud.showDebugView(Dashboard.donotShow.rawValue)
        }
    }
}

extension RTCSetAudioEffectViewController: NSTableViewDelegate, NSTableViewDataSource {
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if(chooseType) {
            voicechangesoundButton.title = voicechangeConfigs[row].soundName
            voicechangesoundListView.isHidden = true
            voicechange = voicechangeConfigs[row].sound
            TRTCCloud.sharedInstance().getAudioEffectManager().setVoiceChangerType(voicechange)
        } else {
            reverbsoundButton.title = reverbConfigs[row].soundName
            reverbsoundListView.isHidden = true
            reverb = reverbConfigs[row].sound
            TRTCCloud.sharedInstance().getAudioEffectManager().setVoiceReverbType(reverb)
        }
        return false
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        if (chooseType) {
            return voicechangeConfigs.count
        } else {
            return reverbConfigs.count
        }
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("soundCellId"), owner: nil) as? NSTableCellView
        if(chooseType){
            if row < voicechangeConfigs.count {
                cellView?.textField?.stringValue = voicechangeConfigs[row].soundDesc
                if voicechangeConfigs[row].sound == voicechange {
                    cellView?.textField?.textColor = NSColor.init(red: 0, green: 166/255.0, blue: 107/255.0, alpha: 1)
                } else {
                    cellView?.textField?.textColor = NSColor.white
                }
            }
        }else{
            if row < reverbConfigs.count {
                cellView?.textField?.stringValue = reverbConfigs[row].soundDesc
                if reverbConfigs[row].sound == reverb {
                    cellView?.textField?.textColor = NSColor.init(red: 0, green: 166/255.0, blue: 107/255.0, alpha: 1)
                } else {
                    cellView?.textField?.textColor = NSColor.white
                }
            }
        }
        return cellView
    }
}

extension RTCSetAudioEffectViewController: TRTCCloudDelegate {
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
