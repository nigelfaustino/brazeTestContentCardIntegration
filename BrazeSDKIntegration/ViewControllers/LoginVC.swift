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
    
    private let textfield: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Change user ID"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()
    
    private let contentCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Content Cards", for: .normal)
        return button
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.subviews(
            [
                textfield,
                loginButton,
                contentCardButton,
                logEventButton,
                customContentCardButton
            ]
        )
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        layoutUI()
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        contentCardButton.addTarget(self, action: #selector(contentCardPressed), for: .touchUpInside)
        logEventButton.addTarget(self, action: #selector(logEventButtonPressed), for: .touchUpInside)
        customContentCardButton.addTarget(self, action: #selector(customContentCardPressed), for: .touchUpInside)
    }
    
    private func layoutUI() {
        textfield.centerHorizontally().left(10).right(10)
        textfield.Bottom == loginButton.Top - 10
        loginButton.centerInContainer()
        contentCardButton.centerHorizontally()
        contentCardButton.Top == loginButton.Bottom + 10
        customContentCardButton.Top == contentCardButton.Bottom + 10
        customContentCardButton.centerHorizontally()
        logEventButton.centerHorizontally()
        logEventButton.Top == customContentCardButton.Bottom + 10
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginPressed() {
        var userID = "YOUR_USER_ID"
        if let text = textfield.text, !text.isEmpty {
            userID = text
            textfield.text = ""
        }
        Appboy.sharedInstance()?.changeUser(userID)
        let count = Appboy.sharedInstance()?.contentCardsController.unviewedContentCardCount() ?? 0
        print(count)
        let alert = UIAlertController(title: "Changed User", message: "\(String(describing: Appboy.sharedInstance()?.user.userID))", preferredStyle: .actionSheet)
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
        Appboy.sharedInstance()?.requestContentCardsRefresh()
        let contentCards = CustomContentCardVC()
        contentCards.title = "Filtered Content Cards"
        navigationController?.pushViewController(contentCards, animated: true)
    }
    
    @objc private func logEventButtonPressed() {
        Appboy.sharedInstance()?.logCustomEvent("Pressed Button")
        Appboy.sharedInstance()?.user.addAlias("testAlias", withLabel: "test")
    }
}
