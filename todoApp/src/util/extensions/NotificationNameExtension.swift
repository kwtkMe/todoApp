//
//  NotificationNameExtension.swift
//  todoApp
//
//  Created by RIVER on 2019/05/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

extension Notification.Name {
    // Firebase認証について
    static let DidFirebaseLoginstateChanged = Notification.Name("didFirebaseLoginStateChanged")
    // Firestoreについて
    static let DidFirestoreUpdated = Notification.Name("didFirestoreUpdated")
}
