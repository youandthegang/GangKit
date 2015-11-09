

import UIKit

let Progress_magicTag: Int = 3141598

class ProgressAnimationView: UIView {
    
    let radius: CGFloat = 16.0
    
    let animationStepCount = 100
    let animationDuration = 0.8
    
    var circlePositions: [CGPoint] = []
    var circleSizes: [CGFloat] = []
    
    let circleMinSize: CGFloat = 7
    
    let circleMinScale: CGFloat = 0.6
    let circleMaxScale: CGFloat = 0.9
    
    //var circle = UIView(frame: CGRectZero)
    
    let circleCount = 5
    var circles: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        
        for _ in 0..<circleCount {
            let circle = UIView(frame: CGRectZero)
            circle.backgroundColor = UIColor.orangeColor()
            circle.frame = CGRectMake(0, 0, circleMinSize, circleMinSize)
            circle.layer.cornerRadius = 0.5*circleMinSize
            circle.alpha = 0.5 // + 0.5*CGFloat(k)/CGFloat(circleCount)
            circles.append(circle)
            addSubview(circle)
        }
        
        let angleStep = 2 * 3.14159 / Double(animationStepCount-1)
        var angle = 0.0
        
        let sizeDelta = circleMaxScale - circleMinScale
        
        for _ in 0..<animationStepCount {
            let point = CGPointMake(0.5*frame.size.width+radius*CGFloat(-sin(angle)), 0.5*frame.size.height+radius*CGFloat(cos(angle)))
            circlePositions.append(point)
            circleSizes.append(circleMinScale + 0.5*sizeDelta + 0.5*sizeDelta*CGFloat(sin(-0.5*3.14159+angle)))
            angle += angleStep
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        
        for k in 0..<circleCount {
            let circle = self.circles[k]
            circle.center = self.circlePositions[0]
            circle.transform = CGAffineTransformMakeScale(self.circleSizes[0], self.circleSizes[0])
        }
        
        UIView.animateKeyframesWithDuration(animationDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: UIViewKeyframeAnimationOptions.Repeat.rawValue | UIViewKeyframeAnimationOptions.CalculationModeLinear.rawValue), animations: { () -> Void in
            
            let keyframeDuration = 1.0 / Double(self.animationStepCount)
            for k in 0..<self.animationStepCount {
                let startTime = Double(k) * keyframeDuration
                UIView.addKeyframeWithRelativeStartTime(startTime, relativeDuration: keyframeDuration, animations: { () -> Void in
                    
                    for c in 0..<self.circleCount {
                        let circle = self.circles[c]
                        var frameIndex = k+Int(CGFloat(startTime)*CGFloat(c*10))
                        if frameIndex >= self.animationStepCount {
                            frameIndex = self.animationStepCount - 1
                        }
                        circle.center = self.circlePositions[frameIndex]
                        circle.transform = CGAffineTransformMakeScale(self.circleSizes[frameIndex], self.circleSizes[frameIndex])
                    }
                    
                    //self.circle.center = self.circlePositions[k]
                    //self.circle.transform = CGAffineTransformMakeScale(self.circleSizes[k], self.circleSizes[k])
                })
            }
            
            }) { (done) -> Void in
        }
    }
    
    func stopAnimation() {
        layer.removeAllAnimations()
    }
    
}

class Progress {
    
    private class func getProgressFromView(view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.tag == Progress_magicTag {
                return subview
            }
        }
    
        return nil
    }
    
    class func showProgressInView(view: UIView) {
        
        if let existingProgress = getProgressFromView(view) {
            
            if let existingProgress = existingProgress as? ProgressAnimationView {
                existingProgress.startAnimation()
            }
            
            return
        }
        
        let animationView = ProgressAnimationView(frame: view.bounds)
        
        view.addSubview(animationView)
        animationView.frame = view.bounds
        animationView.tag = Progress_magicTag
        
        animationView.startAnimation()
    }
    
    class func hideProgressInView(view: UIView) {
        if let existingProgress = getProgressFromView(view) as? ProgressAnimationView {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                existingProgress.alpha = 0.0
                }, completion: { (done) -> Void in
                    existingProgress.stopAnimation()
                    existingProgress.removeFromSuperview()
            })
        }
    }
    
}