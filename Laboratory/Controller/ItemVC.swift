//
//  ItemVC.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class ItemVC: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItemData()
    }
    
    func loadItemData() {
        
    }
}

// MARK: - Table View
extension ItemVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return nil
    }
}
