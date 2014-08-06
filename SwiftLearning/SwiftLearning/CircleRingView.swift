//
//  CircleRingView.swift
//  Lighting
//
//  Created by Hunk on 14-7-2.
//  Copyright (c) 2014 dianxinOS. All rights reserved.
//

import Foundation
import QuartzCore

let lineCount = 72
let outerRingRadius = 140.0
let innerRingRadius = 140.0

class CircleRingView : UIView {
    
    var outerStartLayer:CALayer!
    var outerArcLayer:CALayer!
    var innerArcLayer:CALayer!
    var innerShadowLayer:CALayer!
    
    var linePath:CGMutablePath!
    var lightPath:CGMutablePath!
    
    var lineGroup:Array<CALayer> = []
    var lightGroup:Array<CALayer> = []
    var lightGroupLeft:Array<CALayer> = []
    var lightGroupRight:Array<CALayer> = []
    var lastPercent = 0
    var isSpin = false
    
    init(frame: CGRect)  {
        super.init(frame:CGRect())

        initOuterStartLayer()
        initOuterLayer()
        initInnerLayer()
        initInnerShadowLayer()
        initLineLayer()
        initLightLayer()
        
        animationOuterRingStart()
        
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let p = CGPointMake(self.bounds.width/2, self.bounds.height/2)
        outerStartLayer.position = p
        outerArcLayer.position = p
        innerArcLayer.position = p
        innerShadowLayer.position = p
        
        for lineLayer in lineGroup {
            lineLayer.position = p
        }
        for lineLayer in lightGroup {
            lineLayer.position = p
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
        let outStartAni = outerStartLayer.animationForKey("outerStartAni")
        if(anim === outStartAni) {
            outerStartLayer.removeAnimationForKey("outerStartAni")
            outerStartLayer.removeFromSuperlayer()
            animationOuterRing()
            return
        }
        
        let outAni = outerArcLayer.animationForKey("outerAni")
        if(anim === outAni) {
            outerArcLayer.removeAnimationForKey("outerAni")
            animationInnerRing()
            return
        }
        
        let innerAni = innerArcLayer.animationForKey("innerAni")
        if(anim === innerAni) {
            innerArcLayer.removeAnimationForKey("innerAni")
            animationLine()
            animationInnerShadow()
            return
        }
        
        let halfCount = Int(lineCount/2)
        let lightLayer = lightGroup[halfCount]
        let rotateAni = lightLayer.animationForKey("speedup_rotationAni")
        if(anim === rotateAni) {
            stopSpeedupAnimation()
            
            return
        }
        
        
        let lastLineLayer = lineGroup[lineGroup.count-1]
        let lineAni = lastLineLayer.animationForKey("line_rotation")
        if(anim === lineAni) {
            animationLight()

            test()
            
            
            return
        }
    }
    func test() {


        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                self.changePercentage(84)
            }
            usleep(1000 * 1500)
            dispatch_async(dispatch_get_main_queue()) {
                self.changePercentage(20)
            }
            usleep(1000 * 1100)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.showSpeedupAnimation()
                self.lastPercent = 10
            }
            usleep(1000 * 3400)
            dispatch_async(dispatch_get_main_queue()) {
                self.changePercentage(40)
            }
            usleep(1000 * 1200)
            dispatch_async(dispatch_get_main_queue()) {
                self.changePercentage(0)
            }
            usleep(1000 * 3100)
            dispatch_async(dispatch_get_main_queue()) {
                self.test()
            }
            
        }
    }
    
    func changePercentage(targetPercentage:Int) {
        if(isSpin) {
            return
        }
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            
            while(self.lastPercent != targetPercentage) {
                if(self.lastPercent > targetPercentage) {
                    self.lastPercent--
                } else {
                    self.lastPercent++
                }
                if(self.lastPercent > 100) {
                    self.lastPercent = 100
                }
                usleep(1000 * 10)
                dispatch_async(dispatch_get_main_queue()) {
                    self.showPercentage(self.lastPercent)
                }
            }
        }
    }
    
    func showPercentage(percentage:Int) {
        var i = 0
        var halfCount = Int(lineCount/2)
        var maxDouble = floor(Double(percentage) / 100.0 * Double(halfCount))
        var maxInt = Int(maxDouble)
        
        if(lightGroupLeft.count == 0) {
            for i in halfCount...lineCount {
                lightGroupLeft.append(lightGroup[i])
                lightGroupRight.append(lightGroup[halfCount-(i-halfCount)])
            }
        }

        for i in 0...halfCount  {
            let lightLayer1 = lightGroupLeft[i]
            let lightLayer2 = lightGroupRight[i]
            
            if(i <= maxInt) {
                if(i == maxInt) {
                    lightLayer1.opacity = 0.7
                    lightLayer2.opacity = 0.7
                } else if(i == maxInt-1) {
                    lightLayer1.opacity = 0.8
                    lightLayer2.opacity = 0.8
                } else if(i == maxInt-2) {
                    lightLayer1.opacity = 0.9
                    lightLayer2.opacity = 0.9
                } else {
                    lightLayer1.opacity = 1.0
                    lightLayer2.opacity = 1.0
                }
            } else {
                lightLayer1.opacity = 0.0
                lightLayer2.opacity = 0.0
            }
        }
    }
    
    func showSpeedupAnimation() {
        var halfCount = Int(lineCount/2)
        for i in 0...lineCount  {
            let lightLayer = lightGroup[i]
            lightLayer.opacity = 0
        }
        
        isSpin = true
        
        let aniTime = 1.0
        var i = halfCount
        for lineLayer in lightGroup[halfCount...halfCount+6] {

            lineLayer.opacity = 1
            
            var unit:Double = M_PI * 2.0 / Double(lineCount)
            var rotate:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotate.duration = aniTime
            rotate.toValue = NSNumber(double: M_PI * 2.0 + (Double(i)+0.5) * unit)
            rotate.repeatCount = 3
            rotate.removedOnCompletion = false
            rotate.fillMode = kCAFillModeForwards
            rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            if(lineLayer === lightGroup[halfCount]) {
                rotate.delegate = self
            }
            
            lineLayer.addAnimation(rotate, forKey: "speedup_rotationAni")
            i++
        }
    }
    
    func stopSpeedupAnimation() {
        
        isSpin = false
        
        for i in 0...lineCount  {
            let lightLayer = lightGroup[i]
            lightLayer.opacity = 0
        }
    }
    
    func initOuterStartLayer() {
        outerStartLayer = CALayer()
        outerStartLayer.contents = UIImage(named: "outer_ring").CGImage
        outerStartLayer.bounds = CGRectMake(0, 0, CGFloat(outerRingRadius*2.0), CGFloat(outerRingRadius*2.0))
    }
    
    func initOuterLayer() {
//        var outerPath:UIBezierPath!
//        outerPath = UIBezierPath(arcCenter: self.center, radius: CGFloat(outerRingRadius), startAngle: CGFloat(0), endAngle: CGFloat(2.0 * M_PI), clockwise: true)
//        outerArcLayer = CAShapeLayer()
//        outerArcLayer.strokeColor = UIColor.cyanColor().CGColor
//        outerArcLayer.lineWidth = 3
//        outerArcLayer.fillColor = UIColor(white: 0.0, alpha: 0.0).CGColor
//        outerArcLayer.path = outerPath.CGPath
        
        outerArcLayer = CALayer()
        outerArcLayer.contents = UIImage(named: "outer_ring").CGImage
        outerArcLayer.bounds = CGRectMake(0, 0, CGFloat(outerRingRadius*2.0), CGFloat(outerRingRadius*2.0))
        
    }
    
    func initInnerLayer() {
        innerArcLayer = CALayer()
        innerArcLayer.contents = UIImage(named: "inner_ring").CGImage
        innerArcLayer.bounds = CGRectMake(0, 0, CGFloat(innerRingRadius*2.0), CGFloat(innerRingRadius*2.0))
    }
    
    func initInnerShadowLayer() {
        innerShadowLayer = CALayer()
        innerShadowLayer.contents = UIImage(named: "light_ring").CGImage
        innerShadowLayer.bounds = CGRectMake(0, 0, CGFloat(innerRingRadius*2.0), CGFloat(innerRingRadius*2.0))
        innerShadowLayer.opacity = 0.0
        self.layer.addSublayer(innerShadowLayer)
    }
    
    func initLineLayer() {
        
        linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, nil, 0, CGFloat(-1.0 * outerRingRadius) + 18.0);
        CGPathAddLineToPoint(linePath, nil, 0,  CGFloat(-1.0 * outerRingRadius) + 40.0);
        
        var i = 0
        for i in 0...lineCount {
            var lineLayer:CAShapeLayer!
            lineLayer = CAShapeLayer()
            lineLayer.path = linePath
            lineLayer.fillColor = UIColor.redColor().CGColor
            lineLayer.lineWidth = 1
            lineLayer.lineCap = kCALineCapRound
            lineLayer.strokeColor = UIColor(red: 112.0/255.0, green: 137.0/255.0, blue: 197.0/255.0, alpha: 1.0).CGColor
            self.layer.addSublayer(lineLayer)
            lineLayer.hidden = true
            lineGroup.append(lineLayer)
        }
        
    }
    
    
    func initLightLayer() {
        lightPath = CGPathCreateMutable();
        CGPathMoveToPoint(lightPath, nil, 0, CGFloat(-1.0 * outerRingRadius) + 20.0);
        CGPathAddLineToPoint(lightPath, nil, 0,  CGFloat(-1.0 * outerRingRadius) + 38.0);
        
        var i = 0
        for i in 0...lineCount {
//            var lineLayer:CAShapeLayer!
//            lineLayer = CAShapeLayer()
//            lineLayer.path = lightPath
//            lineLayer.lineWidth = 4
//            lineLayer.lineCap = kCALineCapRound
//            lineLayer.strokeColor = UIColor(red: 207.0/255.0, green: 248.0/255.0, blue: 252.0/255.0, alpha: 0.9).CGColor

            
            var lineLayer:CALayer!
            lineLayer = CALayer()
            lineLayer.opacity = 0
            
            var subLayer:CALayer!
            subLayer = CALayer()
            subLayer.contents = UIImage(named: "light_scale").CGImage
            subLayer.frame = CGRectMake(-5, -126, 10,30)
            lineLayer.addSublayer(subLayer)
            
            self.layer.addSublayer(lineLayer)
            
            lightGroup.append(lineLayer)
        }
    }

    func animationOuterRingStart() {
        
        let aniTime = 1.5
        
        var scale0:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale0.duration = 1.0
        scale0.beginTime = 0
        scale0.fromValue = NSNumber(double: 0.4)
        scale0.toValue = NSNumber(double: 0.4)
        
        var opacity:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacity.duration = 0.5
        opacity.beginTime = 1.0
        opacity.fromValue = NSNumber(double: 1.0)
        opacity.toValue = NSNumber(double: 0.1)
        
        var scale1:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale1.duration = 0.5
        scale1.beginTime = 1.0
        scale1.fromValue = NSNumber(double: 0.4)
        scale1.toValue = NSNumber(double: 0.1)
        
        var aniGroup:CAAnimationGroup = CAAnimationGroup()
        aniGroup.duration = aniTime
        aniGroup.delegate = self
        aniGroup.animations = [scale0,scale1,opacity]
        aniGroup.fillMode = kCAFillModeForwards
        aniGroup.removedOnCompletion = false
        
        outerStartLayer.addAnimation(aniGroup, forKey: "outerStartAni")
        self.layer.addSublayer(outerStartLayer)
    }
    
    
    func animationOuterRing() {
        
        let aniTime = 0.5
        
        var opacity:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacity.duration = aniTime
        opacity.fromValue = NSNumber(double: 0.8)
        opacity.toValue = NSNumber(double: 1.0)
        
        var scale1:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale1.duration = aniTime
        scale1.fromValue = NSNumber(double: 0.1)
        scale1.toValue = NSNumber(double: 1.0)
        
        var aniGroup:CAAnimationGroup = CAAnimationGroup()
        aniGroup.duration = aniTime
        aniGroup.delegate = self
        aniGroup.animations = [scale1,opacity]
        aniGroup.removedOnCompletion = false
        
        outerArcLayer.addAnimation(aniGroup, forKey: "outerAni")
        self.layer.addSublayer(outerArcLayer)
    }
    
    func animationInnerRing() {
        
        let aniTime = 0.35
        var opacity:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacity.duration = aniTime
        opacity.fromValue = NSNumber(double: 0.0)
        opacity.toValue = NSNumber(double: 1.0)
        
        var scale1:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale1.duration = aniTime
        scale1.fromValue = NSNumber(double: 0.1)
        scale1.toValue = NSNumber(double: 1.0)
        
        var aniGroup:CAAnimationGroup = CAAnimationGroup()
        aniGroup.duration = aniTime
        aniGroup.delegate = self
        aniGroup.animations = [scale1,opacity]
        aniGroup.removedOnCompletion = false
        
        innerArcLayer.addAnimation(aniGroup, forKey: "innerAni")
        self.layer.addSublayer(innerArcLayer)
    }
    
    func animationInnerShadow() {
        
        let aniTime = 2.0
        var opacity:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacity.duration = aniTime
        opacity.fromValue = NSNumber(double: 0.0)
        opacity.toValue = NSNumber(double: 1.0)
        opacity.removedOnCompletion = false
        opacity.fillMode = kCAFillModeForwards
        innerShadowLayer.addAnimation(opacity, forKey: "innerShadowAni")
        
    }
    
    func animationLine() {
        let aniTime = 1.0
        var i = 0
        for lineLayer in lineGroup {
            lineLayer.hidden = false
            var unit:Double = M_PI * 2.0 / Double(lineCount)
            var rotate:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotate.duration = aniTime
            rotate.toValue = NSNumber(double:unit * Double(i))
            rotate.removedOnCompletion = false
            rotate.fillMode = kCAFillModeForwards
            rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            if(i == lineGroup.count-1) {
                rotate.delegate = self;
            }
            lineLayer.addAnimation(rotate, forKey: "line_rotation")
            i++
        }
    }
    
    func animationLight() {
        let aniTime = 0.01
        var i = 0
        for lineLayer in lightGroup {
            //lineLayer.hidden = false
            var unit:Double = M_PI * 2.0 / Double(lineCount)
            var rotate:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotate.duration = aniTime
            rotate.toValue = NSNumber(double:unit * (Double(i)+0.5))
            rotate.removedOnCompletion = false
            rotate.fillMode = kCAFillModeForwards
            rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
            if(i == lightGroup.count-1) {
                rotate.delegate = self;
            }
            lineLayer.addAnimation(rotate, forKey: "light_rotation")
            i++
        }
    }
    
    
}