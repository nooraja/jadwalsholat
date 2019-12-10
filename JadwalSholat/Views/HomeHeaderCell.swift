//
//  HomeHeaderCell.swift
//  ZatWal
//
//  Created by Muhammad Noor on 23/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        return label
    }()

    private lazy var exactTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        return label
    }()
    
    private lazy var detailPlaceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
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
        
        cellView.addSubview(dateLabel)
        cellView.addSubview(exactTimeLabel)
        cellView.addSubview(detailPlaceLabel)
        
        detailPlaceLabel.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        exactTimeLabel.anchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 40)
        exactTimeLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        exactTimeLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        
        dateLabel.anchor(top: nil, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 30)
    }

    func bind(time: String, viewModel: JadwalHeaderViewModel) {
        
        exactTimeLabel.text = time
        detailPlaceLabel.text = viewModel.name
        dateLabel.text = viewModel.date?.toFormatterDate(from: "yyyy-MM-dd", to: "EEEE, d MMMM yyyy")
	}
    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

