//
//  MainCellViewModel.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation

protocol TableViewCellViewModel {
    static var reuseIdentifier: String { get }
}

class MainCellViewModel: TableViewCellViewModel  {
    static var reuseIdentifier: String = "\(MainCell.self)"
    var title: String?
    var date: Date?
    var imageData: Data?
    
    init(data: Images) {
        self.title = data.title
        self.date = data.date
        self.imageData = data.image
    }
    
    init() {
        self.title = "Is Only Test"
        self.date = Date()
    }
}
