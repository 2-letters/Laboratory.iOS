//
//  LabEquipmentVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentSelectionVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var labEquipmentTV: UITableView!
    
    var labEquipmentVMs = [LabEquipmentSelectionVM]()
    var searchedLabEquipmentVMs = [LabEquipmentSelectionVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        labEquipmentTV.delegate = self
        labEquipmentTV.dataSource = self
        // allow multiple selections
        labEquipmentTV.allowsMultipleSelection = true
        
        // load LabItems TableView
        let nib = UINib(nibName: "LabEquipmentSelectionTVCell", bundle: nil)
        labEquipmentTV.register(nib, forCellReuseIdentifier: ReuseId.labEquipmentSelectionCell)
        
        loadLabEquipmentData()
        
        // navbar buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAddingEquipments))

    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneAddingEquipments() {
        if let selectedIndexes = labEquipmentTV.indexPathsForSelectedRows {
            print(selectedIndexes)
        }
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Table View
extension LabEquipmentSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Added Equipments"
        } else {
            return "Available Equipments"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedLabEquipmentVMs.count
        }
        return labEquipmentVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
        }
        
        // TODO: 
//        let cell = Bundle.main.loadNibNamed("LabEquipmentTVCell", owner: self, options: nil)?.first as! LabEquipmentTVCell
        let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentSelectionCell) as! LabEquipmentSelectionTVCell
        if isSearching {
            cell.setup(viewModel: searchedLabEquipmentVMs[indexPath.row])
        } else {
            cell.setup(viewModel: labEquipmentVMs[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm = labEquipmentVMs[indexPath.row]
//        vm.isSelected.value = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.cyan
        cell?.selectedBackgroundView = backgroundView
//        labEquipmentTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm = labEquipmentVMs[indexPath.row]
//        vm.isSelected.value = false
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell?.selectedBackgroundView = backgroundView
//        cell?.contentView.backgroundColor =
        
    }
}

// MARK: - Search bar
extension LabEquipmentSelectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            labEquipmentTV.reloadData()
            return
        }
        isSearching = true
        searchedLabEquipmentVMs = labEquipmentVMs.filter({$0.equipmentName.lowercased().contains(searchText.lowercased())})
        labEquipmentTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        labEquipmentTV.reloadData()
    }
}


// MARK: - Additional Helpers
extension LabEquipmentSelectionVC {
    func loadLabEquipmentData() {
        LabSvc.fetchLabEquipment() { [unowned self] (labEquipmentResult) in
            switch labEquipmentResult {
            case let .success(viewModels):
                self.labEquipmentVMs = viewModels
            // TODO: save to cache
            case let .failure(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.labEquipmentTV.reloadData()
            }
        }
    }
}
