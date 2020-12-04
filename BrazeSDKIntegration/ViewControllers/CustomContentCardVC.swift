//
//  CustomContentCardVC.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 12/4/20.
//

import Foundation
import AppboyUI

class CustomContentCardVC: UITableViewController {
    
    private var contentCards: [ABKContentCard] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Appboy.sharedInstance()?.requestContentCardsRefresh()
        NotificationCenter.default.addObserver(self, selector:
          #selector(contentCardsUpdated),
          name:NSNotification.Name.ABKContentCardsProcessed, object: nil)
        tableView.register(ClassicCardCell.self, forCellReuseIdentifier: ClassicCardCell.description())
    }

    @objc private func contentCardsUpdated(_ notification: Notification) {
      if let updateIsSuccessful = notification.userInfo?[ABKContentCardsProcessedIsSuccessfulKey] as? Bool {
        if (updateIsSuccessful) {
            if let cards = Appboy.sharedInstance()?.contentCardsController.contentCards as? [ABKContentCard] {
                contentCards = cards
                self.tableView.reloadData()
            }
        }
      }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentCards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = contentCards[indexPath.row]
        let cell: UITableViewCell = {
            if let card = card as? ABKClassicContentCard {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassicCardCell.description()) as! ClassicCardCell
                cell.configure(card)
                return cell
            }
            return UITableViewCell()
        }()
        card.logContentCardImpression()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = contentCards[indexPath.row]
        card.logContentCardClicked()
    }
}
