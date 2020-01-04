//
//  AppCell.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class AppCell: UITableViewCell {

    //MARK:- Private Property
    
    private lazy var iconOfPray: UIImageView = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var nameOfPrayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return label
    }()
    
    private lazy var timeToPrayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return label
    }()

    //MARK:- Public Method
    
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.layoutIfNeeded()
        self.backgroundColor = .clear
        
        self.addSubview(iconOfPray)
        self.addSubview(nameOfPrayLabel)
        self.addSubview(timeToPrayLabel)
        
        iconOfPray.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 26, height: 26)
        
        timeToPrayLabel.anchor(top: contentView.topAnchor, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 80, height: 0)
        
        nameOfPrayLabel.anchor(top: contentView.topAnchor, left: iconOfPray.rightAnchor, bottom: contentView.bottomAnchor, right: timeToPrayLabel.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: self.contentView.frame.width - 64, height: 0)
        
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    func bind(title: String, subtitle: String, icon: String) {
        iconOfPray.image = UIImage(named: icon)
        nameOfPrayLabel.text = subtitle
        timeToPrayLabel.text = title
	}
	
}
