//
//  LabCollectionViewCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/30/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabCollectionViewCell: UICollectionViewCell {

    static let nibId = "LabCollectionViewCell"
    static let reuseId = "LabCell"
    
    @IBOutlet var labNameLabel: UILabel!
    @IBOutlet var labDescriptionLabel: UILabel!
    
    var viewModel: LabVM? {
        didSet {
            labNameLabel.text = viewModel?.labName
            labDescriptionLabel.text = viewModel?.description
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowRadius = 2
            self.layer.shadowOpacity = 0.25
            self.clipsToBounds = false
            self.layer.masksToBounds = false
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
