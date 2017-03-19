//
//  HistoryHistoryViewController.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class HistoryViewController: ViperModuleViewController, HistoryViewInput {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        fillTable()
    }
    @IBAction func removeAll(_ sender: UIBarButtonItem) {
        if let texts = tableViewAdapter?.items {
            cleanTable()
            output.removeAll(texts, segmentedControl.selectedSegmentIndex)
        }
    }
    
    fileprivate var tableViewAdapter: HistoryTableViewAdapter?
    fileprivate var searchBarAdapter: HistorySearchBarAdapter?
    
    var output: HistoryViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.searchBar.setValue("Отменить", forKey: "_cancelButtonText")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.contentOffset = CGPoint(x: 0, y: self.searchBar.frame.height)
    }
    
    // MARK: Private helpers
    func cleanTable() {
        tableViewAdapter?.items.removeAll()
        tableView.reloadData()
    }
    
    func fillTable() {
        cleanTable()
        output.getTranslatedTexts(segmentIndex: segmentedControl.selectedSegmentIndex)
    }
    
    // MARK: HistoryViewInput
    func setupInitialState() {
    }
    internal func setupView(withTexts texts: [TranslatedText]) {
        tableViewAdapter = HistoryTableViewAdapter(forTableView: tableView, translatedTexts: texts)
        tableViewAdapter?.output = self
        tableView.delegate = tableViewAdapter
        tableView.dataSource = tableViewAdapter
        tableView.reloadData()
        
        searchBarAdapter = HistorySearchBarAdapter(items: texts)
        searchBarAdapter?.output = self
        searchBar.delegate = searchBarAdapter
                
        if texts.count == 0 {
            let emptyView = HistoryViewEmpty(frame: self.tableView.frame)
            emptyView.setup(segmentIndex: segmentedControl.selectedSegmentIndex)
            self.tableView.backgroundView = emptyView
            self.searchBar.isHidden = true
        } else {
            self.tableView.backgroundView = nil
            self.searchBar.isHidden = false
        }
    }

}

extension HistoryViewController: HistorySearchBarAdapterOutput {
    func didFilteredList(_ items: [TranslatedText]) {
        tableViewAdapter?.items = items
        tableView.reloadData()
    }
}

extension HistoryViewController: HistoryTableViewAdapterOutput {
    func didFavouriteStateRow(_ text: TranslatedText) {
        output.changeFavouriteStateTranslatedText(text)
    }

    func removeObject(_ text: TranslatedText) {
        output.removeTranslatedText(text, segmentedControl.selectedSegmentIndex)
    }
    
    func didSelectRow(_ text: TranslatedText) {
        searchBar.text = ""
        searchBar.endEditing(true)
        output.openTranslatedText(text)
    }
}
