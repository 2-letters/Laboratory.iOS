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
    @IBOutlet var equipmentTableView: UITableView!
    
    var viewModel = EquipmentListVM()
    
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
        viewModel.fetchAllEquipments() { [unowned self] (itemResult) in
            switch itemResult {
            case let .failure(error):
                print(error)
            case .success:
                DispatchQueue.main.async {
                    self.equipmentTableView.reloadData()
                }
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
        equipmentTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        equipmentTableView.reloadData()
    }
}


// MARK: - Table View
extension EquipmentListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayingEquipmentVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = equipmentTableView.dequeueReusableCell(withIdentifier: ReuseId.simpleEquipmentCell) as! SimpleEquipmentTVCell
        
        cell.setup(viewModel: viewModel.displayingEquipmentVMs?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let equipmentVM = viewModel.displayingEquipmentVMs![indexPath.row]
        performSegue(withIdentifier: SegueId.showEquipmentInfo, sender: equipmentVM.equipmentName)
    }
}
