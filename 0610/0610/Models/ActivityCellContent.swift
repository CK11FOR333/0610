//
//  ActivityCellContent.swift
//  0610
//
//  Created by Chris on 2019/6/20.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

struct Content {
    var text: String?
    var textColor: String?
    var textBackgroundColor: String?
    var textImage: String?
    var textWeb: String?

    var info: String?
    var infoColor: String?
    var infoBackgroundColor: String?
    var infoImage: String?
    var infoWeb: String?
}

extension Content {
    init(text: String?, textColor: String?, textBackgroundColor: String?, textImage: String?, textWeb: String?) {
        self.text = text
        self.textColor = textColor
        self.textBackgroundColor = textBackgroundColor
        self.textImage = textImage
        self.textWeb = textWeb
        self.info = nil
        self.infoColor = nil
        self.infoBackgroundColor = nil
        self.infoImage = nil
        self.infoWeb = nil
    }
}

protocol ActivityCellContent {
    var type: Int { get }
    var contents: [Content] { get set }
}

struct TypeOne: ActivityCellContent {
    var type = 1
    var contents: [Content]
    var title: String
    var titleColor: String
    var msg: String
    var msgColor: String
    var backgroundColor: String
}

struct TypeTwo: ActivityCellContent {
    var type = 2
    var contents: [Content]
}

struct TypeThree: ActivityCellContent {
    var type: Int
    var contents: [Content]
}

struct TypeFour: ActivityCellContent {
    var type = 4
    var contents: [Content]
    var cellPaddingColor: String
}

struct TypeFive: ActivityCellContent {
    var type = 5
    var contents: [Content]
}

struct TypeSix: ActivityCellContent {
    var type = 6
    var contents: [Content] 
}

struct TypeSeven: ActivityCellContent {
    var type = 7
    var contents: [Content]
    var cellPaddingColor: String
}
