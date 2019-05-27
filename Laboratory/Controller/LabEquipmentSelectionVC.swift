//
//  LabEquipmentSelectionVC.swift
//  Laboratory
//
//  Created by Administrator on 5/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentSelectionVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var labEquipmentTV: UITableView!
    
    var addedEquipmentVMs: [LabEquipmentVM]!  // for receiving data from Lab Info/Create
    var viewModel = LabEquipmentSelectionVM()
    
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
        let labEquipmentNib = UINib(nibName: "LabEquipmentTVCell", bundle: nil)
        labEquipmentTV.register(labEquipmentNib, forCellReuseIdentifier: ReuseId.labEquipmentCell)
        
        let simpleEquipmentNib = UINib(nibName: "SimpleEquipmentTVCell", bundle: nil)
        labEquipmentTV.register(simpleEquipmentNib, forCellReuseIdentifier: ReuseId.simpleEquipmentCell)
        
        viewModel.fetchEquipments(addedEquipmentVMs: addedEquipmentVMs) { [unowned self] (fetchResult) in
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.labEquipmentTV.reloadData()
                }
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.failToLoadTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.tryAgain))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showEquipmentEdit {
            let labEquipmentEditVC = segue.destination as? LabEquipmentEditVC
            if let addedEquipmentVM = sender as? LabEquipmentVM {
                labEquipmentEditVC?.equipmentName = addedEquipmentVM.equipmentName
                labEquipmentEditVC?.usingQuantity = addedEquipmentVM.quantity
            } else if let availableEquipmentVM = sender as? SimpleEquipmentVM {
                labEquipmentEditVC?.equipmentName = availableEquipmentVM.equipmentName
            }
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - User Interaction
extension LabEquipmentSelectionVC {
    func tryAgain(alert: UIAlertAction!) {
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
//        let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: ReuseId.simpleEquipmentCell) as! SimpleEquipmentTVCell
        
        if indexPath.section == 0 {
            let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentCell) as! LabEquipmentTVCell
            
            cell.viewModel = viewModel.displayingAddedEquipmentVMs?[indexPath.row]
            
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: ReuseId.simpleEquipmentCell) as! SimpleEquipmentTVCell
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
        if searchText != "" {
            viewModel.search(by: searchText)
        }
        // done changing text, reload table view
        labEquipmentTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        labEquipmentTV.reloadData()
    }
}
