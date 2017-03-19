//
//  LanguageTableViewAdapter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 06.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

protocol LanguageTableViewAdapterOutput {
    func itemSelected(item: Lang)
}

class LanguageTableViewAdapter: NSObject {
    
    fileprivate var languages = [[Lang]]()
    
    var output: LanguageTableViewAdapterOutput?
    
    init(forTableView tableView: UITableView, languages: [Lang]) {
        self.languages.insert(languages, at: 0)
        tableView.reloadData()
    }
}

extension LanguageTableViewAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.languages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lang", for: indexPath)
        let lang = languages[indexPath.section][indexPath.row]
        cell.textLabel?.text = lang.name
        return cell
    }
}

extension LanguageTableViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let lang = languages[indexPath.section][indexPath.row]
        output?.itemSelected(item: lang)
    }
    
}
