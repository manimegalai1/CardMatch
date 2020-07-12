//
//  CardCollectionViewCell.swift
//  CardMatch
//
//  Created by Mani Megalai on 5/7/20.
//  Copyright © 2020 Mani Megalai. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblRandomValue: UILabel!
    @IBOutlet weak var backCardImg: UIImageView!
    var card:Card?
     
    func setCard(_ card:Card) {
        
        // keep track card
        self.card = card
        
        if card.isMatched == true {
            backCardImg.alpha = 0
            lblRandomValue.alpha = 1
            return
        }else{
            backCardImg.alpha = 1
            lblRandomValue.alpha = 1
        }
        lblRandomValue.text = card.lblName
        if card.isFlipped == true {
            UIView.transition(from: backCardImg, to: lblRandomValue, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: lblRandomValue, to: backCardImg, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip() {
        UIView.transition(from: backCardImg, to: lblRandomValue, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        if self.card?.isMatched == true {
        }else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                       UIView.transition(from: self.lblRandomValue, to: self.backCardImg, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
                   }
        }
    }
    
    func remove() {
        backCardImg.alpha = 0
        lblRandomValue.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: { self.lblRandomValue.alpha = 1 }, completion: nil)
    }
    
}
