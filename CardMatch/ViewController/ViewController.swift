//
//  ViewController.swift
//  CardMatch
//
//  Created by Mani Megalai on 5/7/20.
//  Copyright © 2020 Mani Megalai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
   
    @IBOutlet weak var btnReatst: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblSteps: UILabel!
    var model = CardModel()
    var cardArray = [Card]()
    var aryCount = [Int]()
    
    // to check match card
    
    var firstFlippedCardIndex:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the getCards method of the card model
        collectionView.delegate = self
        collectionView.dataSource = self
        cardArray = model.getCards()
    }
    
    @IBAction func setRestart(_ sender: Any) {
        restart()
    }
    
    func restart() {
        self.aryCount.removeAll()
        self.lblSteps.text = "STEPS: 0"
        collectionView.reloadData()
        cardArray = model.getCards()
    }
    
    // MARK: - UICollectionView Protocol Method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // Get cardCollectionviewcwll object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        if card.isFlipped == false && card.isMatched == false {
            //Flip Card
            cell.flip()
            card.isFlipped = true
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else{
                // Matching logic
                if indexPath[0] == indexPath[1]{
                    card.isFlipped = false
                }else{
                    checkForMatches(indexPath)
                }
            }
            self.aryCount.append(indexPath.item)
            self.lblSteps.text = "STEPS: \(self.aryCount.count)"
        }
        else{
            // Flip the card back
            cell.flipBack()
            card.isFlipped = false
        }
    }
    
    // MARK: Game Logic Method
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        if cardOne.lblName == cardTwo.lblName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            // Remove the cards from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            // Check if there are any cards left unmatched
            checkEndGame()
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            //Flip both card back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
    }
    
    func checkEndGame() {
        // any card unmatch
        var  isWon = true
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        // game won show alert
        var title = ""
        var message = ""
        if isWon == true {
            title = "Congratulations!"
            message = "You win this game by \(self.aryCount.count + 1) steps"
            showAlert(title, message)
        }
    }
    
    func showAlert(_ title:String, _ message:String) {
        // show message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Another Round", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
            self.restart()
        }))
        present(alert, animated: true, completion: nil)
    }

}

