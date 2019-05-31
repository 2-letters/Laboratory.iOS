//
//  LabCollectionViewCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/30/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabCollectionViewCell: UICollectionViewCell {

    static let reuseId = "LabCell"
    
    @IBOutlet var labNameLabel: UILabel!
    @IBOutlet var labDescriptionLabel: UILabel!
    
    var viewModel: LabVM? {
        didSet {
            labNameLabel.text = viewModel?.labName
            labDescriptionLabel.text = viewModel?.description
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
