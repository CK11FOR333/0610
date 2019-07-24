//
//  CafeRealm.swift
//  0610
//
//  Created by Chris on 2019/7/24.
//  Copyright © 2019 user. All rights reserved.
//

import RealmSwift

class CafeRealm: Object {

    @objc dynamic var id: String = ""
    @objc dynamic var mrt: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var socket: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var longitude: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var limited_time: String = ""
    @objc dynamic var standing_desk: String = ""

    @objc dynamic var wifi: Int = 0
    @objc dynamic var seat: Int = 0
    @objc dynamic var quiet: Int = 0
    @objc dynamic var tasty: Int = 0
    @objc dynamic var cheap: Int = 0
    @objc dynamic var music: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

}
