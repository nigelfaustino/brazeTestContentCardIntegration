//
//  LoginCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/15/21.
//

import UIKit
import Stevia
import AppboyUI

class LoginCell: UITableViewCell {
    weak var delegate: TableviewCellAlertProtocol?
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
    
    private let idTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Change User ID"
        return textfield
    }()
    
    private let userAliasTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "User Alias"
        return textfield
    }()

    private let userAliasLabelTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "User Alias Label"
        return textfield
    }()

    private let addUserAliasButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Add Alias", for: .normal)
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
        layoutViews()
        backgroundColor = .white
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        addUserAliasButton.addTarget(self, action: #selector(addAliasButtonPressed), for: .touchUpInside)
    }
    
    private func layoutViews() {
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
    
    @objc private func loginPressed() {
        var userID = "YOUR_USER_ID"
        if let text = idTextField.text, !text.isEmpty {
            userID = text
            idTextField.text = ""
        }
        Appboy.sharedInstance()?.changeUser(userID)
        let count = Appboy.sharedInstance()?.contentCardsController.unviewedContentCardCount() ?? 0
        print(count)
        delegate?.renderAlertViewController("Changed User", "ID changed to \(Appboy.sharedInstance()?.user.userID ?? "No external id")")
    }
    
    @objc private func addAliasButtonPressed() {
        guard let text = userAliasTextField.text else { return }
        Appboy.sharedInstance()?.user.addAlias(text, withLabel: userAliasLabelTextField.text ?? "")
        delegate?.renderAlertViewController("Added User Alias", "Added \(text) as alias with label \(userAliasLabelTextField.text ?? "")")
        userAliasTextField.text = ""
        userAliasLabelTextField.text = ""
    }
}
