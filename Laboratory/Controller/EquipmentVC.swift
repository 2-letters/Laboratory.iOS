//
//  EquipmentVC.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var equipmentTableView: UITableView!
    
    var isSearching = false
    var equipmentVMs = [SimpleEquipmentVM]()
    var searchedEquipmentVMs = [SimpleEquipmentVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        equipmentTableView.delegate = self
        equipmentTableView.dataSource = self
        
        setupUI()
        loadEquipmentData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showEquipmentInfo {
            let equipmentInfoVC = segue.destination as! EquipmentInfoVC
            equipmentInfoVC.equipmentName = sender as? String
        }
    }
    
    // MARK: Layout
    func setupUI() {
        let nib = UINib(nibName: "SimpleEquipmentTVCell", bundle: nil)
        equipmentTableView.register(nib, forCellReuseIdentifier: ReuseId.simpleEquipmentCell)
    }
    
    func loadEquipmentData() {
        EquipmentSvc.fetchAllEquipments() { [unowned self] (itemResult) in
            switch itemResult {
            case let .failure(error):
                print(error)
            case let .success(viewModels):
                self.equipmentVMs = viewModels
            }
            self.equipmentTableView.reloadData()
        }
    }
}

// MARK:  - Search Bar
extension EquipmentVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            equipmentTableView.reloadData()
            return
        }
        isSearching = true
        searchedEquipmentVMs = equipmentVMs.filter({$0.equipmentName.lowercased().contains(searchText.lowercased())})
        equipmentTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        equipmentTableView.reloadData()
    }
}


// MARK: - Table View
extension EquipmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching == true ? searchedEquipmentVMs.count : equipmentVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = equipmentTableView.dequeueReusableCell(withIdentifier: ReuseId.simpleEquipmentCell) as! SimpleEquipmentTVCell
        if isSearching {
            cell.setup(viewModel: searchedEquipmentVMs[indexPath.row])
        } else {
            cell.setup(viewModel: equipmentVMs[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let labEquipmentEditVM = equipmentVMs[indexPath.row]
        performSegue(withIdentifier: SegueId.showEquipmentInfo, sender: labEquipmentEditVM.equipmentName)
    }
}
