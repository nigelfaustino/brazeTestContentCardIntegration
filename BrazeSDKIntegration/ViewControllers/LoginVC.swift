//
//  LoginVC.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 11/30/20.
//

import UIKit
import Stevia
import AppboyUI

class LoginVC: UIViewController {
//    private let loginButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .blue
//        button.setTitle("Login", for: .normal)
//        return button
//    }()
//
//    private let idTextField: UITextField = {
//        let textfield = UITextField()
//        textfield.layer.borderWidth = 1
//        textfield.placeholder = "Change user ID"
//        textfield.layer.borderColor = UIColor.black.cgColor
//        return textfield
//    }()
//
//    private let eventTextfield: UITextField = {
//        let textfield = UITextField()
//        textfield.layer.borderWidth = 1
//        textfield.placeholder = "Custom Event"
//        textfield.layer.borderColor = UIColor.black.cgColor
//        return textfield
//    }()
//
//    private let attributeKeyTextField: UITextField = {
//        let textfield = UITextField()
//        textfield.layer.borderWidth = 1
//        textfield.placeholder = "Custom Attribute Key"
//        textfield.layer.borderColor = UIColor.black.cgColor
//        return textfield
//    }()
//
//    private let attributeValueTextField: UITextField = {
//        let textfield = UITextField()
//        textfield.layer.borderWidth = 1
//        textfield.placeholder = "Custom Attribute Value"
//        textfield.layer.borderColor = UIColor.black.cgColor
//        return textfield
//    }()
//
//    private let contentCardButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .red
//        button.setTitle("Content Cards", for: .normal)
//        return button
//    }()
//
//    private let filterTextField: UITextField = {
//        let textfield = UITextField()
//        textfield.layer.borderWidth = 1
//        textfield.placeholder = "Content Card Filter"
//        textfield.layer.borderColor = UIColor.black.cgColor
//        return textfield
//    }()
//
//    private let customContentCardButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .gray
//        button.setTitle("Customized Content Cards", for: .normal)
//        return button
//    }()
//
//    private let logEventButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .green
//        button.setTitle("Log Event", for: .normal)
//        return button
//    }()
//
//    private let logAttributeButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .black
//        button.setTitle("Log Attribute", for: .normal)
//        return button
//    }()
//
    
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.register(LoginCell.self, forCellReuseIdentifier: LoginCell.description())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.subviews(tableView)
        tableView.left(0).right(0).top(0).bottom(0)
        
//        view.subviews(
//            [
//                idTextField,
//                loginButton,
//                contentCardButton,
//                eventTextfield,
//                logEventButton,
//                filterTextField,
//                customContentCardButton,
//                addUserAliasButton,
//                userAliasTextField,
//                userAliasLabelTextField,
//                logAttributeButton,
//                attributeKeyTextField,
//                attributeValueTextField
//            ]
//        )
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
//        layoutUI()
//        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
//        contentCardButton.addTarget(self, action: #selector(contentCardPressed), for: .touchUpInside)
//        logEventButton.addTarget(self, action: #selector(logEventButtonPressed), for: .touchUpInside)
//        customContentCardButton.addTarget(self, action: #selector(customContentCardPressed), for: .touchUpInside)
//        addUserAliasButton.addTarget(self, action: #selector(addAliasButtonPressed), for: .touchUpInside)
//        logAttributeButton.addTarget(self, action: #selector(logAttributeButtonPressed), for: .touchUpInside)
    }
    
//PRIVATE
    
