//
//  ViewController + TableView.swift
//  PhoneList
//
//  Created by Жеребцов Данил on 02.08.2021.
//

import Foundation
import  UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CustomCell
        cell.nameLabel.text = contactList[indexPath.row].name
        cell.phoneNumberLabel.text = contactList[indexPath.row].phoneNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: "tel://0123456789") else { return }
        let app: UIApplication = UIApplication.shared
        if app.canOpenURL(url) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            print("failed")
        }
    }
}
