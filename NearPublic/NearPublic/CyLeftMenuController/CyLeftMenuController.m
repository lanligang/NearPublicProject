//
//  CyLeftMenuController.m
//  SwiftDemo
//
//  Created by ios2 on 2020/9/7.
//  Copyright © 2020 lg. All rights reserved.
//

#import "CyLeftMenuController.h"

#define CYSCREENWIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)
#define CYSCREENHEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define CY_MAX_OPEN  self.maxWidth

@interface CyLeftMenuController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)id <CyMenuControllerProtocol> left;

@property (nonatomic,strong)id <CyMenuControllerProtocol> main;

@property (nonatomic,strong)UIView *panMaskView;     //滑动的遮罩
@property(nonatomic,assign)BOOL isOpen;              //是否是展开状态
@property(nonatomic,assign)CGPoint mainStartPoint;  //Main启动的点
@property(nonatomic,assign)CGPoint leftStartPoint;  //开始的位置
@property(nonatomic,assign)CGFloat maxWidth;        //最大宽度
@property (nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation CyLeftMenuController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.automaticallyAdjustsScrollViewInsets = NO;

	__weak typeof(self) weakSelf = self;

	void(^callBack)(BOOL isOpen) = ^(BOOL isPpen){
		if (isPpen) {
			if([weakSelf userShouldBegainMove]){
				[weakSelf viewWillOpenAction];
			}
		}else{
			[weakSelf viewWillCloseAction];
		}
		[weakSelf showOpenOrClose:isPpen];//外部调用内部函数
	};

	if([self.left respondsToSelector:@selector(openCloseCallBack:)]){
		[self.left openCloseCallBack:callBack]; //回调外部
	}

	if ([self.main respondsToSelector:@selector(openCloseCallBack:)]) {
		[self.main openCloseCallBack:callBack];//回调外部
	}

	NSAssert([self.left respondsToSelector:@selector(controller)], @"请检查协议方法是否实现 controller");
	NSAssert([self.main respondsToSelector:@selector(controller)], @"请检查协议方法是否实现 controller");

	[self loadLeftAndRightView];

	[self addPanGesture];
}

-(void)loadLeftAndRightView
{
	UIViewController * leftVc = [self.left controller];
	UIViewController * mainVc = [self.main controller];

	[self addChildViewController:mainVc];
	[self addChildViewController:leftVc];

    //将左侧添加上来
	[self.view addSubview:leftVc.view];
	[self.view addSubview:mainVc.view];

	mainVc.view.frame = CGRectMake(0, 0, CYSCREENWIDTH, CYSCREENHEIGHT);
	leftVc.view.frame = CGRectMake(-CY_MAX_OPEN/2.0, 0, CYSCREENWIDTH, CYSCREENHEIGHT);
	//在这里添加 遮罩View
	[mainVc.view addSubview:self.panMaskView];
	self.panMaskView.frame = (CGRect){0,0,CYSCREENWIDTH,CYSCREENHEIGHT};
	[mainVc.view bringSubviewToFront:self.panMaskView];
}

-(void)addPanGesture
{
	UIPanGestureRecognizer *panGusture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onPanGesture:)];
	panGusture.delegate = self;
	panGusture.maximumNumberOfTouches = 1;
	[self.view addGestureRecognizer:panGusture];
	self.pan = panGusture;
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
	if (!self.isOpen) {
		CGPoint p = [gestureRecognizer locationInView:self.view];
		if (p.x > 35) {
			return NO;
		}
		if ([self.main respondsToSelector:@selector(isCanBegainMove)]) {
			BOOL iscanMove =  [self.main isCanBegainMove];
			return iscanMove;
		}

		if ([self.left respondsToSelector:@selector(isCanBegainMove)]){
			BOOL iscanMove = [self.left isCanBegainMove];
			return iscanMove;
		}
	}
	
	return YES;
}
//滑动手势启动
-(void)onPanGesture:(UIPanGestureRecognizer *)pan
{
	CGPoint p = [pan translationInView:self.view];
	UIViewController *mainVc =  [self.main controller];
	UIViewController *leftVc = [self.left controller];
	if (pan.state == UIGestureRecognizerStateBegan) {
		self.mainStartPoint = mainVc.view.frame.origin;
		self.leftStartPoint = leftVc.view.frame.origin;
		self.panMaskView.hidden = NO;
		if (!self.isOpen) {
		   [self viewWillOpenAction];
		}else{
			[self viewWillCloseAction];
		}
	}
	CGRect mRect = mainVc.view.frame;
	CGRect lRect = leftVc.view.frame;
	mRect.origin.x = self.mainStartPoint.x + p.x;
	lRect.origin.x = self.leftStartPoint.x + p.x/2.0;
	if (mRect.origin.x > CY_MAX_OPEN) {
		mRect.origin.x = CY_MAX_OPEN;
		lRect.origin.x = 0;
		self.mainStartPoint = mRect.origin;
		self.leftStartPoint = lRect.origin;
	}

	if (mRect.origin.x < 0) {
		mRect.origin.x = 0;
		lRect.origin.x = - CY_MAX_OPEN/2.0;
		self.mainStartPoint = mRect.origin;
	}
	mainVc.view.frame = mRect;
	leftVc.view.frame = lRect;
	CGFloat alpha  = mRect.origin.x / CY_MAX_OPEN;
	self.panMaskView.alpha = alpha;
	if (pan.state == UIGestureRecognizerStateEnded||
		pan.state == UIGestureRecognizerStateCancelled) {
		if (mainVc.view.frame.origin.x > CY_MAX_OPEN /2.0) {
			[self showOpenOrClose:YES];
		}else{
			[self showOpenOrClose:NO];
		}
	}
}

