//
//  TableDataSource.swift
//  ContactsTest
//
//  Created by  Y.Terada on 2016/04/30.
//  Copyright © 2016年  Y.Terada. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import ContactsUI

class TableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var list :NSArray
    var parent :UIViewController

    init(parent :UIViewController, list :NSArray) {
        self.list = list
        self.parent = parent
    }
    
    func setDataList(arg :NSArray) -> Void {
        list = arg
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CellIt")!
        cell.backgroundColor = UIColor.blueColor()
        let cnt :CNContact = list.objectAtIndex(indexPath.row) as! CNContact
        cell.textLabel!.text = cnt.identifier
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let _item :CNContact = list.objectAtIndex(indexPath.row) as! CNContact
        if let item :CNContact = ContactContact.sharedInstance.getOneContat(_item.identifier, keys: [CNContactViewController.descriptorForRequiredKeys()]) {
            
            NSLog("%@", item.identifier)
            let cvc :CNContactViewController = CNContactViewController(forContact: item)
            let store = CNContactStore()
            cvc.contactStore = store
            cvc.displayedPropertyKeys = [CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey, CNContactNoteKey]
            cvc.delegate = ContactViewDelegate()
            parent.presentViewController(cvc,
                animated: false,
                completion: {() in
            })
        }
    }
}