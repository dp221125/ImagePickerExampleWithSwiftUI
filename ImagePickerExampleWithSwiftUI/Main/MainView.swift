//
//  MainView.swift
//  ImagePickerExampleWithSwiftUI
//
//  Created by Seokho on 2020/02/19.
//  Copyright © 2020 Seokho. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject
    var viewModel: MainViewModel
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.viewModel = MainViewModel(dataManager: dataManager)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.cellModel, id: \.index) { cellModel in
                    MainCell(viewModel: self.convertCellModel(cellModel))
                }.onDelete(perform: self.delete(at:))
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Main" ,displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.plusButtonPressed()
            }) {
                Image(systemName: "plus")
            }.sheet(isPresented: $viewModel.showModal) {
                AddView(viewModel: AddViewModel(dataManager: self.dataManager))
            })
        }
    }
    
    func convertCellModel(_ cellModel: TableViewCellViewModel) -> TableViewCellViewModel {
        switch cellModel {
        case let cellModel as MainCellViewModel:
            return cellModel
        default:
            fatalError()
        }
    }
    
    func delete(at offsets: IndexSet) {
        self.dataManager.modifyInfomation = ModifyInfomation(type: .delete, index: offsets.first!)
     }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(viewModel: <#MainViewModel#>)
//    }
//}
