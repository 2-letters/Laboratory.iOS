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
    
    var addedEquipments: [String]!  // for receiving data from Lab Info/Create
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
        let nib = UINib(nibName: "SimpleEquipmentTVCell", bundle: nil)
        labEquipmentTV.register(nib, forCellReuseIdentifier: ReuseId.labEquipmentSelectionCell)
        
        // navbar buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAddingEquipments))
        
        viewModel.fetchEquipments(addedEquipments: addedEquipments) { [unowned self] (fetchResult) in
            switch fetchResult {
            case .success:
                self.labEquipmentTV.reloadData()
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.failToLoadTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.tryAgain))
                self.present(ac, animated: true, completion: nil)
            }
            
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
        let cell = labEquipmentTV.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentSelectionCell) as! SimpleEquipmentTVCell
        
        if indexPath.section == 0 {
            cell.setup(viewModel: viewModel.displayingAddedEquipmentVMs?[indexPath.row])
        } else {
            cell.setup(viewModel: viewModel.displayingAvailableEquipmentVMs?[indexPath.row])
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell1 = tableView.cellForRow(at: indexPath)
        let cell2 = labEquipmentTV.cellForRow(at: indexPath)
        var vm: SimpleEquipmentVM?
        
        if indexPath.section == 0 {
            vm = viewModel.displayingAddedEquipmentVMs?[indexPath.row]
        } else {
            vm = viewModel.displayingAvailableEquipmentVMs?[indexPath.row]
        }
        
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor.cyan
     
//        cell?.selectedBackgroundView = backgroundView
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
