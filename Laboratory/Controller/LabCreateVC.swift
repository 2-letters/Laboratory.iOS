//
//  LabCreateVC.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabCreateVC: UIViewController {

    @IBOutlet var labCreateView: LabInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAddingLab(_ sender: UIBarButtonItem) {
        let newLabName = labCreateView.nameTextField.text ?? ""
        let newLabDescription = labCreateView.descriptionTextField.text ?? ""
        
        if (newLabName.isEmpty || newLabDescription.isEmpty) {
            let ac = UIAlertController(title: "Oops!", message: "Please make sure your lab has a name.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        } else {
            LabSvc.createLab(withName: newLabName, description: newLabDescription)
            dismiss(animated: true, completion: nil)
        }
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
