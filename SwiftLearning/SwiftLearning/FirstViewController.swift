//
//  FirstViewController.swift
//  SwiftLearning
//
//  Created by Hunk on 14-6-16.
//  Copyright (c) 2014 dianxinOS. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class FirstViewController: UIViewController {
    
    var titleLabel:UILabel!
    var subtitleLabel:UILabel!
    var captureDevice:AVCaptureDevice!
    var waterBackgroundView:WaterView!
    var circleView:CircleView!
    var ringView:CircleRingView!
    var bgView:UIImageView!
    
    override func loadView() {
        super.loadView()
        
        bgView = UIImageView(image: UIImage(named: "bg_iphone5"))
        self.view.addSubview(bgView)
        
//        //Speed Ring View
//        ringView = CircleRingView(frame: CGRectZero)
//        self.view.addSubview(ringView)
        
//        //Water background
//        waterBackgroundView = WaterView(frame: CGRectZero)
//        self.view.addSubview(waterBackgroundView)
        
//        //Ring View
//        circleView = CircleView(frame: CGRectZero)
//        self.view.addSubview(circleView)
//        circleView.layer.addAnimation(ani, forKey: "animation")
        
        
//        //Text
//        self.view.backgroundColor = UIColor.whiteColor()
//        var attStr:NSMutableAttributedString = NSMutableAttributedString(string: "100 M")
//        attStr.addAttribute(NSForegroundColorAttributeName,
//            value: UIColor.redColor(), range: NSMakeRange(0, 5))
//        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(33), range: NSMakeRange(0, 5))
//        titleLabel = UILabel()
//        titleLabel.font = UIFont.systemFontOfSize(14.0)
//        titleLabel.textAlignment = .Center
//        titleLabel.attributedText = attStr;
//        self.view.addSubview(titleLabel)
//        subtitleLabel = UILabel()
//        subtitleLabel.text = "free memeory"
//        self.view.addSubview(subtitleLabel)
        
        
    }
    
    override func viewWillLayoutSubviews()  {
        super.viewWillLayoutSubviews()
        let f = self.view.bounds
        bgView.frame = f
//        titleLabel.frame = CGRectMake(100, 130, 120, 30)
//        subtitleLabel.frame = CGRectMake(100, 160, 120, 30)
//        waterBackgroundView.frame = f
//        circleView.frame = CGRectMake(160, 160, 120, 120)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
//        HKUtility.playVibrate()
//        HKUtility.showMessageBox(HKUtility.dateStrWithFormat("HH:mm"));
//
//        initTorch()
//        torchOn();
//        let torchOffSel = Selector("torchOff")
//        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: torchOffSel, userInfo: nil, repeats: false)
//        
//        var nn = [1,23,3,42,5,6]
//        println(nn)
//        sort(nn,<=)
//        println(nn)
//        
//        var RSSI:Int = 80
//        var distance = 0.0
//        
//        for RSSI in 40...100 {
//            var temp:Double = Double(RSSI - 50) / 38
//            distance = pow(10.0, temp);
//            println("dbm = -\(RSSI) distance = \(distance)")
//        }
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        ringView = CircleRingView(frame: CGRectZero)
        ringView.frame = CGRectMake(20, 80, 280, 280)
        self.view.addSubview(ringView)
    }
    
    override func viewWillDisappear(animated: Bool)  {
        super.viewWillDisappear(animated)
        ringView.removeFromSuperview()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //HKAnimation.animationCubeFromRight(self.view)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Torch related functions
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

