//
//  TextField.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-07.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class TextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.2766578496, green: 0.3584927022, blue: 0.412160933, alpha: 1)
        clipsToBounds = true
    }

}
