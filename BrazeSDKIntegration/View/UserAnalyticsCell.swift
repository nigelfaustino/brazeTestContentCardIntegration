//
//  UserAnalyticsCell.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/15/21.
//

import UIKit

class UserAnalyticsCell: UITableViewCell {
    private let eventTextfield: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Custom Event"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let attributeKeyTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Custom Attribute Key"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()

    private let attributeValueTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
        textfield.placeholder = "Custom Attribute Value"
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
