//
//  HistoryTableViewAdapter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 13.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

protocol HistoryTableViewAdapterOutput {
    func removeObject(_ text: TranslatedText)
    func didSelectRow(_ text: TranslatedText)
    func didFavouriteStateRow(_ text: TranslatedText)
}

class HistoryTableViewAdapter: NSObject {
    
    var output: HistoryTableViewAdapterOutput?
    
    var items = [TranslatedText]()
    
    var tableView: UITableView!
    
    init(forTableView tableView: UITableView, translatedTexts: [TranslatedText]) {
        self.items = translatedTexts
        self.tableView = tableView
    }

}

extension HistoryTableViewAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath)
        if let historyCell = cell as? HistoryTableViewCell {
            historyCell.history = self.items[indexPath.row]
            historyCell.output = self
        }
        return cell
    }
}

extension HistoryTableViewAdapter: HistoryTableViewCellOutput {
    func didFavouriteState(_ text: TranslatedText) {
        output?.didFavouriteStateRow(text)
    }
}

extension HistoryTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            output?.removeObject(self.items[indexPath.row])
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.items[indexPath.row]
        output?.didSelectRow(item)
    }
}
