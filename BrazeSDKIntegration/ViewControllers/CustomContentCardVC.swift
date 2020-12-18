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
          #selector(contentCardsUpdatedNotificationReceived),
          name:NSNotification.Name.ABKContentCardsProcessed, object: nil)
        tableView.register(ClassicCardCell.self, forCellReuseIdentifier: ClassicCardCell.description())
    }

    @objc private func contentCardsUpdatedNotificationReceived(notification: NSNotification) {
        guard let updateSuccessful = notification.userInfo?[ABKContentCardsProcessedIsSuccessfulKey] as? Bool else { return }
        if updateSuccessful {
            // Get an array containing only cards that have the "filtered" feed type set in their extras.
            if let filteredArray = getCards(forFeedType: "filtered") {
                contentCards = filteredArray
                tableView.reloadData()
//                NSLog("Got filtered array of length: %@",filteredArray.count)
            }

            // Pass filteredArray to your UI layer for display.
        }
    }

    func getCards(forFeedType type: String) -> [ABKContentCard]? {
        guard let allCards = Appboy.sharedInstance()?.contentCardsController.contentCards as? [ABKContentCard] else { return nil }
        // return filtered cards
        return allCards.filter {
            if $0.extras?["feed_type"] as? String == type {
                NSLog("%@","Got card: \($0.idString)")
                return true
            } else {
                return false
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
