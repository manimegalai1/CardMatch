//
//  CardModel.swift
//  CardMatch
//
//  Created by Mani Megalai on 5/7/20.
//  Copyright © 2020 Mani Megalai. All rights reserved.
//

import Foundation

class CardModel {
     
    func getCards() -> [Card] {
        // Declare an array to store the generated cards
        var generateCardArray = [Card]()
        // Randomly generate pairs of cards
        for _ in 1...6 {
            // Get randomNumber
            let randomNumber = Int.random(in: 1 ... 99)
            // create the first card object
            let cardOne = Card()
            cardOne.lblName = "\(randomNumber)"
            generateCardArray.append(cardOne)
            
            // create the second card object
            
            let cardTwo = Card()
            cardTwo.lblName = "\(randomNumber)"
            generateCardArray.append(cardTwo)
        }
        generateCardArray.shuffle()
        
        // Return the array
        
        return generateCardArray
    }
}
