//
//  ViewController.swift
//  ContactsTest
//
//  Created by  Y.Terada on 2016/04/29.
//  Copyright © 2016年  Y.Terada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tds :TableDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        tds = TableDataSource(parent: self, list:ContactContact.sharedInstance.getAllContacts())
        self.tableView.dataSource = tds
        self.tableView.delegate = tds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

