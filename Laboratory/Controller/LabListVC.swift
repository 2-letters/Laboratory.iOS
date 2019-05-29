//
//  LabListVC.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabListVC: UIViewController {
    @IBOutlet private var labSearchBar: UISearchBar!
    @IBOutlet private var labTV: UITableView!
    
    private var viewModel = LabListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labTV.delegate = self
        labTV.dataSource = self
        labSearchBar.delegate = self
        
        // register lab cells
        let nib = UINib(nibName: "LabTVCell", bundle: nil)
        labTV.register(nib, forCellReuseIdentifier: LabTVCell.reuseId)
        
        loadLabData()
    }
    
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showLabInfo {
            let labInfoVC = segue.destination as! LabInfoVC
            // send info to LabInfo View Controller
            guard let labId = sender as? String else {
                return
            }
            labInfoVC.labId = labId
        }
    }
    
    @IBAction func unwindFromLabInfo(segue: UIStoryboardSegue) {
        // there's some change, reload table view and enable save Button
        loadLabData()
    }
    
    
    // MARK: Layout
    func loadLabData() {
        viewModel.fetchLabData() { [unowned self] (fetchResult) in
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


// MARK: - Table View
extension LabListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayingLabVMs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get the table cell
        let cell = labTV.dequeueReusableCell(withIdentifier: LabTVCell.reuseId) as! LabTVCell
        
        cell.viewModel = viewModel.displayingLabVMs?[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLabId = viewModel.getLabId(at: indexPath.row)
        // show LabInfo View and send labVM to it
        performSegue(withIdentifier: SegueId.showLabInfo, sender: selectedLabId)
    }
}


// MARK: - Search bar
extension LabListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
        labTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // cancel searching
        searchBar.text = ""
        labTV.reloadData()
    }
}
