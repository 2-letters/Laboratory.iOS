//
//  LabItemVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabItemVC: UIViewController {

    @IBOutlet var labItemSearchBar: UISearchBar!
    @IBOutlet var labItemTV: UITableView!
    
    var labItemVMs = [LabItemVM]()
    var searchedLabItemVMs = [LabItemVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labItemTV.delegate = self
        labItemTV.dataSource = self
        
        loadLabItemData()
    }
}


// MARK: - Table View
extension LabItemVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedLabItemVMs.count
        }
        return labItemVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LabItemTVCell", owner: self, options: nil)?.first as! LabItemTVCell
        if isSearching {
            cell.labItemVM = searchedLabItemVMs[indexPath.row]
        } else {
            cell.labItemVM = labItemVMs[indexPath.row]
        }
    }
}


// MARK: - Additional Helpers
extension LabItemVC {
    func loadLabItemData() {
    
    }
}
