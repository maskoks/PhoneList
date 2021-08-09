//
//  ViewController.swift
//  PhoneList
//
//  Created by Жеребцов Данил on 22.07.2021.
//

import UIKit
import Contacts

class ViewController: UIViewController {
 
    var contactList:  [Contact] = []
    
    let store = CNContactStore()
    
    let tableView = UITableView()
    var alert = UIAlertController()
    let navigationBar: UINavigationBar = {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        navBar.backgroundColor = .white
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Контакты")
        navBar.setItems([navItem], animated: false)

        return navBar
        
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        setTableView()
    
        
        let authorize = CNContactStore.authorizationStatus(for: .contacts)
        if authorize == .notDetermined {
            store.requestAccess(for: .contacts) { (granted, error) in
                if error == nil {
                    self.getContacts()
                }
            }
        } else if authorize == .authorized {
            self.getContacts()
        }
    }
    
    func getContacts() {
        
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
        let contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: [CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
        for contact in contacts {
            var contactPhoneNumber = ""
            for phoneNumber in contact.phoneNumbers {
                contactPhoneNumber = phoneNumber.value.stringValue
            }
            contactList.append(Contact(name: contact.givenName + " " + contact.familyName, phoneNumber: contactPhoneNumber))
        }
    }
    
    override func viewWillLayoutSubviews() {
        setConstraints()
    }
    
    func setTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cellID")
        
        tableView.delaysContentTouches = true
        
    }
    
    func setConstraints() {
        
        let guide = view.safeAreaLayoutGuide
        
        navigationBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
    }
}

