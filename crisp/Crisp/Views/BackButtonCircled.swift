//
//  BackButtonCircled.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-07.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class BackButtonCircled: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}


