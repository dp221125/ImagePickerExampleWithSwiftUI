//
//  MainCell.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/16.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    var viewModel: MainCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel,
                let date = viewModel.date,
                let imageData = viewModel.imageData else { return }
            self.titleLabel?.text = viewModel.title
            let formatter = RelativeDateTimeFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateTimeStyle = .named
            self.subTitleLabel?.text = formatter.localizedString(for: date, relativeTo: Date())
            
            let image = UIImage(data: imageData)
            
            let imageAttributeString = image?.resizing(targetSize: CGSize(width:  self.contentView.bounds.height, height: self.contentView.bounds.height))?.convertToAttributeString()
            self.imageTextView?.attributedText = imageAttributeString
        }
    }
    
    private weak var titleLabel: UILabel?
    private weak var subTitleLabel: UILabel?
    private weak var imageTextView: UITextView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.font = .boldSystemFont(ofSize: 20)
        self.titleLabel = titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.44)
        ])
        
        let subTitleLabel = UILabel()
        self.subTitleLabel = subTitleLabel
        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.8),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        self.contentView.addSubview(textView)
        self.imageTextView = textView
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            textView.widthAnchor.constraint(equalTo: textView.heightAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
