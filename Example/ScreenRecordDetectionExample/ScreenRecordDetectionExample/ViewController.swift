//
//  ViewController.swift
//  ScreenRecordDetectionExample
//
//  Created by Abdelalalim Ouni on 16/07/2020.
//  Copyright © 2020 Abdelalalim Ouni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onDidStartRecording), name: .didStartRecording, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidStopRecording), name: .didStopRecording, object: nil)
    }
    @objc
    func onDidStartRecording() {
        self.view.backgroundColor = UIColor.red
    }
    @objc
    func onDidStopRecording() {
        self.view.backgroundColor = UIColor.green
    }
}

