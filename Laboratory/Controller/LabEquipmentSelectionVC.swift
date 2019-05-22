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
    
    var addedEquipments: [String]!
    var viewModels = LabEquipmentSelectionVM()
    var searchedViewModels = LabEquipmentSelectionVM()
    
//    var labEquipmentVMs = [SimpleEquipmentVM]()
//    var searchedLabEquipmentVMs = [SimpleEquipmentVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        labEquipmentTV.delegate = self
        labEquipmentTV.dataSource = self
        
        setupUI()
    }
    
    // MARK: Layout
    func setupUI() {
        // load LabItems TableView
        let nib = UINib(nibName: "SimpleEquipmentTVCell", bundle: nil)
        labEquipmentTV.register(nib, forCellReuseIdentifier: ReuseId.labEquipmentSelectionCell)
        
        // navbar buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAddingEquipments))
        
        viewModels.fetchEquipments(addedEquipments: addedEquipments) {
            labEquipmentTV.reloadData()
        }
    }
}

// MARK: - User Interaction
extension LabEquipmentSelectionVC {
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
            if section == 0 {
                return searchedViewModels.addedEquipmentVMs?.count ?? 0
            } else {
                return searchedViewModels.availableEquipmentVMs?.count ?? 0
            }
        } else {
            if section == 0 {
                return viewModels.addedEquipmentVMs?.count ?? 0
            } else {
                return viewModels.availableEquipmentVMs?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentSelectionCell) as! SimpleEquipmentTVCell
        if isSearching {
            if indexPath.section == 0 {
                cell.setup(viewModel: searchedViewModels.addedEquipmentVMs?[indexPath.row])
            } else {
                cell.setup(viewModel: searchedViewModels.availableEquipmentVMs?[indexPath.row])
            }
        } else {
            if indexPath.section == 0 {
                cell.setup(viewModel: viewModels.addedEquipmentVMs?[indexPath.row])
            } else {
                cell.setup(viewModel: viewModels.availableEquipmentVMs?[indexPath.row])
            }
        }
        return cell
        
        
        // TODO: 
//        let cell = Bundle.main.loadNibNamed("LabEquipmentTVCell", owner: self, options: nil)?.first as! LabEquipmentTVCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var vm: SimpleEquipmentVM?
        if isSearching {
            if indexPath.section == 0 {
                vm = searchedViewModels.addedEquipmentVMs?[indexPath.row]
            } else {
                vm = searchedViewModels.availableEquipmentVMs?[indexPath.row]
            }
        } else {
            if indexPath.section == 0 {
                vm = viewModels.addedEquipmentVMs?[indexPath.row]
            } else {
                vm = viewModels.availableEquipmentVMs?[indexPath.row]
            }
        }
//        var vm = viewModels[indexPath.row]
//        vm.isSelected.value = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.cyan
        cell?.selectedBackgroundView = backgroundView
//        labEquipmentTV.reloadData()
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
        searchedViewModels = labEquipmentVMs.filter({$0.equipmentName.lowercased().contains(searchText.lowercased())})
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
//    func loadLabEquipmentData() {
//        EquipmentSvc.fetchAllEquipments { [unowned self] (labEquipmentResult) in
//            switch labEquipmentResult {
//            case let .success(viewModels):
//                self.viewModels = viewModels
//            // TODO: save to cache
//            case let .failure(error):
//                print(error)
//            }
//
//            DispatchQueue.main.async {
//                self.labEquipmentTV.reloadData()
//            }
//        }
//    }
}
