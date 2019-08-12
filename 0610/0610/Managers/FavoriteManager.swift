//
//  FavoriteManager.swift
//  0610
//
//  Created by Chris on 2019/8/8.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let favoriteManager = FavoriteManager.sharedInstance

final class FavoriteManager {
    
    // MARK: - Singleton

    static let sharedInstance = FavoriteManager()

    // MARK: - Variables

//    var favoriteCafe: LocalCollection<Cafe>!

    func addFavoriteCafe(_ cafe: Cafe) {
        guard let currentUser = Auth.auth().currentUser else { return }

//        var cafe = cafe
//
//        var hasUser: Bool = false
//        for userID in cafe.users {
//            if userID == currentUser.uid {
//                hasUser = true
//                break
//            }
//        }
//        if hasUser == false {
//            cafe.users.append(currentUser.uid)
//        }

        let collection = Firestore.firestore().collection("FavoriteCafes")

        let docRef = Firestore.firestore().collection("FavoriteCafes").document("\(cafe.name)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                log.debug("Document data: \(dataDescription)")

//                if var cafe = Cafe(dictionary: document.data()!) {
//
//
//                }

                docRef.updateData(["users": FieldValue.arrayUnion(["\(currentUser.uid)"])])


            } else {
                log.debug("Document does not exist")

                var cafe = cafe
//
//                var hasUser: Bool = false
//                for userID in cafe.users {
//                    if userID == currentUser.uid {
//                        hasUser = true
//                        break
//                    }
//                }
//                if hasUser == false {
//                    cafe.users.append(currentUser.uid)
//                }

                cafe.users.append(currentUser.uid)

                docRef.setData(cafe.dictionary)
            }
        }


    }

}
