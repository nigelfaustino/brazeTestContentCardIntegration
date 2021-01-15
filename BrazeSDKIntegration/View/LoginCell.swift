//
//  LoginCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/15/21.
//

import UIKit
import Stevia

class LoginCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "User Identifiers"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let idTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.textAlignment = .center
        textfield.placeholder = "Change user ID"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()
    
    private let userAliasTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.textAlignment = .center
        textfield.placeholder = "User Alias"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let userAliasLabelTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.textAlignment = .center
        textfield.placeholder = "User Alias Label"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let addUserAliasButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Add alias", for: .normal)
        return button
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        subviews([
            titleLabel,
            loginButton,
            idTextField,
            userAliasTextField,
            userAliasLabelTextField,
            addUserAliasButton
        ])
        titleLabel.top(10).centerHorizontally()
        idTextField.Top == titleLabel.Bottom + 10
        idTextField.centerHorizontally().left(10).right(10)
        loginButton.centerHorizontally().left(10).right(10)
        loginButton.Top == idTextField.Bottom + 10
        userAliasTextField.Top == loginButton.Bottom + 10
        userAliasTextField.left(10).right(10)
        userAliasLabelTextField.Top == userAliasTextField.Bottom + 10
        userAliasLabelTextField.left(10).right(10)
        addUserAliasButton.Top == userAliasLabelTextField.Bottom + 10
        addUserAliasButton.centerHorizontally().left(10).right(10).bottom(10)

    }
}
