//
//  UserAnalyticsCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/15/21.
//

import UIKit
import Stevia
import AppboyUI

class UserAnalyticsCell: UITableViewCell {
    weak var delegate: TableviewCellAlertProtocol?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "User Analytics"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let eventTextfield: UITextField = {
        let textfield = UITextField()
        textfield.autocorrectionType = .no
        textfield.textAlignment = .center
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Custom Event"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let attributeKeyTextField: UITextField = {
        let textfield = UITextField()
        textfield.autocorrectionType = .no
        textfield.layer.borderWidth = 1
        textfield.autocorrectionType = .no
        textfield.textAlignment = .center
        textfield.placeholder = "Custom Attribute Key"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let attributeValueTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.autocorrectionType = .no
        textfield.textAlignment = .center
        textfield.placeholder = "Custom Attribute Value"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let logEventButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Log Event", for: .normal)
        return button
    }()

    private let logAttributeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Log Attribute", for: .normal)
        button.addTarget(self, action: #selector(logAttributeButtonPressed), for: .touchUpInside)
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
        backgroundColor = .white
        subviews([
            titleLabel,
            eventTextfield,
            attributeValueTextField,
            attributeKeyTextField,
            logEventButton,
            logAttributeButton
        ])
        titleLabel.top(10).centerHorizontally()
        eventTextfield.Top == titleLabel.Bottom + 10
        eventTextfield.left(10).right(10)
        logEventButton.Top == eventTextfield.Bottom + 10
        logEventButton.left(10).right(10)
        attributeKeyTextField.Top == logEventButton.Bottom + 10
        attributeKeyTextField.left(10).right(10)
        attributeValueTextField.Top == attributeKeyTextField.Bottom + 10
        attributeValueTextField.left(10).right(10)
        logAttributeButton.Top == attributeValueTextField.Bottom + 10
        logAttributeButton.left(10).right(10).bottom(10)
        logEventButton.addTarget(self, action: #selector(logEventButtonPressed), for: .touchUpInside)
    }
    
    @objc private func logAttributeButtonPressed() {
        guard let key = attributeKeyTextField.text, let value = attributeValueTextField.text else { return }
        Appboy.sharedInstance()?.user.setCustomAttributeWithKey(key, andStringValue: value)
        delegate?.renderAlertViewController("Set attribute", "Set custom attribute \(key) with value \(value)")
        attributeKeyTextField.text = ""
        attributeValueTextField.text = ""
    }

    @objc private func logEventButtonPressed() {
        guard let event = eventTextfield.text else { return }
        Appboy.sharedInstance()?.logCustomEvent(event)
        delegate?.renderAlertViewController("Logged Event", "Logged \(event)")
        eventTextfield.text = ""
    }
}
