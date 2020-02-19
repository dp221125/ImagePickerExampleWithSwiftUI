//
//  MainCellViewModel.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation

protocol TableViewCellViewModel {
    var index: Int { get }
}

class MainCellViewModel: TableViewCellViewModel, ObservableObject  {
    var title: String?
    var date: Date?
    var imageData: Data?
    var index: Int
    
    init(data: Images, index: Int) {
        self.title = data.title
        self.date = data.date
        self.imageData = data.image
        self.index = index
    }
}
