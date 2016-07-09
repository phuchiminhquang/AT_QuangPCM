//
//  RootController.swift
//  Bai 7
//
//  Created by Quang Phu on 7/9/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class RootController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet & IBAction
    @IBOutlet weak var contactsTableView: UITableView!
    
    // MARK: Property
    private let cellIdentifier = "ContactCell"
    private var contactStore = CNContactStore()
    private var contacts = [ContactEntry]()
    var indexOfChars = [String]()
    
    // MARK: Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        
        self.contactsTableView.dataSource = self
        self.contactsTableView.delegate = self
        
        let nib = UINib(nibName: "ContactCell", bundle: nil)
        self.contactsTableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        self.contactsTableView.rowHeight = 60
        
        self.indexOfChars = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "S", "R", "T", "X", "Y", "Z"]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        requestAccessToContacts { (success) in
            if success {
                self.retrieveContacts({ (success, contacts) in
                    self.contactsTableView.hidden = !success
                    //self.noContactsLabel.hidden = success
                    if success && contacts?.count > 0 {
                        self.contacts = contacts!
                        self.contactsTableView.reloadData()
                    } else {
                    }
                })
            }
        }
    }
    
    func requestAccessToContacts(completion: (success: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized: completion(success: true) // authorized previously
        case .Denied, .NotDetermined: // needs to ask for authorization
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (accessGranted, error) -> Void in
                completion(success: accessGranted)
            })
        default: // not authorized.
            completion(success: false)
        }
    }

    func retrieveContacts(completion: (success: Bool, contacts: [ContactEntry]?) -> Void) {
        var contacts = [ContactEntry]()
        do {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactImageDataAvailableKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey])
            try contactStore.enumerateContactsWithFetchRequest(contactsFetchRequest, usingBlock: { (cnContact, error) in
                if let contact = ContactEntry(cnContact: cnContact) { contacts.append(contact) }
            })
            completion(success: true, contacts: contacts)
        } catch {
            completion(success: false, contacts: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MAKR: Delegate for Tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.indexOfChars.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.indexOfChars[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        let temp = indexOfChars as NSArray
        return self.indexOfChars.indexOf(title) ?? 1
    }

    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.indexOfChars
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        print("heightForRowAtIndexPath: \(indexPath.row)")
//        return 60
//    }
//    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        print("estimatedHeightForRowAtIndexPath: \(indexPath.row)")
//        return 60
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! ContactCell
        let entry = contacts[indexPath.row]
        cell.configWithContactEntry(entry)
        return cell
    }
    
    
    
    
    // MARK: private function
    
    
}
