//
//  StarshipsListCellBackground.swift
//  ZatWal
//
//  Created by Muhammad Noor on 28/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class StarshipsListCellBackground: UIView {
    
    //MARK:- Public Method

	override func draw(_ rect: CGRect) {

		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		let backgroundRect = bounds
		context.drawLinearGradient(
			in: backgroundRect,
			startingWith: UIColor.telegramBlue.cgColor,
			finishingWith: UIColor.telegramWhite.cgColor
		)
	}
}
