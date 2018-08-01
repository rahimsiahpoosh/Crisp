//
//  ButtonRadius.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-07.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class ButtonRadius: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        clipsToBounds = true
    }
}
