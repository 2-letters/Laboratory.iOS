//
//  FirestoreUtil.swift
//  Laboratory
//
//  Created by Huy Vo on 6/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreUtil {
//    static var shared = FirestoreUtil()
    static let firestore = Firestore.firestore()
    
    // MARK: - Lab
    static func fetchLabs() -> CollectionReference {
        return firestore.collection(FirestoreKey.users).document(UserUtil.userId).collection(FirestoreKey.labs)
    }
    
    static func fetchLabsOrdered() -> Query {
        return fetchLabs().order(by: LabKey.name, descending: false)
    }
    
    static func fetchLab(withId labId: String) -> DocumentReference {
        return fetchLabs().document(labId)
    }
    
    static func fetchLabEquipments(withId labId: String) -> CollectionReference {
        return fetchLab(withId: labId).collection(FirestoreKey.equipments)
    }
    
    static func fetchLabEquipment(withLabId labId: String, equipmentId: String) -> DocumentReference {
        return fetchLabEquipments(withId: labId).document(equipmentId)
    }
    
    // MARK: - Equipment
    static func fetchAllEquipments() -> CollectionReference {
        return firestore.collection(FirestoreKey.institutions)
            .document(UserUtil.institutionId).collection(FirestoreKey.equipments)
    }
    
    static func fetchAllEquipmentsOrdered() -> Query {
        return fetchAllEquipments().order(by: EquipmentKey.name, descending: false)
    }
    
    static func fetchEquipment(withId equipmentId: String) -> DocumentReference {
        return fetchAllEquipments().document(equipmentId)
    }
}

struct FirestoreKey {
    static let users = "users"
    static let institutions = "institutions"
    static let labs = "labs"
    static let equipments = "equipments"
}

struct LabKey {
    static let name = "labName"
    static let description = "description"
}

struct EquipmentKey {
    static let name = "equipmentName"
    static let available = "available"
    static let using = "using"
    static let description = "description"
    static let location = "location"
    static let imageUrl = "imageUrl"
    
    static let users = "users"
    static let userName = "userName"
}
