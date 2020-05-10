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
    @IBOutlet private var equipmentTableView: UITableView!
    private var addButton: UIBarButtonItem!
    
    private var viewModel = EquipmentListVM()
    private lazy var refreshControl = UIRefreshControl()
    private let cellReuseIdAndNibName = "SimpleEquipmentTVCell"
    private let showEquipmentInfoSegue = "showEquipmentInfo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        
        setupUI()
        loadEquipmentData()
    }
    
    
    // MARK: segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEquipmentInfoSegue {
            let equipmentInfoVC = segue.destination as! EquipmentInfoVC
            equipmentInfoVC.equipmentId = sender as? String
            if sender == nil {
                // Is Adding a new Equipment
                equipmentInfoVC.isEditingEquipment = true
            }
        }
    }
    
    @IBAction private func unwindFromEquipmentInfo(segue: UIStoryboardSegue) {
        // there's some change, reload collection view
        loadEquipmentData()
    }
    
    
    // MARK: Layout
    private func setupUI() {
        navigationItem.title = "Equipment"
        
        searchBar.backgroundImage = UIImage()
        
        registerCell()
        addRefreshControl()
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewEquipment))
        navigationItem.rightBarButtonItem = addButton
        
        addDelegates()
        addIdentifiers()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: cellReuseIdAndNibName, bundle: nil)
        equipmentTableView.register(nib, forCellReuseIdentifier: cellReuseIdAndNibName)
    }
    
    private func addRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Equipment Data ...")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            equipmentTableView.refreshControl = refreshControl
        } else {
            equipmentTableView.addSubview(refreshControl)
        }
    }
    
    private func addDelegates() {
        searchBar.delegate = self
        equipmentTableView.delegate = self
        equipmentTableView.dataSource = self
        equipmentTableView.keyboardDismissMode = .onDrag
    }
    
    private func addIdentifiers() {
        addButton.accessibilityIdentifier = AccessibilityId.equipmentListAddButton.description
        searchBar.accessibilityIdentifier = AccessibilityId.equipmentListSearchBar.description
        equipmentTableView.accessibilityIdentifier = AccessibilityId.equipmentListTableView.description
    }
    
    private func loadEquipmentData() {
        viewModel.fetchAllEquipments() { [weak self] (itemResult) in
            guard let self = self else { return }
            switch itemResult {
            case let .failure(error):
                print(error)
            case .success:
                DispatchQueue.main.async {
                    self.equipmentTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
                // TODO save to cache
            }
        }
    }
    
    
    // MARK: User interaction
    @objc private func createNewEquipment() {
        performSegue(withIdentifier: showEquipmentInfoSegue, sender: nil)
    }
    // TODO: test this
    @objc private func refreshData(sender: Any) {
        loadEquipmentData()
    }
}

// MARK:  - Search Bar
extension EquipmentListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
        equipmentTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        equipmentTableView.reloadData()
    }
}


// MARK: - Table View
extension EquipmentListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayingEquipmentVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdAndNibName, for: indexPath) as! SimpleEquipmentTVCell
        
        cell.viewModel = viewModel.displayingEquipmentVMs?[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension EquipmentListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let equipmentVM = viewModel.displayingEquipmentVMs![indexPath.row]
        // todo should send equipment id instead
        performSegue(withIdentifier: showEquipmentInfoSegue, sender: equipmentVM.equipmentId)
    }
}
