//
//  WaterView.swift
//  Lighting
//
//  Created by Hunk on 14-6-30.
//  Copyright (c) 2014 dianxinOS. All rights reserved.
//

import Foundation

class WaterView:UIView {
    var _waterColor:UIColor!
    var _currentLinePointY:Double!
    var a:Double!
    var b:Double!
    var jia:Bool!
    

    init(frame: CGRect) {
        super.init(frame:CGRect())
        a = 1.5
        b = 0.0
        jia = false
        _waterColor = UIColor(red: 86/255.0, green: 152/255.0, blue: 240/255.0, alpha: 1.0)
        _currentLinePointY = 350.0
        self.backgroundColor = UIColor.whiteColor()
        NSTimer.scheduledTimerWithTimeInterval(1.0/30 , target: self, selector: Selector("animateWave"), userInfo: nil, repeats: true)
        
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
        _currentLinePointY = _currentLinePointY - 0.1;
        
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        
        var context:CGContextRef! = UIGraphicsGetCurrentContext();
        var path:CGMutablePath! = CGPathCreateMutable();
        
        //画水
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, _waterColor.CGColor);
        
        var x:Double,y:Double = _currentLinePointY;
        
        CGPathMoveToPoint(path, nil, 0, y);
        
        for (x=0;x<320.0;x++) {
            y = a * sin( x/180.0 * M_PI + 4.0 * b / M_PI ) * 5.0 + _currentLinePointY;
            CGPathAddLineToPoint(path, nil, x, y);
        }
        
        CGPathAddLineToPoint(path, nil, 320, rect.size.height);
        CGPathAddLineToPoint(path, nil, 0, rect.size.height);
        CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
        
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        CGContextDrawPath(context, kCGPathStroke);
        CGPathRelease(path);
    }    
}
