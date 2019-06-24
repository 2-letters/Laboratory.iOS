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
    static func getLabs() -> CollectionReference {
        return firestore.collection(FirestoreKey.users).document(UserUtil.userId).collection(FirestoreKey.labs)
    }
    
    static func getLabsOrdered() -> Query {
        return getLabs().order(by: LabKey.name, descending: false)
    }
    
    static func getLab(withId labId: String) -> DocumentReference {
        return getLabs().document(labId)
    }
    
    static func getLabEquipments(withId labId: String) -> CollectionReference {
        return getLab(withId: labId).collection(FirestoreKey.equipments)
    }
    
    static func getLabEquipment(withLabId labId: String, equipmentId: String) -> DocumentReference {
        return getLabEquipments(withId: labId).document(equipmentId)
    }
    
    // MARK: - Equipment
    static func getAllEquipments() -> CollectionReference {
        return firestore.collection(FirestoreKey.institutions)
            .document(UserUtil.institutionId).collection(FirestoreKey.equipments)
    }
    
    static func getAllEquipmentsOrdered() -> Query {
        return getAllEquipments().order(by: EquipmentKey.name, descending: false)
    }
    
    static func getEquipment(withId equipmentId: String) -> DocumentReference {
        return getAllEquipments().document(equipmentId)
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
}
