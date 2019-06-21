//
//  LabCollectionVC.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

//extension UIColor {
//    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
//        return UIGraphicsImageRenderer(size: size).image(actions: { (rendererContext) in
//            self.setFill()
//            rendererContext.fill(CGRect(origin: .zero, size: size))
//        })
//    }
//}

class LabCollectionVC: UIViewController {
    @IBOutlet private var labSearchBar: UISearchBar!
    @IBOutlet private var labCollectionView: UICollectionView!
    private var addButton: UIBarButtonItem!
    
    private var viewModel = LabCollectionVM()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        setupUI()
        
        // register lab cells
        let nib = UINib(nibName: LabCollectionViewCell.nibId, bundle: nil)
        labCollectionView.register(nib, forCellWithReuseIdentifier: LabCollectionViewCell.reuseId)
        
        loadLabData()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showLabInfo {
            let labInfoVC = segue.destination as! LabInfoVC
            // send info to LabInfo View Controller
            guard let sender = sender as? String else {
                return
            }
            if sender == MyString.creatingNewInstanceFlag {
                labInfoVC.isCreatingNewLab = true
            } else {
                labInfoVC.isCreatingNewLab = false
                labInfoVC.labId = sender
            }
        }
    }
    
    @IBAction private func unwindFromLabInfo(segue: UIStoryboardSegue) {
        // there's some change, reload table view and enable save Button
        loadLabData()
    }
    
    
    // MARK: Layout
    private func setupUI() {
        navigationItem.title = MyString.labCollectionTitle
        // "Create Lab" button
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewLab))
        navigationItem.rightBarButtonItem = addButton
        
        labSearchBar.backgroundImage = UIImage()
        labCollectionView.backgroundColor = MyColor.lightGray
        
        // add refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Labs Data ...")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            labCollectionView.refreshControl = refreshControl
        } else {
            labCollectionView.addSubview(refreshControl)
        }
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        labSearchBar.delegate = self
    
        labCollectionView.delegate = self
        labCollectionView.dataSource = self
        labCollectionView.keyboardDismissMode = .onDrag
    }
    
    private func addIdentifiers() {
        addButton.accessibilityIdentifier = AccessibilityId.labCollectionAddButton.value
        labSearchBar.accessibilityIdentifier = AccessibilityId.labCollectionSearchBar.value
        labCollectionView.accessibilityIdentifier = AccessibilityId.labCollectionView.value
    }
    
    private func loadLabData() {
        viewModel.fetchLabData() { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.labCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            // TODO: save to cache (look at Trvlr)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    // MARK: User Interaction
    @objc private func createNewLab() {
        performSegue(withIdentifier: SegueId.showLabInfo, sender: MyString.creatingNewInstanceFlag)
    }
    
    @objc private func refreshData() {
        loadLabData()
    }
}


// MARK: - Table View
extension LabCollectionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.displayingLabVMs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabCollectionViewCell.reuseId, for: indexPath) as! LabCollectionViewCell
    
        cell.viewModel = viewModel.displayingLabVMs?[indexPath.row]
        cell.labNameLabel.font = UIFont(name: primaryFont, size: 17)
        cell.labDescriptionLabel.font = UIFont(name: secondaryFont, size: 15)
        cell.labDescriptionLabel.textColor = UIColor.lightGray
    
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedLabId = viewModel.getLabId(at: indexPath.row)
        // show LabInfo View and send labVM to it
        performSegue(withIdentifier: SegueId.showLabInfo, sender: selectedLabId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - 24
        let itemHeight: CGFloat = 110
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


// MARK: - Search bar
extension LabCollectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
        labCollectionView.reloadData()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // cancel searching
        searchBar.text = ""
        labCollectionView.reloadData()
    }
}
