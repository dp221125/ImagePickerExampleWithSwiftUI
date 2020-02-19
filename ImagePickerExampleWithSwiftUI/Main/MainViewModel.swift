//
//  MainViewModel.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published
    var cellModel = [TableViewCellViewModel]()
    @Published
    var showModal: Bool = false
    private var cancellable = Set<AnyCancellable>()
    
    func plusButtonPressed() {
        self.showModal.toggle()
    }
    
    init(dataManager: DataManager) {
        dataManager.$images
            .sink { images in
                self.cellModel = []
                images.forEach { images in
                    self.cellModel.append(MainCellViewModel(data: images, index: self.cellModel.count))
                }
        }.store(in: &self.cancellable)
        
        dataManager.loadData()

    }
}
