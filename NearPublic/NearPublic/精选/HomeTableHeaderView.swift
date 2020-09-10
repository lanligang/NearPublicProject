//
//  HomeTableHeaderView.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UIView {
	lazy var arrowImgView: UIImageView = {
		let imgV = UIImageView()
		imgV.frame.size = CGSize(width: 15, height: 35)
		return imgV
	}()
	lazy var stateLable: UILabel = {
		let l = UILabel()
		l.textColor = .hexInt(0x434343)
		l.textAlignment = .left
		l.text = "下拉刷新"
		l.font = .systemFont(ofSize: 15)
		l.sizeToFit()
		return l
	}()
	lazy var animationView: UIActivityIndicatorView = {
		let atv = UIActivityIndicatorView()
		atv.color = .gray
		atv.frame.size = CGSize(width: 20, height: 20)
		return atv
	}()
	//主要用于监听状态变化
	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(arrowImgView) //箭头的图片
		addSubview(stateLable)   //状态的标签
		arrowImgView.image = Bundle.mj_arrowImage()
		arrowImgView.tintColor = .gray
		addSubview(animationView)
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		let h = self.frame.height
		let w = self.frame.width
		var c = arrowImgView.center
		c.y = h - 25
		stateLable.sizeToFit()
		stateLable.center = CGPoint(x: w/2.0,y: c.y)
		c.x = stateLable.frame.origin.x - (10 + 5)
		arrowImgView.center = c
		animationView.center = arrowImgView.center
	}
	//默认闲置状态
	var mj_state:MJRefreshState = .idle {
		didSet{

			switch mj_state {
			case .idle:
				weak var weakSelf = self
				GCD_After(time: 0.2) {
					weakSelf?.changeNormalState()
				}
				break
			case .pulling:
				stateLable.text = "松手刷新"
				arrowImgView.isHidden = false
				UIView.animate(withDuration: 0.2) {
					self.arrowImgView.transform = CGAffineTransform(rotationAngle: -.pi)
				}
				break
			case .refreshing:
				arrowImgView.isHidden = true
				stateLable.text = "加载中..."
				animationView.startAnimating()
				break
			case .willRefresh:
				stateLable.text = "加载中..."
				break
			case .noMoreData:
				break
			default:
				break

			}
		}
	}

	//修改至闲置状态
	func changeNormalState()  {
		stateLable.text = "松手刷新"
		arrowImgView.isHidden = false
		UIView.animate(withDuration: 0.2) {
			self.arrowImgView.transform = CGAffineTransform(rotationAngle: 0.01)
		}
		animationView.stopAnimating()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
