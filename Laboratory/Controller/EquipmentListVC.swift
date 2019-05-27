//
//  EquipmentListVC.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentListVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var equipmentTV: UITableView!
    
    var viewModel = EquipmentListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        equipmentTV.delegate = self
        equipmentTV.dataSource = self
        
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
        equipmentTV.register(nib, forCellReuseIdentifier: SimpleEquipmentTVCell.reuseID)
    }
    
    func loadEquipmentData() {
        viewModel.fetchAllEquipments() { [unowned self] (itemResult) in
            switch itemResult {
            case let .failure(error):
                print(error)
            case .success:
                DispatchQueue.main.async {
                    self.equipmentTV.reloadData()
                }
                // TODO save to cache
            }
        }
    }
}

// MARK:  - Search Bar
extension EquipmentListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            viewModel.search(by: searchText)
        }
        equipmentTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        equipmentTV.reloadData()
    }
}


// MARK: - Table View
extension EquipmentListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayingEquipmentVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = equipmentTV.dequeueReusableCell(withIdentifier: SimpleEquipmentTVCell.reuseID) as! SimpleEquipmentTVCell
        
        cell.viewModel = viewModel.displayingEquipmentVMs?[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let equipmentVM = viewModel.displayingEquipmentVMs![indexPath.row]
        performSegue(withIdentifier: SegueId.showEquipmentInfo, sender: equipmentVM.equipmentName)
    }
}
