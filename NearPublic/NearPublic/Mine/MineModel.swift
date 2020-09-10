//
//  MineModel.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class MineModel: NSObject {
	var title:String?
	var iconName:String?
	//构造函数 ---
	open class func mineModel(title:String?,iconName:String?) -> MineModel {
		let mineModel = MineModel()
		mineModel.title = title
		mineModel.iconName = iconName
		return mineModel
	}
	//析构函数
	deinit {
		print("释放")
	}
}
