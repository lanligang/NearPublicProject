//
//  DeviceTool.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

extension Double {
  public var f_pt : CGFloat {
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    return screenWidth / 750.0 * CGFloat(self)
  }
}
extension Int {
  public var f_pt : CGFloat {
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    return screenWidth / 750.0 * CGFloat(self)
  }
}
extension Float {
  public var f_pt : CGFloat {
    let screenWidth : CGFloat = UIScreen.main.bounds.width
    return screenWidth / 750.0 * CGFloat(self)
  }
}

extension NSObject {
    public var statusHeight: CGFloat {
        // 状态栏高度
        if #available(iOS 13.0, *) {
            for window in UIApplication.shared.windows {
                if window.windowLevel == .normal {
                    return window.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
                }
            }
        }
        return UIApplication.shared.statusBarFrame.height
    }
	public var isIphoneX :Bool {
		var isIphone_X = false
		if UIDevice.current.userInterfaceIdiom != .phone {
			return isIphone_X
		}
		if #available(iOS 11.0, *) {
			let safeArea = UIApplication.shared.windows.first?.safeAreaInsets
			if let bottom = safeArea?.bottom {
				if bottom > 0.0 {
					isIphone_X = true
				}
			}
		}
		return isIphone_X
	}
	public var navBarHeight:CGFloat {
		if isIphoneX {
			return 44.0 + 44.0
		}
		return 20 + 44.0
	}
	public var tabbarHeight:CGFloat {
		return isIphoneX ? 83 : 49
	}
	public var screen_width :CGFloat {
		return UIScreen.main.bounds.width
	}
	public var screen_height : CGFloat {
		return UIScreen.main.bounds.height
	}
}




