//
//  TranslateTableViewCell.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 06.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

class TranslateTableViewCell: UITableViewCell {

    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    var translation: Translation? {
        didSet {
            updateUI()
        }
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    private func updateUI() {
        translateLabel?.text = nil
        meanLabel?.text = nil
        exampleLabel?.text = nil
        
        guard let translation = self.translation else { return }
        
        let transText = NSMutableAttributedString()
        transText.setAttribute(translation.text!, withFont: translateLabel.font)
        if let gen = translation.gen {
            transText.setAttribute(" \(gen)", withFont: translateLabel.font, withTraits: .traitBold, withColor: .gray)
        }
        if let synonyms = translation.synonym {
            for syn in synonyms {
                transText.setAttribute(", \(syn.text!)", withFont: translateLabel.font)
                if let gen = syn.gen {
                    transText.setAttribute(" \(gen)", withFont: translateLabel.font, withTraits: .traitBold, withColor: .gray)
                }
            }
        }
        translateLabel?.attributedText = transText
        
        var meanText = ""
        if let means = translation.mean {
            if means.count > 0 {
                meanText += "(" + means[0].text!
                for i in 1..<means.count {
                    meanText += ", " + means[i].text!
                }
                meanText += ")"
            }
            meanLabel?.text = meanText
        }
        
        if let examples = translation.example {
            let exampleText = NSMutableAttributedString()
            for i in 0..<examples.count {
                let example = examples[i]
                if let text = example.text, let tr = example.translation?[0].text {
                    exampleText.setAttribute(text, withFont: translateLabel.font)
                    exampleText.setAttribute(" - \(tr)", withFont: translateLabel.font, withTraits: .traitItalic, withColor: .lightGray)
                    if i != examples.count-1 {
                        exampleText.setAttribute("\n", withFont: translateLabel.font)
                    }
                }
            }
            exampleLabel?.attributedText = exampleText
        }
        
    }

}
