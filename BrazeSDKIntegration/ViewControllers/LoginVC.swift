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
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let idTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Change user ID"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let eventTextfield: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Custom Event"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let contentCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Content Cards", for: .normal)
        return button
    }()
    
    private let filterTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Content Card Filter"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()
    
    private let customContentCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Customized Content Cards", for: .normal)
        return button
    }()
    
    private let logEventButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Log Event", for: .normal)
        return button
    }()
    
    private let userAliasTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "User Alias"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()
    
    private let userAliasLabelTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.subviews(
            [
                idTextField,
                loginButton,
                contentCardButton,
                eventTextfield,
                logEventButton,
                filterTextField,
                customContentCardButton,
                addUserAliasButton,
                userAliasTextField,
                userAliasLabelTextField
            ]
        )
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        layoutUI()
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        contentCardButton.addTarget(self, action: #selector(contentCardPressed), for: .touchUpInside)
        logEventButton.addTarget(self, action: #selector(logEventButtonPressed), for: .touchUpInside)
        customContentCardButton.addTarget(self, action: #selector(customContentCardPressed), for: .touchUpInside)
        addUserAliasButton.addTarget(self, action: #selector(addAliasButtonPressed), for: .touchUpInside)
    }
    
//PRIVATE
    
    private func layoutUI() {
        idTextField.centerHorizontally().left(10).right(10)
        idTextField.Top == view.safeAreaLayoutGuide.Top + 10
        loginButton.Top == idTextField.Bottom + 10
        loginButton.centerHorizontally().left(10).right(10)
        contentCardButton.centerHorizontally().left(10).right(10)
        contentCardButton.Top == loginButton.Bottom + 10
        filterTextField.Top == contentCardButton.Bottom + 10
        filterTextField.centerHorizontally().left(10).right(10)
        customContentCardButton.Top == filterTextField.Bottom + 10
        customContentCardButton.centerHorizontally().left(10).right(10)
        eventTextfield.centerHorizontally().left(10).right(10)
        eventTextfield.Top == customContentCardButton.Bottom + 10
        logEventButton.centerHorizontally().left(10).right(10)
        logEventButton.Top == eventTextfield.Bottom + 10
        userAliasTextField.Top == logEventButton.Bottom + 10
        userAliasTextField.left(10).right(10)
        userAliasLabelTextField.Top == userAliasTextField.Bottom + 10
        userAliasLabelTextField.left(10).right(10)
        addUserAliasButton.Top == userAliasLabelTextField.Bottom + 10
        addUserAliasButton.centerHorizontally().left(10).right(10)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
        let alert = UIAlertController(title: "Changed User", message: "ID changed to \(Appboy.sharedInstance()?.user.userID ?? "No external id")", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        present(alert, animated: true, completion: nil)
    }
        
    @objc private func contentCardPressed() {
        Appboy.sharedInstance()?.requestContentCardsRefresh()
        let contentCards = ABKContentCardsTableViewController()
        contentCards.title = "Content Cards Title"
        contentCards.disableUnreadIndicator = true
        navigationController?.pushViewController(contentCards, animated: true)
    }
    
    @objc private func customContentCardPressed() {
        guard let filtered = filterTextField.text else {
            return
        }
        Appboy.sharedInstance()?.requestContentCardsRefresh()
        let contentCards = CustomContentCardVC(filtered)
        contentCards.title = "Filtered Content Cards"
        navigationController?.pushViewController(contentCards, animated: true)
    }
    
    @objc private func logEventButtonPressed() {
        guard let event = eventTextfield.text else { return }
        Appboy.sharedInstance()?.logCustomEvent(event)
        let alert = UIAlertController(title: "Logged Event", message: "Logged \(event)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        present(alert, animated: true, completion: nil)
        eventTextfield.text = ""
    }
    
    @objc private func addAliasButtonPressed() {
        guard let text = userAliasTextField.text else { return }
        Appboy.sharedInstance()?.user.addAlias(text, withLabel: userAliasLabelTextField.text ?? "")
        let alert = UIAlertController(title: "Added User Alias", message: "Added \(text) as alias with label \(userAliasLabelTextField.text ?? "")", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        present(alert, animated: true, completion: nil)
        userAliasTextField.text = ""
        userAliasLabelTextField.text = ""
    }
}
