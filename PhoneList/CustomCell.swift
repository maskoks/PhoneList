//
//  CustomCell.swift
//  PhoneList
//
//  Created by Жеребцов Данил on 22.07.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let phoneNumberLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cellID")
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        phoneNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        phoneNumberLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        

        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: phoneNumberLabel.leadingAnchor, constant: 10).isActive = true
    
    }
    
}
