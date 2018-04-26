//
//  ViewController.swift
//  oekaki_sea
//
//  Created by kaoru on 2018/02/19.
//  Copyright © 2018年 kaoru Morito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    var red: CGFloat     = 1.0
    var green: CGFloat   = 1.0
    var blue: CGFloat    = 1.0
    var alpha: CGFloat   = 1.0

    var color = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func redSlider(_ sender: UISlider) {

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        color = UIColor(red: CGFloat(sender.value), green:green, blue: blue, alpha: alpha)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    @IBAction func GreenSlider(_ sender: UISlider) {
        color = UIColor(red:red, green:CGFloat(sender.value), blue: blue, alpha: alpha)
    }

    @IBAction func blueSlider(_ sender: UISlider) {
        color = UIColor(red:red, green:green, blue: CGFloat(sender.value), alpha: alpha)
    }
    
    /**
     * 線を描く
     */
    func drawLines(fromPoint:CGPoint, toPoint:CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x:0, y: 0 , width:self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(3)
        context?.setStrokeColor(color.cgColor)
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

