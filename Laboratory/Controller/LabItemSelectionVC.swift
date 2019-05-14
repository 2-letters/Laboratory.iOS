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
        // allow multiple selections
        labItemTV.allowsMultipleSelection = true
        
        // load LabItems TableView
        let nib = UINib(nibName: "LabItemSelectionTVCell", bundle: nil)
        labItemTV.register(nib, forCellReuseIdentifier: "LabItemSelectionCell")
        
        loadLabItemData()
        
        // navbar buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAddingItems))

    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneAddingItems() {
        if let selectedIndexes = labItemTV.indexPathsForSelectedRows {
            print(selectedIndexes)
        }
        dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm = labItemVMs[indexPath.row]
        vm.accessoryType = .checkmark
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.cyan
        cell?.selectedBackgroundView = backgroundView
//        labItemTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm = labItemVMs[indexPath.row]
        vm.accessoryType = .checkmark
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell?.selectedBackgroundView = backgroundView
//        cell?.contentView.backgroundColor =
        
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
