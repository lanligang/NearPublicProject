//
//  ProtocolFile.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import Foundation

@objc protocol SendActionProtocol  {
	//发送消息事件 message  消息内容 tag 事件消息标记
	@objc optional  func sendActionMessage(message:Any?,tag:Int)
}

//继承指定协议 ---
extension UIViewController : SendActionProtocol,CyMenuControllerProtocol {
	//CyMenuControllerProtocol 协议返回控制器
	public func controller() -> UIViewController {
		return self
	}
}
