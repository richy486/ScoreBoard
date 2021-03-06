//
//  ViewController.swift
//  ScoreBoard
//
//  Created by Richard Adem on 3/08/2016.
//  Copyright © 2016 Richard Adem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamSelectorLabel: UILabel!
    @IBOutlet weak var teamSelectorCenterConstraint: NSLayoutConstraint!
    var teamSelectorLabelHue = CGFloat(0.0)
    
    var score:Int = 0
    
    
    #if TARGET_OS_IOS
        override var prefersStatusBarHidden: Bool {get {return true}}
    #endif
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateLabel()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap_screen))
        view.addGestureRecognizer(tap)
        
        let tapTeam = UITapGestureRecognizer(target: self, action: #selector(tap_team))
        teamImageView.addGestureRecognizer(tapTeam)
        
        timer_color()
//        Timer.scheduledTimer(timeInterval: 1.0
//            , target: self
//            , selector: #selector(timer_color)
//            , userInfo: nil
//            , repeats: true)
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tap_screen(tap: UIGestureRecognizer) {
        let location = tap.location(in: view)
        
        if location.x < view.frame.width / 2 {
            score -= 1
            
        } else {
            score += 1
        }
        
        updateLabel()
    }
    
    func tap_team(tap: UIGestureRecognizer) {
        let location = tap.location(in: teamImageView)
        
        if location.x < teamImageView.frame.width * 0.33 {
            teamSelectorCenterConstraint.constant = -teamImageView.frame.size.width * 0.25
        } else if location.x > teamImageView.frame.width * 0.66 {
            teamSelectorCenterConstraint.constant = teamImageView.frame.size.width * 0.25
        } else {
            teamSelectorCenterConstraint.constant = 0
        }
        
        
        
        let fontFamilyNames = UIFont.familyNames
        var rand1 = Int(arc4random()%UInt32(fontFamilyNames.count))
        var familyName = fontFamilyNames[rand1]
        var names = UIFont.fontNames(forFamilyName: familyName )
        while names.count == 0 {
            rand1 = Int(arc4random()%UInt32(fontFamilyNames.count))
            familyName = fontFamilyNames[rand1]
            names = UIFont.fontNames(forFamilyName: familyName )
            
        }
        
        
        
        let rand = Int(arc4random()%UInt32(names.count))
        let fontName = names[rand]
        
        teamSelectorLabel.font = UIFont(name: fontName, size: 150)
    }
    
    func timer_color() {
        
        teamSelectorLabelHue += 0.01
        
        while teamSelectorLabelHue > 1.0 {
            teamSelectorLabelHue -= 1.0
        }
        
        let newColor = UIColor(hue: self.teamSelectorLabelHue
            , saturation: 0.75
            , brightness: 1.0
            , alpha: 1.0)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            self.teamSelectorLabel.textColor = newColor
            
            }, completion: { finished in
                
                let deadlineTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    self.timer_color()
                }
                
        })
    }
    
    func updateLabel() {
        numberLabel.text = "\(score)"
        
        let fontFamilyNames = UIFont.familyNames
        var rand1 = Int(arc4random()%UInt32(fontFamilyNames.count))
        var familyName = fontFamilyNames[rand1]
        var names = UIFont.fontNames(forFamilyName: familyName )
        while names.count == 0 {
            rand1 = Int(arc4random()%UInt32(fontFamilyNames.count))
            familyName = fontFamilyNames[rand1]
            names = UIFont.fontNames(forFamilyName: familyName )

        }
        

        
        let rand = Int(arc4random()%UInt32(names.count))
        let fontName = names[rand]
        
        numberLabel.font = UIFont(name: fontName, size: 300)
        
        let hue = CGFloat(arc4random()%UInt32(1000))/1000
        numberLabel.textColor = UIColor(hue: hue
            , saturation: 0.75
            , brightness: 1.0
            , alpha: 1.0)
        
        let hue2:CGFloat = {
            let h = hue + 0.5
            if h > 1.0 {
                return h - 1.0
            } else {
                return h
            }
        }()
        view.backgroundColor = UIColor(hue: hue2
            , saturation: 0.75
            , brightness: 1.0
            , alpha: 1.0)
        
        let scale = ((CGFloat(arc4random()%UInt32(1000))/1000) * 3) + 1
        numberLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}

