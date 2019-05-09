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
    
    var labVMs = [LabVM]()
    var searchedLabVMs = [LabVM]()
    var isSearching = false
    
    var service: LabSvc!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labTV.delegate = self
        labTV.dataSource = self
        labSearchBar.delegate = self
        
        service = LabSvc()
        labVMs = service.fetchData()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: Table View
extension LabVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedLabVMs.count
        }
        return labVMs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LabTVCell", owner: self, options: nil)?.first as! LabTVCell
        if isSearching {
            cell.labVM = searchedLabVMs[indexPath.row]
        } else {
            cell.labVM = labVMs[indexPath.row]
        }
        
        return cell
    }
}

// MARK: Search bar
extension LabVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchedLabVMs = service.filter(with: searchText)
        labTV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        labTV.reloadData()
    }
}
