//
//  NumberTextField.swift
//  Aisle
//
//  Created by Gokul A S on 22/09/22.
//

import UIKit

class NumberTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        
    }
}
