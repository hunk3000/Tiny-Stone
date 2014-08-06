//
//  CircleView.swift
//  Lighting
//
//  Created by Hunk on 14-6-30.
//  Copyright (c) 2014 dianxinOS. All rights reserved.
//

import Foundation
import QuartzCore

class CircleView:UIView {
    
    var path:UIBezierPath!
    var arcLayer:CAShapeLayer!
    
    init(frame: CGRect)  {
        super.init(frame:CGRect())
        
        let rect = UIScreen.mainScreen().applicationFrame;
        path = UIBezierPath(arcCenter: self.center, radius: CGFloat(100.0), startAngle: CGFloat(0), endAngle: CGFloat(2.0 * M_PI), clockwise: true)
        
        arcLayer = CAShapeLayer()
        arcLayer.strokeColor = UIColor.redColor().CGColor
        arcLayer.fillColor = UIColor(white: 0.8, alpha: 0.5).CGColor
        arcLayer.path = path.CGPath
        arcLayer.lineWidth = 5
        arcLayer.frame = self.frame
        
        var bas:CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        bas.duration=2;
        bas.delegate=self;
        bas.fromValue = NSNumber(double: 0.0)
        bas.toValue = NSNumber(double: 1.0)
        //bas.autoreverses = true
        bas.repeatCount = 2
        bas.removedOnCompletion = false
        arcLayer.addAnimation(bas, forKey: "key")
        
        self.layer.addSublayer(arcLayer)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool)  {
        NSLog("Animation did stop", nil)
    }
    
}