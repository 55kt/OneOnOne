//
//  FirebaseConstants.swift
//  OneOnOne
//
//  Created by Vlad on 3/11/24.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

enum FirebaseConstants {
    private static let DatabaseRef = Database.database().reference()
    static let UserRef = DatabaseRef.child("users")
}
