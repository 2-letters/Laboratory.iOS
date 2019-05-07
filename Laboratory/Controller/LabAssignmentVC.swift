//
//  LabViewController.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabAssignmentVC: UIViewController {

    
    @IBOutlet var labAssignmentTableView: UITableView!
    var labAssignmentVMs = [LabAssignmentVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        labAssignmentVMs = [
            LabAssignmentVM(assignment: LabAssignment(name: "lab1", description: "abc")),
            LabAssignmentVM(assignment: LabAssignment(name: "lab2", description: "abc2")),
        ]
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

extension LabAssignmentVC: UITableViewDataSource, UIViewTableDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labAssignmentVMs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LabAssignmentTbVCell", owner: self, options: nil)?.first as! LabAssignmentTbVCell
        
        cell.labAssigmentNameLbl = labAssignmentVMs[indexPath.row].name
        return cell
    }
}
