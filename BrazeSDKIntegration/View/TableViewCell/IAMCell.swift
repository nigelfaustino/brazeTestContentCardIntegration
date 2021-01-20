//
//  IAMCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/19/21.
//

import UIKit
import Stevia
import AppboyKit

class IAMCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "In-App Messages"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let triggerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Test IAM", for: .normal)
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
        subviews([
            titleLabel,
            triggerButton
        ])
        titleLabel.top(10).centerHorizontally()
        triggerButton.Top == titleLabel.Bottom + 10
        triggerButton.left(10).right(10).bottom(10)
        triggerButton.addTarget(self, action: #selector(triggerButtonPressed), for: .touchUpInside)
    }
    
    @objc private func triggerButtonPressed() {
        Appboy.sharedInstance()?.logCustomEvent("Pressed Button")
    }
}
