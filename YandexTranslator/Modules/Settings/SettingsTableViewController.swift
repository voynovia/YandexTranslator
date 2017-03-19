//
//  SettingsTableViewController.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 13.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    private let settings = UserDefaults.standard
    
    @IBOutlet weak var synchronous: UISwitch!
    @IBAction func synchronousSwitch(_ sender: UISwitch) {
        self.settings.set(sender.isOn, forKey: "isSynchronous")
    }
    @IBOutlet weak var detect: UISwitch!
    @IBAction func detectSwitch(_ sender: UISwitch) {
        self.settings.set(sender.isOn, forKey: "isDetect")
    }
    @IBOutlet weak var showDictionary: UISwitch!
    @IBAction func showDictionarySwitch(_ sender: UISwitch) {
        self.settings.set(sender.isOn, forKey: "isShowDictionary")
    }
    @IBOutlet weak var useReturn: UISwitch!
    @IBAction func returnSwitch(_ sender: UISwitch) {
        self.settings.set(sender.isOn, forKey: "isUseReturn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.synchronous.isOn = self.settings.bool(forKey: "isSynchronous")
        self.detect.isOn = self.settings.bool(forKey: "isDetect")
        self.showDictionary.isOn = self.settings.bool(forKey: "isShowDictionary")
        self.useReturn.isOn = self.settings.bool(forKey: "isUseReturn")

        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 7.0))
        view.addBottomBorderWithColor(color: .lightGray, width: 0.3)
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 7.0))
        view.addTopBorderWithColor(color: .lightGray, width: 0.3)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 7
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.hidesBottomBarWhenPushed = true
        if let cell = sender as? UITableViewCell, let label = cell.contentView.subviews.first as? UILabel {
            segue.destination.title = label.text
        }
    }
}
