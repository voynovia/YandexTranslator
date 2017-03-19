//
//  LanguageLanguageViewController.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class LanguageViewController: ViperModuleViewController, LanguageViewInput {
    var output: LanguageViewOutput!

    private var tableViewAdapter: LanguageTableViewAdapter?

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        output.backToTranslate()
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = #colorLiteral(red: 1, green: 0.8588235294, blue: 0.3019607843, alpha: 1)
            }
        }
    }

    // MARK: LanguageViewInput
    func setupInitialState() {
    }
    
    internal func setHeader(_ text: String) {
        navigationBar.topItem?.title = text
    }
    
    func setupView(withLangs langs: [Lang]) {
        tableViewAdapter = LanguageTableViewAdapter(forTableView: tableView, languages: langs)
        tableViewAdapter?.output = self
        tableView.delegate = tableViewAdapter
        tableView.dataSource = tableViewAdapter
    }
}

extension LanguageViewController: LanguageTableViewAdapterOutput {
    func itemSelected(item: Lang) {
        output.setLanguage(withLang: item)
    }
}
