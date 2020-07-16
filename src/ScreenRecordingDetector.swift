//
//  ScreenRecordingDetector.swift
//  ScreenRecordDetectionExample
//
//  Created by Abdelalalim Ouni on 16/07/2020.
//  Copyright © 2020 Abdelalalim Ouni. All rights reserved.
//
import UIKit

extension Notification.Name {
    static let didStartRecording = Notification.Name("StartRecordingNotification")
    static let didStopRecording = Notification.Name("StopRecordingNotification")
    static let recordingStatusCahnged = Notification.Name("RecordingStatusCahngedNotification")
}
let startRecording: String = "StartRecordingNotification"
let stopRecording: String = "StopRecordingNotification"
let recordingStatusCahnged: String = "RecordingStatusCahngedNotification"


class ScreenRecordingDetector : NSObject{
    static let shared = ScreenRecordingDetector()
    var shouldSendNotification = false
    override init() {
        super.init()
        setupObserver()
    }
    private func setupObserver () -> Void{
        //        [UIScreen.mainScreen addObserver:self forKeyPath:@"captured" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        UIScreen.main.addObserver(self, forKeyPath: "captured", options: [.new, .old], context:nil)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "captured" {
            NotificationCenter.default.post(name: .didStartRecording, object: nil)
            let old = change![NSKeyValueChangeKey.oldKey] as! Int
            let new = change![NSKeyValueChangeKey.newKey] as! Int
            print(old)
            print(new)
            if new == 1{
                NotificationCenter.default.post(name: .didStartRecording, object: nil)
            } else {
                NotificationCenter.default.post(name: .didStopRecording, object: nil)
            }
        }
    }
    
}
