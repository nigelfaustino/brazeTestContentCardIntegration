//
//  ContentCardCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/19/21.
//

import UIKit
import Stevia
import AppboyUI

protocol ContentCardCellDelegate: class {
    func presentContentCardPressed(_ filtered: Bool, _ text: String?)
}

class ContentCardDisplayCell: UITableViewCell {
    weak var delegate: ContentCardCellDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Content Cards"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let contentCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Content Cards", for: .normal)
        return button
    }()

    private let filterTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Content Card Filter"
        return textfield
    }()

    private let customContentCardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Filtered Content Cards", for: .normal)
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
            contentCardButton,
            filterTextField,
            customContentCardButton
        ])
        titleLabel.top(10).centerHorizontally()
        contentCardButton.Top == titleLabel.Bottom + 10
        contentCardButton.left(10).right(10)
        filterTextField.Top == contentCardButton.Bottom + 10
        filterTextField.centerHorizontally().left(10).right(10)
        customContentCardButton.Top == filterTextField.Bottom + 10
        customContentCardButton.left(10).right(10).bottom(10)
        contentCardButton.addTarget(self, action: #selector(contentCardPressed), for: .touchUpInside)
        customContentCardButton.addTarget(self, action: #selector(customContentCardPressed), for: .touchUpInside)

    }
    
    @objc private func contentCardPressed() {
        delegate?.presentContentCardPressed(false, nil)
    }

    @objc private func customContentCardPressed() {
        guard let filtered = filterTextField.text else {
            return
        }
        delegate?.presentContentCardPressed(true, filtered)
    }

}
