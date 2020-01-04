//
//  HomeHeaderCell.swift
//  ZatWal
//
//  Created by Muhammad Noor on 23/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

enum RefreshJadwalTable {
    case didUpdateJadwal
}

class HomeHeaderCell: UITableViewCell {
    
    private var viewModel =  JadwalViewModel(networkModel: JadwalNetworkModel())
    
    //MARK:- Private Property

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
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "refresh") , for: .normal)
        button.tintColor = .black
        return button
    }()
    
    //MARK:- Public Method
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupUI()
	}
    
    func bind(time: String, viewModel: JadwalHeaderViewModel) {
        
        exactTimeLabel.text = time
        detailPlaceLabel.text = viewModel.name
        dateLabel.text = viewModel.date?.toFormatterDate(from: "yyyy-MM-dd", to: "EEEE, d MMMM yyyy")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private Property
    
    fileprivate func setupUI() {
        contentView.addSubview(cellView)
        cellView.backgroundColor = .clear
        cellView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                        paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        cellView.addSubview(detailPlaceLabel)
        detailPlaceLabel.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)

        let stackView = UIStackView(arrangedSubviews: [exactTimeLabel, refreshButton])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(stackView)
        stackView.anchor(top: detailPlaceLabel.bottomAnchor, left: cellView.leftAnchor, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)

        cellView.addSubview(dateLabel)
        dateLabel.anchor(top: stackView.bottomAnchor, left: cellView.leftAnchor, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor, constant: 8).isActive = true
    }
    
    @objc func handleRefresh() {
        viewModel.reloadJadwal()
    }

}
