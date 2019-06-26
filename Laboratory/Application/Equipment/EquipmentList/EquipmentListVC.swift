//
//  EquipmentListVC.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentListVC: UIViewController {

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var equipmentTV: UITableView!
    private var addButton: UIBarButtonItem!
    
    private var viewModel = EquipmentListVM()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        
        setupUI()
        loadEquipmentData()
    }
    
    
    // MARK: segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showEquipmentInfo {
            let equipmentInfoVC = segue.destination as! EquipmentInfoVC
            equipmentInfoVC.equipmentId = sender as? String
            if sender == nil {
                // Is Adding a new Equipment
                equipmentInfoVC.isEditingEquipment = true
            }
        }
    }
    
    
    // MARK: Layout
    private func setupUI() {
        navigationItem.title = MyString.equipmentListTitle
        
        searchBar.backgroundImage = UIImage()
        
        // register table cells
        let nib = UINib(nibName: SimpleEquipmentTVCell.nibId, bundle: nil)
        equipmentTV.register(nib, forCellReuseIdentifier: SimpleEquipmentTVCell.reuseId)
        
        // add Refresh Control
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Equipments Data ...")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            equipmentTV.refreshControl = refreshControl
        } else {
            equipmentTV.addSubview(refreshControl)
        }
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewEquipment))
        navigationItem.rightBarButtonItem = addButton
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        searchBar.delegate = self
        equipmentTV.delegate = self
        equipmentTV.dataSource = self
        equipmentTV.keyboardDismissMode = .onDrag
    }
    
    private func addIdentifiers() {
        addButton.accessibilityIdentifier = AccessibilityId.equipmentListAddButton.description
        searchBar.accessibilityIdentifier = AccessibilityId.equipmentListSearchBar.description
        equipmentTV.accessibilityIdentifier = AccessibilityId.equipmentListTableView.description
    }
    
    private func loadEquipmentData() {
        viewModel.fetchAllEquipments() { [weak self] (itemResult) in
            guard let self = self else { return }
            switch itemResult {
            case let .failure(error):
                print(error)
            case .success:
                DispatchQueue.main.async {
                    self.equipmentTV.reloadData()
                    self.refreshControl.endRefreshing()
                }
                // TODO save to cache
            }
        }
    }
    
    
    // MARK: User interaction
    @objc private func createNewEquipment() {
        performSegue(withIdentifier: SegueId.showEquipmentInfo, sender: nil)
    }
    
    @objc private func refreshData(sender: Any) {
        loadEquipmentData()
    }
}

// MARK:  - Search Bar
extension EquipmentListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
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
        let cell = equipmentTV.dequeueReusableCell(withIdentifier: SimpleEquipmentTVCell.reuseId) as! SimpleEquipmentTVCell
        
        cell.viewModel = viewModel.displayingEquipmentVMs?[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let equipmentVM = viewModel.displayingEquipmentVMs![indexPath.row]
        // todo should send equipment id instead
        performSegue(withIdentifier: SegueId.showEquipmentInfo, sender: equipmentVM.equipmentId)
    }
}
