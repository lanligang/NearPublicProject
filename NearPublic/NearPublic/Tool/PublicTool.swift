//
//  PublicTool.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/9.
//  Copyright © 2020 lg. All rights reserved.
//

import Foundation

//延时执行
public func GCD_After(time:TimeInterval,callBack:@escaping (()->Void)){
	//@escaping  防止闭包 逃逸
	DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: callBack)
}
//异步线程
public func CGD_async(callBack:@escaping (()->Void)){
	let que = DispatchQueue.global(qos: .default)
	que.async(execute: callBack)
}
//回主线程
public func GCD_mainSync(callBack:@escaping(()->Void)){
	DispatchQueue.main.sync(execute: callBack)
}



