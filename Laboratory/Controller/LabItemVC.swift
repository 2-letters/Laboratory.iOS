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

        labItemSearchBar.delegate = self
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
        return cell
    }
}

// MARK: - Search bar
extension LabItemVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchedLabItemVMs = labItemVMs.filter({$0.itemName.lowercased().contains(searchText.lowercased())})
        labItemTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        labItemSearchBar.text = ""
        labItemTV.reloadData()
    }
}


// MARK: - Additional Helpers
extension LabItemVC {
    func loadLabItemData() {
        LabSvc.fetchLabItem() { [unowned self] (LabItemResult) in
            switch LabItemResult {
            case let .success(viewModels):
                self.labItemVMs = viewModels
            // TODO: save to cache
            case let .failure(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.labItemTV.reloadData()
            }
        }
    }
}
