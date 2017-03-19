//
//  HistorySearchBarAdapter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 19.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

protocol HistorySearchBarAdapterOutput {
    func didFilteredList(_ items: [TranslatedText])
}

class HistorySearchBarAdapter: NSObject {

    var output: HistorySearchBarAdapterOutput?
    var items = [TranslatedText]()
    
    init(items: [TranslatedText]) {
        self.items = items
    }
}

extension HistorySearchBarAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            let filteredList = self.items.filter({ $0.text.contains(searchText.lowercased()) })
            output?.didFilteredList(filteredList)
        } else {
            output?.didFilteredList(self.items)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        output?.didFilteredList(self.items)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }

}
