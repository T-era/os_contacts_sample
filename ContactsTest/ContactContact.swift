//
//  ContactContact.swift
//  ContactsTest
//
//  Created by  Y.Terada on 2016/04/30.
//  Copyright © 2016年  Y.Terada. All rights reserved.
//

import Foundation
import AddressBook
import Contacts
import ContactsUI

class ContactContact {
    static let sharedInstance = ContactContact()
    let store = CNContactStore()
    var abailable :Bool

    private init() {
        abailable = false
        inIos8()
    }
    private func inIos9() {
        let status = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        switch (status) {
        case CNAuthorizationStatus.NotDetermined, CNAuthorizationStatus.Restricted:
                let store = CNContactStore()
                store.requestAccessForEntityType(CNEntityType.Contacts
                    , completionHandler: { (allowed :Bool, error :NSError?) -> Void in
                        if (allowed) {
                            self.abailable = true// 利用可能
                        } else {
                            // 失敗（拒否された）
                        }
                })
            break;
        case CNAuthorizationStatus.Denied:
            break;
        case CNAuthorizationStatus.Authorized:
            self.abailable = true
            break;
        }
    }
    private func inIos8() {
        let status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
        case ABAuthorizationStatus.NotDetermined, ABAuthorizationStatus.Restricted:
            NSLog("Not determined or restricted.");
            let addressBook = ABAddressBookCreateWithOptions(nil, nil)
            ABAddressBookRequestAccessWithCompletion(addressBook.takeRetainedValue(),
                { (granted :Bool, error: CFError!) -> Void in
                if (granted) {
                    self.abailable = true
                }
            });
            break;
        case ABAuthorizationStatus.Denied:
            break;
        case ABAuthorizationStatus.Authorized:
            self.abailable = true
            break;
        default:
            break;
        }
    }
    
    func getAllContacts() -> NSArray {
        if self.abailable {
            let req = CNContactFetchRequest(keysToFetch: [CNContactFamilyNameKey])
            do {
                let list = NSMutableArray()
                try store.enumerateContactsWithFetchRequest(req,
                    usingBlock: { (contact :CNContact, flg :UnsafeMutablePointer<ObjCBool>) -> Void in
                        list.addObject(contact);
                })
                return list
            } catch {
                return []
            }
        }else {
            return []
        }
    }
    func getOneContat(forIdentifier :String, keys: [CNKeyDescriptor]) -> CNContact? {
        do {
            return try store.unifiedContactWithIdentifier(forIdentifier, keysToFetch: keys)
        } catch {
            return nil;
        }
    }
}