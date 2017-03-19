//
//  TranslateTableViewAdapter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 06.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

class TranslateTableViewAdapter: NSObject {
    
    fileprivate let translateTableViewCell = String(describing: TranslateTableViewCell.self)
    var definitions: [Definition]
    
    init(forTableView tableView: UITableView, dictionary: Dictionary) {
        tableView.register(UINib(nibName: translateTableViewCell, bundle: nil), forCellReuseIdentifier: translateTableViewCell)
        self.definitions = dictionary.definitions
    }
}

extension TranslateTableViewAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.definitions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let translations = self.definitions[section].translation else { return 0 }
        return translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: translateTableViewCell, for: indexPath)
        let translation = definitions[indexPath.section].translation?[indexPath.row]
        if let translationCell = cell as? TranslateTableViewCell {
            translationCell.translation = translation
        }
        return cell
    }
}

extension TranslateTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        lbl.numberOfLines = 0
        let text = NSMutableAttributedString()
        text.setAttribute(definitions[section].text!, withFont: lbl.font)
        if let ts = definitions[section].transcription {
            text.setAttribute(" [" + ts + "]", withFont: lbl.font, withColor: .gray)
        }
        if let pos = definitions[section].pos {
            text.setAttribute("\n\(pos)", withFont: lbl.font, withTraits: .traitItalic, withColor: #colorLiteral(red: 0.8, green: 0.6, blue: 0.8, alpha: 1))
        }
        lbl.attributedText = text
        lbl.superview?.backgroundColor = UIColor.red
        return lbl
    }
    
}
