//
//  HistoryViewEmpty.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 19.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

class HistoryViewEmpty: UIView {
    
    func setup(segmentIndex: Int) {
        let emptyLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "В \(segmentIndex == 0 ? "истории" : "избранном") нет ни одного перевода"
            label.textColor = UIColor.gray
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        
        let emptyImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = segmentIndex == 0 ? #imageLiteral(resourceName: "historyImage") : #imageLiteral(resourceName: "favouritesNotActiveImage")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        self.addSubview(emptyLabel)
        self.addSubview(emptyImage)

        emptyLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        emptyLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        emptyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        emptyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emptyImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyImage.bottomAnchor.constraint(equalTo: emptyLabel.topAnchor, constant: -10).isActive = true
    }
    
}
