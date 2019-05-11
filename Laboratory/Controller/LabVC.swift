//
//  LabViewController.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabVC: UIViewController {

    
    @IBOutlet var labSearchBar: UISearchBar!
    @IBOutlet var labTV: UITableView!
    
    var labVMs = [LabVM]()
    var searchedLabVMs = [LabVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labTV.delegate = self
        labTV.dataSource = self
        labSearchBar.delegate = self
        
        loadLabData()
    }
}

// MARK: - Table View
extension LabVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedLabVMs.count
        }
        return labVMs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LabTVCell", owner: self, options: nil)?.first as! LabTVCell
        if isSearching {
            cell.labVM = searchedLabVMs[indexPath.row]
        } else {
            cell.labVM = labVMs[indexPath.row]
        }
        
        return cell
    }
}

// MARK: - Search bar
extension LabVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            labTV.reloadData()
        }
        isSearching = true
        searchedLabVMs = labVMs.filter({$0.labName.lowercased()
                .prefix(searchText.count) == searchText.lowercased()})
        labTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        labTV.reloadData()
    }
}

// MARK: - Additional helpers
extension LabVC {
    func loadLabData() {
        LabSvc.fetchLabData() { [unowned self] (LabResult) in
            switch LabResult {
            case let .success(viewModels):
                self.labVMs = viewModels
                // TODO: save to cache (look at Trvlr)
            case let .failure(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.labTV.reloadData()
            }
        }
    }
}
