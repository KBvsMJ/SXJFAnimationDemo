//
//  SXJFWaveAnimationView.h
//  shanxingjinfu
//
//  Created by shanlin on 2017/9/26.
//  Copyright © 2017年 shanxingjinfu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 水波文字
 */
extern NSString *const SXJFWaveTextString;

/**
 * 水波文字字体大小
 */
 extern NSString *const SXJFWaveTextFontSize;

/**
 * 水波镂空文字颜色
 */
extern NSString *const SXJFWaveHollowTextColor;

/**
 * 水波底部背景字体颜色
 */
extern NSString *const SXJFWaveBottomTextColor;

/**
 * 水波顶部背景字体颜色
 */
extern NSString *const SXJFWaveTopTextColor;

/**
 * 水波镂空边框颜色
 */
extern NSString *const SXJFWaveHollowBorderColor;

/**
 * 水波底部边框颜色
 */
extern NSString *const SXJFWaveBottomBorderColor;

/**
 * 水波顶部边框颜色
 */
extern NSString *const SXJFWaveTopBorderColor;

/**
 * 水波镂空背景颜色
 */
extern NSString *const SXJFWaveHollowBackgroundColor;

/**
 * 水波底部背景颜色
 */
extern NSString *const SXJFWaveBottomBackgroundColor;

/**
 * 水波顶部背景颜色
 */
extern NSString *const SXJFWaveTopBackgroundColor;

/**
 * 水波边框宽度
 */
extern NSString *const SXJFWaveBorderWidth;


/**
 * 水波曲线波动位置类型
 */
extern NSString *const SXJFWaveCurveHeightPosition;

/**
 * 水波曲线波动位置枚举类型
 */
typedef NS_ENUM(NSInteger,SXJFWaveCurveFluctuationPositionType) {
    SXJFWaveCurveFluctuationPositionType_Bottom = 1,
    SXJFWaveCurveFluctuationPositionType_Center = 2,
    SXJFWaveCurveFluctuationPositionType_Top = 3,
    SXJFWaveCurveFluctuationPositionType_Full = 4
};

@interface SXJFWaveAnimationView : UIView





- (instancetype)initWithFrame:(CGRect)frame waveConfigures:(NSDictionary *)configureDict;
- (void)stopRemoveWaveAnimation;
@end
