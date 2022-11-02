//
//  MainViewController.swift
//  TRTCSimpleDemo
//
//  Copyright © 2020 tencent. All rights reserved.
//

import Cocoa

/*
 本文件列举了各功能模块，旨在通过button进行各功能模块点击转移
 */
/*
 This file lists each function module, aiming to transfer each function module by clicking the button
*/



class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TRTC示例教程"
    }
    

    @IBAction func onInteractiveClicked(_ sender: NSButton) {
        presentStoryboard("RTCInteractiveVideo")
    }
    
    @IBAction func onScreenShareClicked(_ sender: NSButton) {
        presentStoryboard("RTCScreenSharing")
    }
    
    @IBAction func onStringRoomIdClicked(_ sender: NSButton) {
        presentStoryboard("RTCStringRoomId")
    }
    
    @IBAction func onSetVideoQualityClicked(_ sender: NSButton) {
        presentStoryboard("RTCSetVideoQuality")
    }
    
    @IBAction func onSetAudioQualityClicked(_ sender: NSButton) {
        presentStoryboard("RTCSetAudioQuality")
    }
    
    @IBAction func onSetAudioEffectClicked(_ sender: NSButton) {
        presentStoryboard("RTCSetAudioEffect")
    }
    
    @IBAction func onSetBackgroundMusicClicked(_ sender: NSButton) {
        presentStoryboard("RTCSetBackgroundMusic")
    }
    
    @IBAction func onCustomCameraClicked(_ sender: NSButton) {
        presentStoryboard("RTCCustomCamera")
    }
    
    @IBAction func onLocalRecordClicked(_ sender: NSButton) {
        presentStoryboard("RTCLocalRecord")
    }
    
    func presentStoryboard(_ name: String) {
        (NSApp.delegate as? AppDelegate)?.closeAllWindows()
        
        let storyboard = NSStoryboard.init(name: name, bundle: nil)
        guard let vc = storyboard.instantiateInitialController() as? NSWindowController else { return }
        vc.showWindow(nil)
    }
    
}
