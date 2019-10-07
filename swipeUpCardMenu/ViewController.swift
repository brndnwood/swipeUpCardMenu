//
//  ViewController.swift
//  swipeUpCardMenu
//
//  Created by Brandon Wood on 9/25/19.
//  Copyright © 2019 Brandon Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardHeight: NSLayoutConstraint!
    
    var startPanY : CGFloat?
    
    var cardHiddenConstant  : CGFloat?
    var cardShowingConstant : CGFloat?
    
    var cardHidden : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardShowingConstant = cardBottomConstraint.constant
        
        // hide card menu
        cardHiddenConstant = (cardHeight.constant * -1) + 75
        cardBottomConstraint.constant = cardHiddenConstant!
        
        
        // create pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(detectPan(recognizer:)))

        // attach pan gesture to card
        cardView.gestureRecognizers = [panGesture]
        
    }


    

    @objc func detectPan(recognizer : UIPanGestureRecognizer) {
        print("detectPan")
        
        let velocity  = recognizer.velocity(in: cardView)
        let isVertical = abs(velocity.y) > abs(velocity.x)
        print("isVertical = \(isVertical)")
        
        let location = recognizer.location(in: cardView)
        print(location)
        

        
        switch recognizer.state {
        case .began:
            print("began")
            startPanY = location.y
            
        case .changed:
            print("changed")
            
            let delta = startPanY! - location.y
            print ("delta = \(delta)")
            
            if (cardBottomConstraint.constant + delta < cardShowingConstant!) {
                cardBottomConstraint.constant += delta
            }
            
            
            
        case .ended:
            print("ended")
            
            if (cardHidden) {
                self.cardBottomConstraint.constant = self.cardShowingConstant!

                UIView.animate(withDuration: 0.1, animations: {
                    self.view.layoutIfNeeded()

                })
                
            } else {
                self.cardBottomConstraint.constant = self.cardHiddenConstant!

                UIView.animate(withDuration: 0.1, animations: {
                    self.view.layoutIfNeeded()

                })
            }

            cardHidden = !cardHidden

            
        default:
            break;
        }
    }
}

