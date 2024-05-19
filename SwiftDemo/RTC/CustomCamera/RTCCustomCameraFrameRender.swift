//
//  RTCCustomCameraFrameRender.swift
//  TRTCSimpleDemo
//
//  Created by xzyMacEnd on 2022/8/2.
//  Copyright © 2022 tencent. All rights reserved.
//

import Cocoa
import TXLiteAVSDK_TRTC_Mac

/*
Custom Video Capturing and Rendering
TRTC APP supports custom video data collection. This document shows how to customize the data collected by rendering.
1. Customized rendering of collected data: onRenderVideoFrame()
For more information, please see https://cloud.tencent.com/document/product/647/34066
*/

class RTCCustomCameraFrameRender: NSObject {

    var localVideoView: NSImageView
    let userVideoViews : NSMutableDictionary

    override init() {
        userVideoViews = NSMutableDictionary()
        localVideoView = NSImageView()
    }

    func start(userId : String?, videoView: NSImageView) {
        
        if let userID = userId {
            userVideoViews.setValue(videoView, forKey: userID)
        } else {
            localVideoView = videoView
        }
    }

    func onRenderVideoFrame(frame: TRTCVideoFrame, userId: String?, streamType: TRTCVideoStreamType) {
        let pixelBuffer = frame.pixelBuffer
        DispatchQueue.main.async {
            var videoView = NSImageView()
            if let userID = userId {
                _ = self.userVideoViews.object(forKey: userID)
                guard let videoImageView = self.userVideoViews.object(forKey: userID) as? NSImageView
                    else {
                        return
                }
                videoView = videoImageView
            } else {
                videoView = self.localVideoView
            }
            if let pixelBuffer = pixelBuffer {
                let width = CVPixelBufferGetWidth(pixelBuffer)
                let height = CVPixelBufferGetHeight(pixelBuffer)
                let ciImage = CIImage(cvImageBuffer: pixelBuffer)
                let context = CIContext(options: nil)
                let cgImage = context.createCGImage(ciImage, from: CGRect(x: 0, y: 0, width: width, height: height))
                guard let cgImageVideo = cgImage else {
                    return
                }
                videoView.image = NSImage.init(cgImage: cgImageVideo, size: CGSize(width: width, height: height))
            }
        }
    }
}