//    private func layoutUI() {
//        idTextField.centerHorizontally().left(10).right(10)
//        idTextField.Top == view.safeAreaLayoutGuide.Top + 10
//        loginButton.Top == idTextField.Bottom + 10
//        loginButton.centerHorizontally().left(10).right(10)
//        contentCardButton.centerHorizontally().left(10).right(10)
//        contentCardButton.Top == loginButton.Bottom + 10
//        filterTextField.Top == contentCardButton.Bottom + 10
//        filterTextField.centerHorizontally().left(10).right(10)
//        customContentCardButton.Top == filterTextField.Bottom + 10
//        customContentCardButton.centerHorizontally().left(10).right(10)
//        attributeKeyTextField.Top == customContentCardButton.Bottom + 10
//        attributeKeyTextField.left(10).right(10)
//        attributeValueTextField.Top == attributeKeyTextField.Bottom + 10
//        attributeValueTextField.left(10).right(10)
//        logAttributeButton.Top == attributeValueTextField.Bottom + 10
//        logAttributeButton.left(10).right(10)
//        eventTextfield.centerHorizontally().left(10).right(10)
//        eventTextfield.Top == logAttributeButton.Bottom + 10
//        logEventButton.centerHorizontally().left(10).right(10)
//        logEventButton.Top == eventTextfield.Bottom + 10
//        userAliasTextField.Top == logEventButton.Bottom + 10
//        userAliasTextField.left(10).right(10)
//        userAliasLabelTextField.Top == userAliasTextField.Bottom + 10
//        userAliasLabelTextField.left(10).right(10)
//        addUserAliasButton.Top == userAliasLabelTextField.Bottom + 10
//        addUserAliasButton.centerHorizontally().left(10).right(10)
//    }
//
//    @objc private func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
//    @objc private func loginPressed() {
//        var userID = "YOUR_USER_ID"
//        if let text = idTextField.text, !text.isEmpty {
//            userID = text
//            idTextField.text = ""
//        }
//        Appboy.sharedInstance()?.changeUser(userID)
//        let count = Appboy.sharedInstance()?.contentCardsController.unviewedContentCardCount() ?? 0
//        print(count)
//        let alert = UIAlertController(title: "Changed User", message: "ID changed to \(Appboy.sharedInstance()?.user.userID ?? "No external id")", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//
//    @objc private func contentCardPressed() {
//        Appboy.sharedInstance()?.requestContentCardsRefresh()
//        let contentCards = ABKContentCardsTableViewController()
//        contentCards.title = "Content Cards Title"
//        contentCards.disableUnreadIndicator = true
//        navigationController?.pushViewController(contentCards, animated: true)
//    }
//
//    @objc private func customContentCardPressed() {
//        guard let filtered = filterTextField.text else {
//            return
//        }
//        Appboy.sharedInstance()?.requestContentCardsRefresh()
//        let contentCards = CustomContentCardVC(filtered)
//        contentCards.title = "Filtered Content Cards"
//        navigationController?.pushViewController(contentCards, animated: true)
//    }
//
//    @objc private func logAttributeButtonPressed() {
//        guard let key = attributeKeyTextField.text, let value = attributeValueTextField.text else { return }
//        Appboy.sharedInstance()?.user.setCustomAttributeWithKey(key, andStringValue: value)
//        let alert = UIAlertController(title: "Set attribute", message: "Set custom attribute \(key) with value \(value)", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
//        present(alert, animated: true, completion: nil)
//        attributeKeyTextField.text = ""
//        attributeValueTextField.text = ""
//    }
//
//    @objc private func logEventButtonPressed() {
//        guard let event = eventTextfield.text else { return }
//        Appboy.sharedInstance()?.logCustomEvent(event)
//        let alert = UIAlertController(title: "Logged Event", message: "Logged \(event)", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
//        present(alert, animated: true, completion: nil)
//        eventTextfield.text = ""
//    }
//
//    @objc private func addAliasButtonPressed() {
//        guard let text = userAliasTextField.text else { return }
//        Appboy.sharedInstance()?.user.addAlias(text, withLabel: userAliasLabelTextField.text ?? "")
//        let alert = UIAlertController(title: "Added User Alias", message: "Added \(text) as alias with label \(userAliasLabelTextField.text ?? "")", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
//        present(alert, animated: true, completion: nil)
//        userAliasTextField.text = ""
//        userAliasLabelTextField.text = ""
//    }
}

extension LoginVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LoginCell.description()) as! LoginCell
        return cell
    }
    
    
}
