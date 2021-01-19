//
//  TableviewCellAlertProtocol.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 1/15/21.
//

import UIKit

protocol TableviewCellAlertProtocol: class {
    func renderAlertViewController(_ title: String, _ message: String)
}
