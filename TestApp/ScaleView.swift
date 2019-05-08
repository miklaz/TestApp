//
//  ScaleView.swift
//  TestApp
//
//  Created by Михаил Зайцев on 07/05/2019.
//  Copyright © 2019 Михаил Зайцев. All rights reserved.
//

import UIKit

@IBDesignable
class ScaleView: UIView {

    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() // 1
        context?.setStrokeColor(UIColor.green.cgColor) // 2
        context?.setLineWidth(7.0) // 3
        context?.addArc(center: CGPoint(x: 375 / 2.2, y: 375 / 2.2), radius: 375 / 2 - 54, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true) // 4
        context?.strokePath() // 5
        
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.addArc(center: CGPoint(x: 375 / 2.2, y: 375 / 2.2), radius: 375 / 4 - 34, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        context?.strokePath()
    }

}
