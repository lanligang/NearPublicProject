//
//  ColorTool.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit
extension UIColor {
	//使用 0xffffff 为白色 0x000000 为 黑色
	class open func hexInt(_ hex:Int) -> UIColor {
		return UIColor.init(red: CGFloat((hex & 0xff0000) >> 0x10)/255.0, green: CGFloat((hex & 0x00ff00) >> 0x8)/255.0, blue: CGFloat(hex & 0x0000ff)/255.0, alpha: 1)
	}
	class open func radColor()-> UIColor{
		let hex = arc4random_uniform(0xffffff)
	    return UIColor.init(red: CGFloat((hex & 0xff0000) >> 0x10)/255.0, green: CGFloat((hex & 0x00ff00) >> 0x8)/255.0, blue: CGFloat(hex & 0x0000ff)/255.0, alpha: 1)
	}
}

