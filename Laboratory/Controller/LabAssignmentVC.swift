//
//  LabViewController.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabAssignmentVC: UIViewController {

    
    @IBOutlet var labAssignmentSearchBar: UISearchBar!
    @IBOutlet var labAssignmentTV: UITableView!
    
    var labAssignmentVMs = [LabAssignmentVM]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labAssignmentTV.delegate = self
        labAssignmentTV.dataSource = self
        labAssignmentVMs = LabAssignmentSvc.fetchData()
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
extension LabAssignmentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labAssignmentVMs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LabAssignmentTbVCell", owner: self, options: nil)?.first as! LabAssignmentTbVCell
        
        cell.courseViewModel = labAssignmentVMs[indexPath.row]
        return cell
    }
}

// MARK: Search bar
extension LabAssignmentVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        labAssignmentVMs = LabAssignmentSvc.filter(with: searchText)
    }
}
