//
//  HistoryTableViewCell.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 13.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

protocol HistoryTableViewCellOutput {
    func didFavouriteState(_ text: TranslatedText)
}

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBAction func favButton(_ sender: UIButton) {
        if let history = self.history {
            if history.isFavourite {
                self.history?.isFavourite = false
                favButton.setBackgroundImage(#imageLiteral(resourceName: "favouritesNotActiveImage"), for: .normal)
                
            } else {
                self.history?.isFavourite = true
                favButton.setBackgroundImage(#imageLiteral(resourceName: "favouritesActiveImage"), for: .normal)
            }
            
            output?.didFavouriteState(history)
        }
    }
    
    var output: HistoryTableViewCellOutput?
    
    var history: TranslatedText? {
        didSet {
            sourceLabel?.text = nil
            resultLabel?.text = nil
            directionLabel?.text = nil
            
            if let history = self.history {
                sourceLabel?.text = history.text
                resultLabel?.text = history.translate
                directionLabel?.text = history.direction
                if history.isFavourite {
                    favButton.setBackgroundImage(#imageLiteral(resourceName: "favouritesActiveImage"), for: .normal)
                } else {
                    favButton.setBackgroundImage(#imageLiteral(resourceName: "favouritesNotActiveImage"), for: .normal)
                }
            }
        }
    }
    
}
