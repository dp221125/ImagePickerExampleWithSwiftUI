//
//  MainViewModel.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation
import Combine

class MainViewModel {
    @Published
    var cellModel = [TableViewCellViewModel]()
    private var cancellable = Set<AnyCancellable>()
    
    init(dataManager: DataManager) {
        dataManager.$images
            .sink { images in
                self.cellModel = []
                images.forEach { images in
                    self.cellModel.append(MainCellViewModel(data: images))
                }
        }.store(in: &self.cancellable)
        
        dataManager.loadData()

    }
}
