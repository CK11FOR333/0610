//
//  RealmManager.swift
//  0610
//
//  Created by Chris on 2019/7/22.
//  Copyright © 2019 user. All rights reserved.
//

import RealmSwift

let realmManager = RealmManager.sharedInstance

final class RealmManager {
    
    // MARK: - Singleton
    static let sharedInstance = RealmManager()

    var realm: Realm!

    init() {
        // Get the default Realm
        realm = try! Realm()
    }

    func addFavoriteCafe(_ cafe: Cafe) {
        // Create realm object
        let cafeRealm = CafeRealm()
        cafeRealm.id = cafe.id
        cafeRealm.mrt = cafe.mrt
        cafeRealm.url = cafe.url
        cafeRealm.city = cafe.city
        cafeRealm.name = cafe.name
        cafeRealm.socket = cafe.socket
        cafeRealm.address = cafe.address
        cafeRealm.longitude = cafe.longitude
        cafeRealm.latitude = cafe.latitude
        cafeRealm.limited_time = cafe.limited_time
        cafeRealm.standing_desk = cafe.standing_desk

        cafeRealm.wifi = cafe.wifi
        cafeRealm.seat = cafe.seat
        cafeRealm.quiet = cafe.quiet
        cafeRealm.tasty = cafe.tasty
        cafeRealm.cheap = cafe.cheap
        cafeRealm.music = cafe.music

        // Persist your data easily
        try! realm.write {
            realm.add(cafeRealm)
        }
    }

    func removeFavoriteCafe(_ cafe: Cafe) {
        // Query Realm for selected cafe
        if let cafeRealm = realm.object(ofType: CafeRealm.self, forPrimaryKey: cafe.id) {
            // delete it
            try! realm.write {
                realm.delete(cafeRealm)
            }
        }
    }

    func removeAllCafes() {
        let cafeRealms = realm.objects(CafeRealm.self)        
        try! realm.write {
            realm.delete(cafeRealms)
        }
    }

    func isCafeCollected(_ cafe: Cafe) -> Bool {
        if realm.object(ofType: CafeRealm.self, forPrimaryKey: cafe.id) != nil {
            return true
        }
        return false
    }

    func getCafes() -> [Cafe] {
        let cafeRealms = realm.objects(CafeRealm.self)

        var cafes: [Cafe] = []

        for cafeRealm in cafeRealms {
            let cafe = Cafe.init(id: cafeRealm.id,
                                 mrt: cafeRealm.mrt,
                                 url: cafeRealm.url,
                                 city: cafeRealm.city,
                                 name: cafeRealm.name,
                                 socket: cafeRealm.socket,
                                 address: cafeRealm.address,
                                 longitude: cafeRealm.longitude,
                                 latitude: cafeRealm.latitude,
                                 limited_time: cafeRealm.limited_time,
                                 standing_desk: cafeRealm.standing_desk,
                                 wifi: cafeRealm.wifi,
                                 seat: cafeRealm.seat,
                                 quiet: cafeRealm.quiet,
                                 tasty: cafeRealm.tasty,
                                 cheap: cafeRealm.cheap,
                                 music: cafeRealm.music,
                                 users: [])
            cafes.append(cafe)
        }

        return cafes
    }

}