-(BOOL)userShouldBegainMove
{
	if ([self.main respondsToSelector:@selector(isCanBegainMove)]) {
		return [self.main isCanBegainMove];
	}

	if ([self.left respondsToSelector:@selector(isCanBegainMove)]){
		return [self.left isCanBegainMove];
	}
	return YES;

}

//是否将要开启
-(void)viewWillOpenAction
{
	[self.view insertSubview:[self.left controller].view atIndex:0];
	
	if ([self.left respondsToSelector:@selector(viewWillOpen)]) {
		[self.left viewWillOpen];
	}
	if ([self.main respondsToSelector:@selector(viewWillOpen)]) {
		[self.main viewWillOpen];
	}
}
//是否将要开启
-(void)viewWillCloseAction
{
	if ([self.left respondsToSelector:@selector(viewWillClose)]) {
		[self.left viewWillClose];
	}
	if ([self.main respondsToSelector:@selector(viewWillClose)]) {
		[self.main viewWillClose];
	}
}
//是否显示展开
-(void)showOpenOrClose:(BOOL)isOpen {

	if (![self userShouldBegainMove]) return;

	UIViewController *leftVc = [self.left controller];

	UIViewController *mainVc = [self.main controller];

	CGRect leftEndFrame = isOpen ? (CGRect){0,0,leftVc.view.frame.size}:(CGRect){-CY_MAX_OPEN/2.0,0,leftVc.view.frame.size};

	CGRect mainEndFrame = isOpen ? (CGRect){CY_MAX_OPEN,0,mainVc.view.frame.size}:(CGRect){0,0,mainVc.view.frame.size};

	self.panMaskView.hidden = NO;

	[UIView animateWithDuration:0.3 animations:^{

		leftVc.view.frame = leftEndFrame;

		mainVc.view.frame = mainEndFrame;

		self.panMaskView.alpha = isOpen?1.0:0.0;

	} completion:^(BOOL finished) {

		if (isOpen && self.isOpen == NO) {
			if ([self.left respondsToSelector:@selector(viewDidOpen)]) {
				[self.left viewDidOpen];
			}
			if ([self.main respondsToSelector:@selector(viewDidOpen)]) {
				[self.main viewDidOpen];
			}
		}else if(isOpen == NO && self.isOpen){
			if ([self.left respondsToSelector:@selector(viewDidClose)]) {
				[self.left viewDidClose];
			}
			if ([self.main respondsToSelector:@selector(viewDidClose)]) {
				[self.main viewDidClose];
			}
			[[self.left controller].view removeFromSuperview];
		}
		self.panMaskView.hidden = isOpen?NO:YES;
		self.isOpen = isOpen;
	}];

}

#pragma mark - Lazy load
-(UIView *)panMaskView {
	if (!_panMaskView) {
		_panMaskView = [[UIView alloc]init];
		_panMaskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.65];
		_panMaskView.frame = self.view.bounds;
		_panMaskView.hidden = YES;
		UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
		[_panMaskView addGestureRecognizer:closeTap];
		[self.view addSubview:_panMaskView];
	 }
	[_panMaskView.superview bringSubviewToFront:_panMaskView];
	return _panMaskView;
}
-(void)onTapAction:(UIGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateEnded) {
		[self viewWillCloseAction];
		[self showOpenOrClose:NO];
	}
}

#pragma mark - open method
+(instancetype)leftController:(id <CyMenuControllerProtocol>)left
			andMainController:(id <CyMenuControllerProtocol>)main
			  andLeftMaxWidth:(CGFloat)maxWidth {

	CyLeftMenuController *menuVc = [[CyLeftMenuController alloc]initWithLeftController:left andMainController:main andLeftMaxWidth:maxWidth];

	return menuVc;
}
-(instancetype)initWithLeftController:(id<CyMenuControllerProtocol>)left
andMainController:(id<CyMenuControllerProtocol>)main
  andLeftMaxWidth:(CGFloat)maxWidth {
	self = [super init];
	if (self) {
		self.left = left;
		self.main = main;
		self.maxWidth = maxWidth;
	}
	return self;
}
#pragma mark - 不能转屏

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationPortrait;
}

@end




