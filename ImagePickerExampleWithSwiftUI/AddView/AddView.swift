//
//  AddView.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/16.
//  Copyright © 2020 Seokho. All rights reserved.
//

import SwiftUI
import Combine

struct AddView: View {
    
    let viewController: UIViewController
    @ObservedObject
    private var viewModel: AddViewModel
    
    init(viewController: UIViewController, viewModel: AddViewModel) {
        self.viewController = viewController
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("이미지 제목을 입력하시오.", text: self.$viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 16)
                    .padding(.top, 8)
                Spacer()
                if self.viewModel.image == nil {
                    Button(action: {
                        withAnimation {
                            self.viewModel.pickerButtonPressed()
                           }
                    }) {
                        ZStack {
                            Color(.systemOrange)
                                .frame(width: 100, height: 100, alignment: .center)
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(Color(.systemBackground))
                                .frame(width: 50, height: 50, alignment: .center)
                        }
                    }
                    .sheet(isPresented: self.$viewModel.showImagePicker) {
                        ImagePicker(image: self.$viewModel.image)
                    }
                    .clipShape(Circle())
                } else {
                    Image(uiImage: self.viewModel.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 100, maxWidth: .infinity,
                               minHeight: 100, maxHeight: .infinity, alignment: .center)
                    Button(action: {
                        withAnimation {
                            self.viewModel.trashImageButtonPressed()
                        }
                    }) {
                        Image(systemName: "trash")
                        .resizable()
                            .foregroundColor(Color(.systemPink))
                            .frame(width: 30, height: 31.05, alignment: .center)
                    }
                    .offset(x: 0, y: -44)
                }
                Spacer()
            }
            .navigationBarTitle("ADD IMAGE" ,displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.viewController.dismiss(animated: true)
            }) {
                Text("취소")
                    .foregroundColor(Color(.label))
            }, trailing: Button(action: {
                self.viewModel.doneButtonPressed()
                self.viewController.dismiss(animated: true)
                }) {
                    Text("확인")
                        .foregroundColor(Color(viewModel.isVaildData ? .label: .systemGray))
            }.disabled(!viewModel.isVaildData))
        }
    }
}
