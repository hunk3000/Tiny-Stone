//
//  WaterView.swift
//  Lighting
//
//  Created by Hunk on 14-6-30.
//  Copyright (c) 2014 dianxinOS. All rights reserved.
//

import Foundation
import QuartzCore

class WaterView:UIView {
    var _waterColor:UIColor!
    var _currentLinePointY:CGFloat!
    var a:CGFloat!
    var b:CGFloat!
    var jia:Bool!
    
    init(frame: CGRect) {
        super.init(frame:CGRect())
        self.backgroundColor = UIColor.blackColor()
        a = 1.5
        b = 0.0
        jia = false
        _waterColor = UIColor(red: 86/255.0, green: 152/255.0, blue: 240/255.0, alpha: 1.0)
        _currentLinePointY = self.bounds.size.height
        
        
        NSTimer.scheduledTimerWithTimeInterval(1.0/24 , target: self, selector: Selector("animateWave"), userInfo: nil, repeats: true)
        
        var keyframeAni = CAKeyframeAnimation()
        keyframeAni.values = [
            UIColor.blackColor().CGColor,
            UIColor.brownColor().CGColor,
            UIColor.blueColor().CGColor
        ];
        keyframeAni.duration=10;
        keyframeAni.autoreverses=true;
        keyframeAni.repeatCount = 10
        self.layer.addAnimation(keyframeAni, forKey: "backgroundColor")
    }
    
    func animateWave() -> Void {
        if (jia == true) {
            a = a + 0.01
        }else{
            a = a - 0.01
        }
        
        if (a<=1) {
            jia = true;
        }
        
        if (a>=1.5) {
            jia = false;
        }
        
        b = b + 0.1;
        _currentLinePointY = _currentLinePointY - 0.5;
        if(_currentLinePointY < 0) {
            _currentLinePointY = self.bounds.height
        }
        
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        
        var context:CGContextRef! = UIGraphicsGetCurrentContext();
        var path:CGMutablePath! = CGPathCreateMutable();
        
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, _waterColor.CGColor);
        
        var x:CGFloat,y:CGFloat = _currentLinePointY;
        
        CGPathMoveToPoint(path, nil, 0, y);
        
        for (x=0.0;x<=self.bounds.size.width;x+=20) {
            
            y = CGFloat(Double(a) * sin( Double(x)/180.0 * M_PI + 4.0 * Double(b) / M_PI ) * 5.0) + _currentLinePointY;
            
            CGPathAddLineToPoint(path, nil, x, y);
        }
        
        CGPathAddLineToPoint(path, nil, self.bounds.width, rect.size.height);
        CGPathAddLineToPoint(path, nil, 0, rect.size.height);
        CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
        
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        CGContextDrawPath(context, kCGPathStroke);
        //CGPathRelease(path);
    }    
}
