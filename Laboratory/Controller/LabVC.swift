//
//  LabViewController.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabVC: UIViewController {
    @IBOutlet var labSearchBar: UISearchBar!
    @IBOutlet var labTV: UITableView!
    
    var labVM = LabVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labTV.delegate = self
        labTV.dataSource = self
        labSearchBar.delegate = self
        
        loadLabData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showLabInfo {
            let labInfoVC = segue.destination as! LabInfoVC
            // send info to LabInfo View Controller
            guard let labName = sender as? String else {
                return
            }
            labInfoVC.labName = labName
        }
    }
}

// MARK: - Table View
extension LabVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labVM.displayingLabs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get the table cell
        let cell = Bundle.main.loadNibNamed("LabTVCell", owner: self, options: nil)?.first as! LabTVCell
        // TODO this may be off, cell should not talk to view model
        cell.labVM = labVM
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLabName = labVM.getName(at: indexPath.row)
        // show LabInfo View and send labVM to it
        performSegue(withIdentifier: SegueId.showLabInfo, sender: selectedLabName)
    }
}

// MARK: - Search bar
extension LabVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            labVM.search(by: searchText)
        }
        labTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // cancel searching
        searchBar.text = ""
        labTV.reloadData()
    }
}

// MARK: - Additional helpers
extension LabVC {
    func loadLabData() {
        labVM.fetchLabData() { [unowned self] (fetchResult) in
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.labTV.reloadData()
                }
                // TODO: save to cache (look at Trvlr)
            case let .failure(error):
                print(error)
            }
        }
    }
}
