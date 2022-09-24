//
//  NotesCollectionViewCell.swift
//  Aisle
//
//  Created by Gokul A S on 24/09/22.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesImageView: UIImageView!
    
    override func awakeFromNib() {
        self.likesImageView.layer.cornerRadius = 10.0
        self.likesImageView.layer.masksToBounds = true
    }

}
