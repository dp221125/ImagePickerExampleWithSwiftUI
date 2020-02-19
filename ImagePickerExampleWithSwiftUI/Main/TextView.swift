//
//  TextView.swift
//  ImagePickerExampleWithSwiftUI
//
//  Created by Seokho on 2020/02/19.
//  Copyright © 2020 Seokho. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {

    let text: NSAttributedString?

    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        uiView.attributedText = self.text
    }
}
//
//struct TextView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextView()
//    }
//}
