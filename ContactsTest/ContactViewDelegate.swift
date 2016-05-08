//
//  ContactViewDelegate.swift
//  ContactsTest
//
//  Created by  Y.Terada on 2016/05/02.
//  Copyright © 2016年  Y.Terada. All rights reserved.
//

import Foundation
import ContactsUI

class ContactViewDelegate :NSObject, CNContactViewControllerDelegate {
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        NSLog("??")
    }
    func contactViewController(viewController: CNContactViewController, shouldPerformDefaultActionForContactProperty property: CNContactProperty) -> Bool {
        return true
    }
}
