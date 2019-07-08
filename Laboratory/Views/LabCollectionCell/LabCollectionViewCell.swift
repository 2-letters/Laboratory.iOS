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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.white
        
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.25
        clipsToBounds = false
        layer.masksToBounds = false
        
        labNameLabel.font = UIFont(name: primaryFont, size: 17)
        labDescriptionLabel.font = UIFont(name: secondaryFont, size: 15)
        labDescriptionLabel.textColor = UIColor.lightGray 
    }
    
    var viewModel: LabCellVM! {
        didSet {
            labNameLabel.text = viewModel.labName
            labDescriptionLabel.text = viewModel.description     
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
