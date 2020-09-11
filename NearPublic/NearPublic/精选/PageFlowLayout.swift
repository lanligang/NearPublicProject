//
//  PageFlowLayout.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/11.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class PageFlowLayout: UICollectionViewFlowLayout {
	override init() {
		super.init()
		self.scrollDirection = .horizontal
	}

	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
		var rect:CGRect = CGRect.zero
		rect.origin.y = 0
		rect.origin.x = proposedContentOffset.x
		rect.size = collectionView!.frame.size
		let  centerX = proposedContentOffset.x + collectionView!.frame.width * 0.5;
		guard let array = super.layoutAttributesForElements(in: rect) else { return CGPoint.zero }
		var minDelta = CGFloat.greatestFiniteMagnitude
		var current_IndexPath = IndexPath(row: 0, section: 0)
		for  attrs in array {
			if abs(minDelta) > abs(attrs.center.x - centerX) {
				minDelta = attrs.center.x - centerX;             //x 需要偏移多少
				current_IndexPath = attrs.indexPath as IndexPath;
			}
		}
		let  targetPoint = CGPoint(x: proposedContentOffset.x + minDelta, y: proposedContentOffset.y)
		return targetPoint
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
