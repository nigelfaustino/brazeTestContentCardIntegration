//
//  ClassicCardCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 12/4/20.
//

import UIKit
import AppboyUI
import Stevia

class ClassicCardCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
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
        subviews([
            titleLabel,
            bodyLabel
        ])
        titleLabel.centerHorizontally().top(10)
        bodyLabel.centerHorizontally()
        bodyLabel.Top == titleLabel.Bottom + 10
        bodyLabel.centerHorizontally().bottom(10)
    }

    func configure(_ card: ABKClassicContentCard) {
        titleLabel.text = card.title
        bodyLabel.text = card.cardDescription
    }

}
