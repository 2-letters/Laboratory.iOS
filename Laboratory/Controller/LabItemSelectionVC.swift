//
//  LabItemVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabItemSelectionVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var labItemTV: UITableView!
    
    var labItemVMs = [LabItemSelectionVM]()
    var searchedLabItemVMs = [LabItemSelectionVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        labItemTV.delegate = self
        labItemTV.dataSource = self
        
        let nib = UINib(nibName: "LabItemSelectTVCell", bundle: nil)
        labItemTV.register(nib, forCellReuseIdentifier: "LabItemSelectionCell")
        
        loadLabItemData()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAddingItems))
        self.navigationItem.rightBarButtonItem = doneBtn
    }
    
    @objc func doneAddingItems() {
        
    }
}


// MARK: - Table View
extension LabItemSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedLabItemVMs.count
        }
        return labItemVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = Bundle.main.loadNibNamed("LabItemTVCell", owner: self, options: nil)?.first as! LabItemTVCell
        let cell = labItemTV.dequeueReusableCell(withIdentifier: "LabItemSelectionCell") as! LabItemSelectionTVCell
        if isSearching {
            cell.labItemSelectionVM = searchedLabItemVMs[indexPath.row]
        } else {
            cell.labItemSelectionVM = labItemVMs[indexPath.row]
        }
        return cell
    }
}

// MARK: - Search bar
extension LabItemSelectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            labItemTV.reloadData()
            return
        }
        isSearching = true
        searchedLabItemVMs = labItemVMs.filter({$0.itemName.lowercased().contains(searchText.lowercased())})
        labItemTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        labItemTV.reloadData()
    }
}


// MARK: - Additional Helpers
extension LabItemSelectionVC {
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
