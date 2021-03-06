//
//  LabEquipmentSelectionVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentSelectionVC: UIViewController, SpinnerPresentable, AlertPresentable {
    var labId: String?  // for receiving data from Lab Info/Create

    @IBOutlet private var doneButton: UIBarButtonItem!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var labEquipmentTableView: UITableView!
    
    var spinnerVC = SpinnerViewController()
    private let labEquipmentCellReuseIdAndNibName = "LabEquipmentTVCell"
    private let simpleEquipmentCellReuseIdAndNibName = "SimpleEquipmentTVCell"
    private let showEquipmentEditSegue = "showEquipmentEdit"
    private let unwindFromEquipmentSelectionSegue = "unwindFromEquipmentSelection"
    private var viewModel = LabEquipmentSelectionVM()
    private var hasChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        
        // show spinner
        showSpinner()
        setupUI()
        loadEquipments()
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEquipmentEditSegue {
            let labEquipmentEditVC = segue.destination as? LabEquipmentEditVC
            labEquipmentEditVC?.labId = labId
            if let addedEquipmentVM = sender as? LabEquipmentVM {
                labEquipmentEditVC?.equipmentId = addedEquipmentVM.equipmentId
                labEquipmentEditVC?.usingQuantity = addedEquipmentVM.quantity
            } else if let availableEquipmentVM = sender as? SimpleEquipmentVM {
                labEquipmentEditVC?.equipmentId = availableEquipmentVM.equipmentId
            }
        }
    }
    
    @IBAction private func unwindFromEquipmentEdit(segue: UIStoryboardSegue) {
        hasChange = true
        loadEquipments()
    }
    
    @IBAction private func done(_ sender: UIBarButtonItem) {
        // if the equipments have been changed, perform unwind segue to tell Lab Info to update
        if hasChange {
            goBackAndReload()
        } else {
            goBack()
        }
    }
    
    
    // MARK: Layout
    private func setupUI() {
        navigationItem.title = "Edit Equipment"
        
        searchBar.backgroundImage = UIImage()
        
        registerCells()
        
        addDelegates()
        addIdentifiers()
    }
    
    private func registerCells() {
        let labEquipmentNib = UINib(nibName: labEquipmentCellReuseIdAndNibName, bundle: nil)
        labEquipmentTableView.register(labEquipmentNib, forCellReuseIdentifier: labEquipmentCellReuseIdAndNibName)
        
        let simpleEquipmentNib = UINib(nibName: simpleEquipmentCellReuseIdAndNibName, bundle: nil)
        labEquipmentTableView.register(simpleEquipmentNib, forCellReuseIdentifier: simpleEquipmentCellReuseIdAndNibName)
    }
    
    private func addDelegates() {
        searchBar.delegate = self
        labEquipmentTableView.delegate = self
        labEquipmentTableView.dataSource = self
        labEquipmentTableView.keyboardDismissMode = .onDrag
    }
    
    private func addIdentifiers() {
        doneButton.accessibilityIdentifier = AccessibilityId.labEquipmentSelectionDoneButton.description
        searchBar.accessibilityIdentifier = AccessibilityId.labEquipmentSelectionSearchBar.description
        labEquipmentTableView.accessibilityIdentifier = AccessibilityId.labEquipmentSelectionTableView.description
    }
    
    private func loadEquipments() {
        guard let labId = labId else { return }
        viewModel.fetchEquipments(byLabId: labId) { [weak self]
            (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.labEquipmentTableView.reloadData()
                }
                // hide spinner
                self.hideSpinner()
                
            case .failure:
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipments, handler: { action in
                    self.goBack()
                })
            }
        }
    }
}


// MARK: - User Interaction
extension LabEquipmentSelectionVC {
    private func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    private func goBackAndReload() {
        performSegue(withIdentifier: unwindFromEquipmentSelectionSegue, sender: nil)
    }
}

// MARK: - Table View
extension LabEquipmentSelectionVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return viewModel.addedSectionHeader
        } else {
            return viewModel.availableSectionHeader
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.displayingAddedEquipmentVMs?.count ?? 0
        } else {
            return viewModel.displayingAvailableEquipmentVMs?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return getAddedEquipmentCellFor(tableView, indexPath: indexPath)
        } else {
            return getAvailableEquipmentCellFor(tableView, indexPath: indexPath)
        }
    }
}

extension LabEquipmentSelectionVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vm = viewModel.displayingAddedEquipmentVMs?[indexPath.row]
            performSegue(withIdentifier: showEquipmentEditSegue, sender: vm)
        } else {
            let vm = viewModel.displayingAvailableEquipmentVMs?[indexPath.row]
            performSegue(withIdentifier: showEquipmentEditSegue, sender: vm)
        }
    }
}

// MARK: - Search bar
extension LabEquipmentSelectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        viewModel.doSearch()
        // done changing text, reload table view
        labEquipmentTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        labEquipmentTableView.reloadData()
    }
}

// MARK: - Helpers
extension LabEquipmentSelectionVC {
    private func getAddedEquipmentCellFor(_ tableView : UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: labEquipmentCellReuseIdAndNibName, for: indexPath) as! LabEquipmentTVCell
        
        cell.viewModel = viewModel.displayingAddedEquipmentVMs?[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    private func getAvailableEquipmentCellFor(_ tableView : UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: simpleEquipmentCellReuseIdAndNibName, for: indexPath) as! SimpleEquipmentTVCell
        
        cell.viewModel = viewModel.displayingAvailableEquipmentVMs?[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
