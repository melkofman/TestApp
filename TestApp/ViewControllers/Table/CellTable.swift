//
//  CellTable.swift
//  TestApp
//
//  Created by Melanie Kofman on 29.08.2022.
//

import Foundation
import UIKit
class CellTable: UITableViewCell {
    static let id = "CellTable"
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return button
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        addSubview(button)
        addSubview(label)
        backgroundColor = .white
        button.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        button.widthAnchor.constraint(equalToConstant: 76).isActive = true
        button.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func checkBoxTapped() {
        
    }
    
    func configure(with data: String) {
        label.text = data
    }
}
