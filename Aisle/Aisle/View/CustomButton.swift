//
//  CustomButton.swift
//  Aisle
//
//  Created by Gokul A S on 22/09/22.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.clipsToBounds = true
        self.layer.backgroundColor = UIColor(red: 249.0/255.0, green: 203.0/255.0, blue: 16.0/255.0, alpha: 1.0).cgColor
    }
}
