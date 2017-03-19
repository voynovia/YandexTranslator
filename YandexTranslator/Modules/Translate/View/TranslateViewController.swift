//
//  TranslateTranslateViewController.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class TranslateViewController: ViperModuleViewController, TranslateViewInput {
    private var textViewAdapter: TranslateTextViewAdapter?
    fileprivate var tableViewAdapter: TranslateTableViewAdapter?
    var output: TranslateViewOutput!

    @IBOutlet weak var sourceText: UITextView!
    @IBOutlet weak var targetText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sourceLanguage: UIBarButtonItem!
    @IBOutlet weak var targetLanguage: UIBarButtonItem!
    
    @IBAction func changeLanguages(_ sender: UIButton) {
        output.changeDirection()
    }
    @IBAction func sourceLanguageButton(_ sender: UIBarButtonItem) {
        output.toSelectLanguage(selectableLanguages: .source)
    }
    @IBAction func targetLanguageButton(_ sender: UIBarButtonItem) {
        output.toSelectLanguage(selectableLanguages: .target)
    }
        
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        textViewAdapter = TranslateTextViewAdapter()
        textViewAdapter?.output = self
        sourceText.delegate = textViewAdapter
        
        // MARK: set source text
        setSourceTextNotActive()
        
        // MARK: Set tableView
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.tableView.estimatedSectionHeaderHeight = 20
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapToTableView(_:))))
    }
    
    func tapToTableView(_ sender: UITapGestureRecognizer) {
        if !UserDefaults.standard.bool(forKey: "isUseReturn") && !self.sourceText.text.isEmpty {
            output.didEditSourceText(text: sourceText.text)
        }
        self.sourceText.endEditing(true)
    }

    // MARK: TranslateViewInput
    internal func setupView(withDictionary dictionary: Dictionary) {
        tableViewAdapter = TranslateTableViewAdapter(forTableView: tableView, dictionary: dictionary)
        tableView.delegate = tableViewAdapter
        tableView.dataSource = tableViewAdapter
        tableView.reloadData()
    }
    internal func setupView(withTranslate text: String) {
        targetText.text = text
    }
    internal func setTitleSourceLanguage(_ lang: Lang) {
        self.sourceLanguage.title = lang.name
    }
    internal func setTitleTargetLanguage(_ lang: Lang) {
        self.targetLanguage.title = lang.name
    }
    internal func setupSourceText(_ text: String) {
        self.sourceText.text = text
    }
}

extension TranslateViewController: TranslateTextViewAdapterOutput {
    
    func sourceTextEdited(sourceText: String) {
        self.targetText.text = ""
        tableViewAdapter?.definitions.removeAll()
        tableView.reloadData()
        output.didEditSourceText(text: sourceText)
    }
    func setSourceTextActive() {
        sourceText.layer.borderColor = #colorLiteral(red: 1, green: 0.8588235294, blue: 0.3019607843, alpha: 1).cgColor
        sourceText.layer.borderWidth = 2.0
    }
    func setSourceTextNotActive() {
        sourceText.layer.borderColor = UIColor.gray.cgColor
        sourceText.layer.borderWidth = 1.0
    }
}
