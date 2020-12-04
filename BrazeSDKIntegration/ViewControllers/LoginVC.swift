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
    
    private let contentCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Content Cards", for: .normal)
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
        view.subviews([
                        loginButton,
                        contentCardButton,
                        logEventButton,
        ])
        layoutUI()
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        contentCardButton.addTarget(self, action: #selector(contentCardPressed), for: .touchUpInside)
        logEventButton.addTarget(self, action: #selector(logEventButtonPressed), for: .touchUpInside)
    }
    
    private func layoutUI() {
        loginButton.centerInContainer()
        contentCardButton.centerHorizontally()
        contentCardButton.Top == loginButton.Bottom + 10
        logEventButton.centerHorizontally()
        logEventButton.Top == contentCardButton.Bottom + 10
        changeUserButton.Bottom == loginButton.Top - 10
    }
    
    @objc private func loginPressed() {
        Appboy.sharedInstance()?.changeUser("YOUR_USER_ID")
    }
        
    @objc private func contentCardPressed() {
        Appboy.sharedInstance()?.requestContentCardsRefresh()
        let contentCards = ABKContentCardsTableViewController()
        contentCards.title = "Content Cards Title"
        contentCards.disableUnreadIndicator = true
        navigationController?.pushViewController(contentCards, animated: true)
    }
    
    @objc private func logEventButtonPressed() {
        Appboy.sharedInstance()?.logCustomEvent("Pressed Button")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
