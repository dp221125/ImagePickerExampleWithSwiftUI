//
//  MainCellSwiftUI.swift
//  ImagePickerExampleWithSwiftUI
//
//  Created by Seokho on 2020/02/19.
//  Copyright © 2020 Seokho. All rights reserved.
//

import SwiftUI

struct MainCell: View {
    
    @ObservedObject
    var viewModel: MainCellViewModel

    init(viewModel: TableViewCellViewModel) {
        self.viewModel = viewModel as! MainCellViewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title!)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text(convertDateToString(viewModel.date!))
                    .font(.system(size: 14))
            }
            Spacer()
            TextView(text: convertAttributeString(self.viewModel.imageData!))
                .frame(width: 60, height: 60)
            
        }
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 8)
        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
    }
    func convertDateToString(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    func convertAttributeString(_ data: Data) -> NSAttributedString? {
        let image = UIImage(data: data)
          
        return image?.resizing(targetSize: CGSize(width: 60, height: 60))?.convertToAttributeString()
    }
}
//
//struct MainCellSwiftUI_Previews: PreviewProvider {
//    static var previews: some View {
//        MainCell()
//    }
//}
