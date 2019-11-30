//
//  HomeHeaderCell.swift
//  ZatWal
//
//  Created by Muhammad Noor on 23/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

    private lazy var georgeCalendarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        return label
    }()
    
    private lazy var IslamicCalendarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return label
    }()

    private lazy var exactTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        return label
    }()
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return label
    }()
    
    private lazy var detailPlaceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return label
    }()
    
    private let cellView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.masksToBounds = false
        return vw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupUI()
	}
    
    fileprivate func setupUI() {
        contentView.addSubview(cellView)
        cellView.backgroundColor = .clear
        cellView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                        paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0 )
        
        cellView.addSubview(georgeCalendarLabel)
        cellView.addSubview(IslamicCalendarLabel)
        cellView.addSubview(exactTimeLabel)
        cellView.addSubview(todayLabel)
        cellView.addSubview(detailPlaceLabel)
        
        georgeCalendarLabel.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        georgeCalendarLabel.text = "27 November 2019"
        
        IslamicCalendarLabel.anchor(top: cellView.topAnchor, left: nil, bottom: nil, right: cellView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
        IslamicCalendarLabel.text = "30 Rabiul Awal 1441"
        
        exactTimeLabel.anchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
        exactTimeLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        exactTimeLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        todayLabel.text = "Hari Kamis"
        todayLabel.anchor(top: nil, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 20)
        
        detailPlaceLabel.text = "Kalibata, Kecamatan Pancoran"
        detailPlaceLabel.anchor(top: nil, left: nil, bottom: cellView.bottomAnchor, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 0, height: 20)
    }

	func bind(exactTime: String) {
        exactTimeLabel.text = exactTime
	}
    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

