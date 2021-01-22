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
    private let tableView: UITableView = UITableView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Profile"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.register(LoginCell.self, forCellReuseIdentifier: LoginCell.description())
        tableView.register(UserAnalyticsCell.self, forCellReuseIdentifier: UserAnalyticsCell.description())
        tableView.register(ContentCardDisplayCell.self, forCellReuseIdentifier: ContentCardDisplayCell.description())
        tableView.register(IAMCell.self, forCellReuseIdentifier: IAMCell.description())
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.subviews(tableView)
        tableView.left(0).right(0).top(0)
        tableView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
    
// Private functions
    @objc private func dismissMyKeyboard(){
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification:Notification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(_ notification:Notification) {
        tableView.contentInset = .zero
    }
}

extension LoginVC: UITableViewDataSource, TableviewCellAlertProtocol, ContentCardCellDelegate, UIScrollViewDelegate {
    func presentContentCardPressed(_ filtered: Bool, _ text: String?) {
        Appboy.sharedInstance()?.requestContentCardsRefresh()
        if !filtered {
            let contentCards = ABKContentCardsTableViewController()
            contentCards.title = "Content Cards Title"
            navigationController?.pushViewController(contentCards, animated: true)
        } else if let text = text {
            let contentCards = CustomContentCardVC(text)
            contentCards.title = "Filtered Content Cards for \(text)"
            navigationController?.pushViewController(contentCards, animated: true)
        }
    }
    
    func renderAlertViewController(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LoginCell.description()) as! LoginCell
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserAnalyticsCell.description()) as! UserAnalyticsCell
                cell.delegate = self
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ContentCardDisplayCell.description()) as! ContentCardDisplayCell
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: IAMCell.description()) as! IAMCell
                return cell
            }
        }()
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
