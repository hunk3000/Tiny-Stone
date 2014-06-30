//
//  FirstViewController.swift
//  SwiftLearning
//
//  Created by Hunk on 14-6-16.
//  Copyright (c) 2014 dianxinOS. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    var titleLabel:UILabel!
    var subtitleLabel:UILabel!
    var captureDevice:AVCaptureDevice!
    
    override func loadView() {
        super.loadView()
        
        var attStr:NSMutableAttributedString = NSMutableAttributedString(string: "Att String")
        attStr.addAttribute(NSForegroundColorAttributeName,
            value: UIColor.redColor(), range: NSMakeRange(0, 3))
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(33), range: NSMakeRange(0, 3))

        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(14.0)
        //titleLabel.text = "I am title"
        titleLabel.attributedText = attStr;
        self.view.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.text = "Subtitle contents"
        self.view.addSubview(subtitleLabel)
        
        HKUtility.playVibrate()
        
        initTorch()
        torchOn();
        let torchOffSel = Selector("torchOff")
        
    }
    
    override func viewWillLayoutSubviews()  {
        super.viewWillLayoutSubviews()
        
        titleLabel.frame = CGRectMake(100, 100, 100, 30)
        subtitleLabel.frame = CGRectMake(100, 130, 200, 30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        HKUtility.showMessageBox(HKUtility.dateline())
        
        var nn = [1,23,3,42,5,6]
        println(nn)
        sort(nn,<=)
        println(nn)
        
        var RSSI:Int = 80
        var distance = 0.0
        
        for RSSI in 40...100 {
            var temp:Double = Double(RSSI - 50) / 38
            distance = pow(10.0, temp);
            println("dbm = -\(RSSI) distance = \(distance)")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTorch() {
        if(captureDevice == .None) {
            captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        }
        
    }
    
    func torchOn() {
        
        var err:NSError?
        if captureDevice.hasTorch {
            let locked = captureDevice.lockForConfiguration(&err)
            if locked {
                captureDevice.torchMode = .On
                self.captureDevice.unlockForConfiguration()
            } else {
                HKUtility.showMessageBox("lock configuration error.")
            }
        } else {
            HKUtility.showMessageBox("Your device does not have a torch.")
        }
    }
    
    func torchOff() {
        var err:NSError?
        if captureDevice.hasTorch {
            let locked = captureDevice.lockForConfiguration(&err)
            if locked {
                captureDevice.torchMode = .Off
                self.captureDevice.unlockForConfiguration()
            } else {
                HKUtility.showMessageBox("lock configuration error.")
            }
        } else {
            HKUtility.showMessageBox("Your device does not have a torch.")
        }
    }

}

