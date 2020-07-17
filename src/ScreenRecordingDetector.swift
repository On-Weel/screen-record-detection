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


protocol ScreenRecordingDetectorDelegate: class {
    func didStartRecording() -> Void
    func didStopRecording() -> Void
    func recordingStatusCahnged() -> Void
}
class ScreenRecordingDetector : NSObject{
    static let shared = ScreenRecordingDetector()
    var shouldSendNotification = false
    weak var delegate: ScreenRecordingDetectorDelegate?
    override init() {
        super.init()
        setupObserver()
    }
    private func setupObserver () -> Void{
        UIScreen.main.addObserver(self, forKeyPath: "captured", options: [.new, .old], context:nil)
    }
    
    func checkStatus() -> Void {
        if UIScreen.main.isCaptured {
            if shouldSendNotification {
                NotificationCenter.default.post(name: .didStartRecording, object: nil)
            }
            if let delegation = delegate {
                delegation.didStartRecording()
            }
        } else {
            if shouldSendNotification {
                NotificationCenter.default.post(name: .didStopRecording, object: nil)
            }
            if let delegation = delegate {
                delegation.didStopRecording()
            }
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "captured" {
            if shouldSendNotification {
                NotificationCenter.default.post(name: .didStartRecording, object: nil)
            }
            if let delegation = delegate {
                delegation.recordingStatusCahnged()
            }
            
            //            let old = change![NSKeyValueChangeKey.oldKey] as! Int
            let new = change![NSKeyValueChangeKey.newKey] as! Int
            if new == 1{
                if shouldSendNotification {
                    NotificationCenter.default.post(name: .didStartRecording, object: nil)
                }
                if let delegation = delegate {
                    delegation.didStartRecording()
                }
                
            } else {
                if shouldSendNotification {
                    NotificationCenter.default.post(name: .didStopRecording, object: nil)
                }
                if let delegation = delegate {
                    delegation.didStopRecording()
                }
                
            }
        }
    }
    
}
