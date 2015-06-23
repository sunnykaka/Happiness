//
//  HappinessViewController.swift
//  Happiness
//
//  Created by liubin on 15/6/23.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {

    // 0 - 100
    var happiness: Int = 75 {
        didSet {
            happiness = max(min(happiness, 100), 0)
            println("happiness: \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Changed: fallthrough
        case .Ended:
            let point = gesture.translationInView(faceView)
            println("point.y in pan: \(point.y)")
            let happinessChange = -Int(point.y) / 4
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
}
