//
//  ReuseId&NibName.swift
//  Laboratory
//
//  Created by Developers on 7/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

//enum ReuseId {
//    static let a = "SimpleEquipmentCell"
//}
//
//enum NibName {
//    static let a = "SimpleEquipmentTVCell"
//}

protocol ReusableView: class {
    static var reuseId: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseId: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension SimpleEquipmentTVCell: NibLoadableView {}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseId)
        print(T.reuseId)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseId)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseId)")
        }
        
        return cell
    }
}
