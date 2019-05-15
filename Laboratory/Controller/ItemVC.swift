//
//  ItemVC.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class ItemVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var itemTableView: UITableView!
    
    var isSearching = false
    var itemVMs = [LabItemEditVM]()
    var searchedItemVMs = [LabItemEditVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        let nib = UINib(nibName: "LabItemEditTVCell", bundle: nil)
        itemTableView.register(nib, forCellReuseIdentifier: "LabItemEditCell")
        
        loadItemData()
    }
    
    func loadItemData() {
        ItemSvc.fetchItemData() { [unowned self] (itemResult) in
            switch itemResult {
            case let .failure(error):
                print(error)
            case let .success(viewModels):
                self.itemVMs = viewModels
            }
            self.itemTableView.reloadData()
        }
    }
}

// MARK:  - Search Bar
extension ItemVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            itemTableView.reloadData()
            return
        }
        isSearching = true
        searchedItemVMs = itemVMs.filter({$0.itemName.lowercased().contains(searchText.lowercased())})
        itemTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        itemTableView.reloadData()
    }
}


// MARK: - Table View
extension ItemVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching == true ? searchedItemVMs.count : itemVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTableView.dequeueReusableCell(withIdentifier: "LabItemEditCell") as! LabItemEditTVCell
        if isSearching {
            cell.setup(viewModel: searchedItemVMs[indexPath.row])
        } else {
            cell.setup(viewModel: itemVMs[indexPath.row])
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
