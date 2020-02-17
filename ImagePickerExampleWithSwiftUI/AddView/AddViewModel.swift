//
//  AddViewModel.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit
import Combine

class AddViewModel: ObservableObject {
    @Published var showImagePicker: Bool = false
    @Published var image: UIImage?
    @Published var title: String = ""
    var isVaildData: Bool = false
    private let dataManager: DataManager
    private var cancellable = Set<AnyCancellable>()
    
    func pickerButtonPressed() {
        self.showImagePicker.toggle()
    }
    
    func trashImageButtonPressed() {
        self.image = nil
    }
    
    func doneButtonPressed() {
        let saveData = ImagesData(title: self.title, data: self.image!.pngData()!)
        self.dataManager.saveData(newData: saveData)
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        self.$image
            .combineLatest(self.$title) { $0 != nil && $1.trimmingCharacters(in: .whitespaces) != ""}
            .assign(to: \.isVaildData, on: self)
            .store(in: &self.cancellable)
    }
}
