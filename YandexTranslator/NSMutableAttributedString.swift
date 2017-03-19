//
//  NSMutableAttributedString.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 06.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    func setAttribute(_ text: String, withFont font: UIFont, withTraits traits: UIFontDescriptorSymbolicTraits = .traitUIOptimized, withColor color: UIColor? = nil) {
        
        let fontDescriptor = font.fontDescriptor.withSymbolicTraits(traits)
        var attrs: [String: AnyObject] = [NSFontAttributeName: UIFont(descriptor: fontDescriptor!, size: font.pointSize)]
        if color != nil {
            attrs[NSForegroundColorAttributeName] = color
        }
        
        let string = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(string)
    }
    
}
