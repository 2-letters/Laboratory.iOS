//
//  LabItemVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabItemEditVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var labItemTV: UITableView!
    
    var labItemVMs = [LabItemEditVM]()
    var searchedLabItemVMs = [LabItemEditVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        labItemTV.delegate = self
        labItemTV.dataSource = self
        // allow multiple selections
        labItemTV.allowsMultipleSelection = true
        
        // load LabItems TableView
        let nib = UINib(nibName: "LabItemEditTVCell", bundle: nil)
        labItemTV.register(nib, forCellReuseIdentifier: "LabItemEditCell")
        
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
extension LabItemEditVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Added Items"
        } else {
            return "Available Items"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedLabItemVMs.count
        }
        return labItemVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
        }
        
        // TODO: 
//        let cell = Bundle.main.loadNibNamed("LabItemTVCell", owner: self, options: nil)?.first as! LabItemTVCell
        let cell = labItemTV.dequeueReusableCell(withIdentifier: "LabItemEditCell") as! LabItemEditTVCell
        if isSearching {
            cell.setup(viewModel: searchedLabItemVMs[indexPath.row])
        } else {
            cell.setup(viewModel: labItemVMs[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm = labItemVMs[indexPath.row]
//        vm.isSelected.value = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.cyan
        cell?.selectedBackgroundView = backgroundView
//        labItemTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm = labItemVMs[indexPath.row]
//        vm.isSelected.value = false
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell?.selectedBackgroundView = backgroundView
//        cell?.contentView.backgroundColor =
        
    }
}

// MARK: - Search bar
extension LabItemEditVC: UISearchBarDelegate {
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
extension LabItemEditVC {
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
