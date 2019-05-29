//
//  LabEquipmentSelectionVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentSelectionVC: UIViewController, SpinnerPresenter {
    var labId: String!  // for receiving data from Lab Info/Create

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var labEquipmentTV: UITableView!
    
    internal var spinnerVC = SpinnerViewController()
    private var viewModel = LabEquipmentSelectionVM()
    private var hasChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        labEquipmentTV.delegate = self
        labEquipmentTV.dataSource = self
        
        // hide the view until loading is done
        labEquipmentTV.isHidden = true
        // hide spinner
        showSpinner()
        setupUI()
        loadEquipments()
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showEquipmentEdit {
            let labEquipmentEditVC = segue.destination as? LabEquipmentEditVC
            labEquipmentEditVC?.labId = labId
            if let addedEquipmentVM = sender as? LabEquipmentVM {
                labEquipmentEditVC?.equipmentName = addedEquipmentVM.equipmentName
                labEquipmentEditVC?.usingQuantity = addedEquipmentVM.quantity
            } else if let availableEquipmentVM = sender as? SimpleEquipmentVM {
                labEquipmentEditVC?.equipmentName = availableEquipmentVM.equipmentName
            }
        }
    }
    
    @IBAction func unwindFromEquipmentEdit(segue: UIStoryboardSegue) {
        hasChange = true
        loadEquipments()
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        // if the equipments have been changed, perform unwind segue to tell Lab Info to update
        if hasChange {
            let ac = UIAlertController(title: AlertString.successTitle, message: AlertString.succeedToSaveLabEquipmentMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.goBackAndReload))
            self.present(ac, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: Layout
    private func setupUI() {
        // load LabItems TableView
        let labEquipmentNib = UINib(nibName: "LabEquipmentTVCell", bundle: nil)
        labEquipmentTV.register(labEquipmentNib, forCellReuseIdentifier: LabEquipmentTVCell.reuseId)
        
        let simpleEquipmentNib = UINib(nibName: "SimpleEquipmentTVCell", bundle: nil)
        labEquipmentTV.register(simpleEquipmentNib, forCellReuseIdentifier: SimpleEquipmentTVCell.reuseId)
    }
    
    private func loadEquipments() {
        viewModel.fetchEquipments(byLabId: labId) { [unowned self] (fetchResult) in
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.labEquipmentTV.reloadData()
                }
                // show the view
                self.labEquipmentTV.isHidden = false
                // hide spinner
                self.hideSpinner()
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.goBack))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
}


// MARK: - User Interaction
extension LabEquipmentSelectionVC {
    private func goBack(alert: UIAlertAction!) {
        dismiss(animated: true, completion: nil)
    }
    
    private func goBackAndReload(alert: UIAlertAction!) {
        performSegue(withIdentifier: SegueId.unwindFromEquipmentSelection, sender: self)
    }
}


// MARK: - Table View
extension LabEquipmentSelectionVC: UITableViewDelegate, UITableViewDataSource {
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
            let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: LabEquipmentTVCell.reuseId) as! LabEquipmentTVCell
            
            cell.viewModel = viewModel.displayingAddedEquipmentVMs?[indexPath.row]
            
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: SimpleEquipmentTVCell.reuseId) as! SimpleEquipmentTVCell
            cell.viewModel = viewModel.displayingAvailableEquipmentVMs?[indexPath.row]
            
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vm = viewModel.displayingAddedEquipmentVMs?[indexPath.row]
            performSegue(withIdentifier: SegueId.showEquipmentEdit, sender: vm)
        } else {
            let vm = viewModel.displayingAvailableEquipmentVMs?[indexPath.row]
            performSegue(withIdentifier: SegueId.showEquipmentEdit, sender: vm)
        }
    }
}

// MARK: - Search bar
extension LabEquipmentSelectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
        // done changing text, reload table view
        labEquipmentTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        labEquipmentTV.reloadData()
    }
}
