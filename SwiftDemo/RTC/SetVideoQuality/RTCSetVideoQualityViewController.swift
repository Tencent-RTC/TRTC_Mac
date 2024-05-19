//
//  SetVideoQualityViewController.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/7/22.
//  Copyright © 2022 tencent. All rights reserved.
//

import TXLiteAVSDK_TRTC_Mac
import Cocoa


/*
 Setting Video Quality
  TRTC Video Quality Setting
  This document shows how to integrate the video quality setting feature.
  1. Set resolution: videoEncParam.videoResolution = videoConfigs[row].resolution;
  2. Set bitrate: videoEncParam.videoBitrate = videoConfigs[row].bitrate;
  3. Set frame rate: trtcCloud.setVideoEncoderParam(videoEncParam);
  Documentation: https://cloud.tencent.com/document/product/647/32236
 */

struct TRTCVideoConfig {
    var bitrate: Int32 = 850
    var resolutionName = "540P"
    var resolutionDesc = "540*960"
    var resolution = TRTCVideoResolution._960_540
}

class RTCSetVideoQualityViewController: NSViewController {
    
    @IBOutlet weak var remoteVideoView: NSView!
    @IBOutlet weak var localVideoView: NSView!
    @IBOutlet weak var resolutionButton: NSButton!
    @IBOutlet weak var resolutionListView: NSScrollView!
    
    var roomId: UInt32 = 20200811
    var userId: String = "21917055"
    
    private lazy var videoConfigs: [TRTCVideoConfig] = {
        return [
            TRTCVideoConfig(bitrate: 900, resolutionName: "360P ", resolutionDesc: "360*640", resolution: TRTCVideoResolution._640_360),
            TRTCVideoConfig(bitrate: 1200, resolutionName: "540P ", resolutionDesc: "540*960", resolution: TRTCVideoResolution._960_540),
            TRTCVideoConfig(bitrate: 1500, resolutionName: "720P ", resolutionDesc: "720*1280", resolution: TRTCVideoResolution._1280_720)
        ]
    }()
    private let videoEncParam = TRTCVideoEncParam.init()
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
        trtcCloud.enterRoom(param, appScene: .LIVE)
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
    
    
    @IBAction func onResolutionClicked(_ sender: NSButton) {
        if resolutionListView.isHidden {
            guard let tableView = resolutionListView.contentView.documentView as? NSTableView else { return }
            tableView.reloadData()
        }
        resolutionListView.isHidden = !resolutionListView.isHidden
    }
    
    @IBAction func onDashboardClicked(_ sender: NSButton) {
        if sender.state == .on {
            trtcCloud.showDebugView(Dashboard.fullVersion.rawValue)
        } else {
            trtcCloud.showDebugView(Dashboard.donotShow.rawValue)
        }
    }
}

extension RTCSetVideoQualityViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        resolutionButton.title = videoConfigs[row].resolutionName
        resolutionListView.isHidden = true
        videoEncParam.videoResolution = videoConfigs[row].resolution
        videoEncParam.videoBitrate = videoConfigs[row].bitrate
        trtcCloud.setVideoEncoderParam(videoEncParam)
        return false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return videoConfigs.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("ResolutionCellId"), owner: nil) as? NSTableCellView
        if row < videoConfigs.count {
            cellView?.textField?.stringValue = videoConfigs[row].resolutionDesc
            if videoConfigs[row].resolution == videoEncParam.videoResolution {
                cellView?.textField?.textColor = NSColor.init(red: 0, green: 166/255.0, blue: 107/255.0, alpha: 1)
            } else {
                cellView?.textField?.textColor = NSColor.white
            }
        }
        return cellView
    }
}

extension RTCSetVideoQualityViewController: TRTCCloudDelegate {
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
