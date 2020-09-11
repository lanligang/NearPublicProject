//
//  FoodPageTableViewCell.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/11.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class FoodPageTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return foodUrls.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageFoodItem
		item.foodImageView.sd_setImage(with: URL(string: foodUrls[indexPath.row])!, completed: nil)
		item.backgroundColor = .radColor()
		item.layer.cornerRadius = 10.f_pt
		item.clipsToBounds = true
		return item
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let brower = CyImageBrowser.cyImageBrower()
		let infos = CyBrowerInfos()
		infos.currentIndex = indexPath.row
		var temArray = [CyBrowerInfo]()
		for i in 0..<foodUrls.count  {
			let info = CyBrowerInfo()
			info.image = foodUrls[i]
			let item:PageFoodItem? =  collectionView.cellForItem(at: IndexPath(row: i, section: indexPath.section)) as? PageFoodItem
			info.showView = item?.foodImageView
			temArray.append(info)
		}
		infos.items = temArray
		brower.show(infos)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	let foodUrls = [
		"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2291605549,2231893190&fm=26&gp=0.jpg",
		"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599825944402&di=8a002b86359561a1753882bb8a6a84b7&imgtype=0&src=http%3A%2F%2Fimage.liuxue360.com%2F2014%2F08%2F13%2F20140813140818488.jpg",
		"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1909264746,3563911558&fm=26&gp=0.jpg",
		"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3290486319,667432706&fm=26&gp=0.jpg",
		"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599825944402&di=f8229ef964cd6fe2d3e6cee9a8094f8d&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140424%2F208420_084303859000_2.jpg",
		"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3064125582,1517226906&fm=26&gp=0.jpg"
	]

	lazy var pageView: UICollectionView = {
		let flowLayout = PageFlowLayout()
		flowLayout.itemSize = CGSize(width:screen_width * 0.8, height: 300.f_pt)
		flowLayout.minimumInteritemSpacing = 0.f_pt
		flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20.f_pt, bottom: 0, right: 20.f_pt)
		flowLayout.minimumLineSpacing = 15.f_pt
		let collectionV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionV.backgroundColor = .hexInt(0xffffff)
		collectionV.showsHorizontalScrollIndicator = false
		collectionV.register(PageFoodItem.self, forCellWithReuseIdentifier: "cell")
		return collectionV
	}()
	lazy var titleLable: UILabel = {
		let lable = UILabel()
		lable.text = "今日热点推荐"
		lable.font = .boldSystemFont(ofSize: 32.f_pt)
		lable.textColor = .hexInt(0x434343)
		lable.textAlignment = .left
		return lable
	}()

	lazy var iconImgV: UIImageView = {
		let imgV = UIImageView()
		imgV.layer.borderColor = UIColor.hexInt(0x3c74f1).cgColor
		imgV.layer.borderWidth  = 2.0
		imgV.layer.cornerRadius = 10.f_pt
		imgV.backgroundColor = .hexInt(0xffffff)
		imgV.clipsToBounds = true
		return imgV
	}()


	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.addSubview(pageView)
		contentView.addSubview(titleLable)
		contentView.addSubview(iconImgV)

		pageView.delegate = self
		pageView.dataSource = self

		titleLable.snp.makeConstraints { (make) in
			make.left.equalTo(iconImgV.snp_right).offset(15.f_pt)
			make.centerY.equalTo(iconImgV)
			make.height.equalTo(40.f_pt)
		}

		pageView.snp.makeConstraints { (make) in
			make.left.equalTo(0)
			make.right.equalTo(0)
			make.top.equalTo(titleLable.snp_bottom).offset(20.f_pt)
			make.bottom.equalTo(-10.f_pt)
			make.height.equalTo(300.f_pt)
		}
		iconImgV.snp.makeConstraints { (make) in
			make.left.equalTo(15.f_pt)
			make.top.equalTo(30.f_pt)
			make.width.height.equalTo(20.f_pt)
		}
	}
}

class PageFoodItem: UICollectionViewCell {
	lazy var mask_bgView: UIView = {
		let v = UIView()
		v.backgroundColor = UIColor.hexInt(0xffffff).withAlphaComponent(0.9)
		contentView.addSubview(v)
		return v
	}()

	lazy var foodImageView: UIImageView = {
		let imgV = UIImageView()
		imgV.contentMode = .scaleAspectFill
		return imgV
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		mask_bgView.snp.makeConstraints { (make) in
			make.edges.equalTo(UIEdgeInsets.zero)
		}

		contentView.addSubview(foodImageView)
		foodImageView.snp.makeConstraints { (make) in
			make.edges.equalTo(UIEdgeInsets.zero)
		}

		let bottomV = UIView()
		bottomV.backgroundColor = UIColor.black.withAlphaComponent(0.4)
		contentView.addSubview(bottomV)
		bottomV.snp.makeConstraints { (make) in
			make.bottom.equalTo(0)
			make.left.right.equalTo(0)
			make.height.equalTo(60.f_pt)
		}

		let titleLable = UILabel()
		titleLable.text = "大盘鸡盖面特惠装……"
		titleLable.textColor = .white
		titleLable.font = .systemFont(ofSize: 30.f_pt)
		titleLable.textAlignment = .left
		bottomV.addSubview(titleLable)
		titleLable.snp.makeConstraints { (make) in
			make.edges.equalTo(UIEdgeInsets(top: 0, left: 10.f_pt, bottom: 0, right: 0))
		}
		foodImageView.sd_setImage(with: URL(string: "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2291605549,2231893190&fm=26&gp=0.jpg"), completed: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}




