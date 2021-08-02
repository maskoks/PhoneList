//
//  ViewController.swift
//  PhoneList
//
//  Created by Жеребцов Данил on 22.07.2021.
//

import UIKit

class ViewController: UIViewController {
 
    var contacts:  [Contact] = []
    
    let tableView = UITableView()
    var alert = UIAlertController()
    let navigationBar: UINavigationBar = {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        navBar.backgroundColor = .white
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Контакты")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addButtonAction))
        navItem.rightBarButtonItem = addButton
        navBar.setItems([navItem], animated: false)

        return navBar
        
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        setTableView()
    
        contacts.append(Contact(name: "Жеребцов Данил", phoneNumber: "89841982626"))

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
    
    @objc func addButtonAction() {
        
        alert = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
               
        alert.addTextField { (nameTextField: UITextField) in
            nameTextField.placeholder = "Введите имя"
            nameTextField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
    
        alert.addTextField { (phoneTextField: UITextField) in
            phoneTextField.placeholder = "Введите номер телефона"
            phoneTextField.keyboardType = .phonePad
        }
               
        let createAlertAction = UIAlertAction(title: "Create", style: .default) { (addContact) in
            
            guard let unwrName = self.alert.textFields?[0].text, let unwrNumber = self.alert.textFields?[1].text else { return }
            self.contacts.append(Contact(name: unwrName, phoneNumber: unwrNumber))
            self.tableView.reloadData()
                   
        }
               
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(cancelAlertAction)
        alert.addAction(createAlertAction)
        present(alert, animated: true, completion: nil)
        createAlertAction.isEnabled = false
        
    }
    
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {

        guard let senderText = sender.text, alert.actions.indices.contains(1) else { return }
        let action = alert.actions[1]
        action.isEnabled = senderText.count > 0
        
    }


}

