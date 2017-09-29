//
// SXJFWaveAnimationView.m
//  shanxingjinfu
//
//  Created by shanlin on 2017/9/26.
//  Copyright © 2017年 shanxingjinfu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 水波文字
 */
 NSString *const SXJFWaveTextString = @"SXJFWaveTextString";

/**
 * 水波文字字体
 */
 NSString *const SXJFWaveTextFontSize = @"SXJFWaveTextFontSize";

/**
 * 水波镂空文字颜色
 */
 NSString *const SXJFWaveHollowTextColor = @"SXJFWaveHollowTextColor";

/**
 * 水波底部背景字体颜色
 */
 NSString *const SXJFWaveBottomTextColor = @"SXJFWaveBottomTextColor";

/**
 * 水波顶部背景字体颜色
 */
 NSString *const SXJFWaveTopTextColor = @"SXJFWaveTopTextColor";

/**
 * 水波镂空边框颜色
 */
 NSString *const SXJFWaveHollowBorderColor = @"SXJFWaveHollowBorderColor";

/**
 * 水波底部边框颜色
 */
 NSString *const SXJFWaveBottomBorderColor = @"SXJFWaveBottomBorderColor";

/**
 * 水波顶部边框颜色
 */
 NSString *const SXJFWaveTopBorderColor = @"SXJFWaveTopBorderColor";

/**
 * 水波镂空背景颜色
 */
 NSString *const SXJFWaveHollowBackgroundColor = @"SXJFWaveHollowBackgroundColor";

/**
 * 水波底部背景颜色
 */
 NSString *const SXJFWaveBottomBackgroundColor = @"SXJFWaveBottomBackgroundColor";

/**
 * 水波顶部背景颜色
 */
 NSString *const SXJFWaveTopBackgroundColor = @"SXJFWaveTopBackgroundColor";

/**
 * 水波边框宽度
 */
 NSString *const SXJFWaveBorderWidth = @"SXJFWaveBorderWidth";

/**
 * 水波曲线波动位置类型
 */
NSString *const SXJFWaveCurveHeightPosition = @"SXJFWaveCurveHeightPosition";


/**
 *  正弦曲线公式：y=Asin(ωx+φ)+k
 *A :振幅,曲线最高位和最低位的距离
 *ω :角速度,用于控制周期大小，单位x中起伏的个数
 *K :偏距,曲线上下偏移量
 *φ :初相,曲线左右偏移量
 */
#import "SXJFWaveAnimationView.h"
@interface SXJFWaveAnimationView(){
    
    UILabel *topLabel;//最表面层文字
    UILabel *bottomLabel;//底面层名称文字
    UILabel *hollowLabel;//用来实现两条波浪线交叉镂空效果
    CGFloat waveSpeed;//控制水波起伏
    CGFloat amplitudeA; //振幅
    CGFloat waveWidth; //水波宽度
    CAShapeLayer *topLayer;//最表面图层
    CAShapeLayer *bottomLayer;//底面图层
    CGFloat offsetX,offsetYK;//控制偏移
    CADisplayLink *displayLink; //定时器
    
}
@end
@implementation SXJFWaveAnimationView
- (instancetype)initWithFrame:(CGRect)frame waveConfigures:(NSDictionary *)configureDict{
    
    if (self = [super initWithFrame:frame]) {
        
        NSString *textString  = [configureDict objectForKey:SXJFWaveTextString];
        CGFloat fontSize = [[configureDict objectForKey:SXJFWaveTextFontSize] doubleValue];
        CGRect textRect = [textString boundingRectWithSize:CGSizeMake(MAXFLOAT, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]} context:nil];
        CGFloat  width = MAX(textRect.size.height, textRect.size.width)+24;
        
        SXJFWaveCurveFluctuationPositionType  positionType  = [[configureDict objectForKey:SXJFWaveCurveHeightPosition] integerValue];
        CGFloat persent = 0.0;
        switch (positionType) {
            case SXJFWaveCurveFluctuationPositionType_Top:
                persent = 4.0;
                break;
            case SXJFWaveCurveFluctuationPositionType_Center:
                persent = 2.0;
                break;
            case SXJFWaveCurveFluctuationPositionType_Bottom:
                persent = 1.5;
                break;
            case SXJFWaveCurveFluctuationPositionType_Full:
                persent = 10.0;
                break;
            default:
                persent = 2.0;
                break;
        }

        waveWidth = width;
        amplitudeA = 6;
        //用来控制水波高度的
        offsetYK = width/persent;
        waveSpeed = 6.f;
        //两条波浪线交叉镂空label
        hollowLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-width)/2, (frame.size.height-width)/2-(100/2.0), width, width)];
        hollowLabel.textColor = [configureDict objectForKey:SXJFWaveHollowTextColor]?:[UIColor lightGrayColor];
        hollowLabel.text = textString;
        hollowLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        hollowLabel.backgroundColor = [configureDict objectForKey:SXJFWaveHollowBackgroundColor]?:[UIColor redColor];
        
        hollowLabel.textAlignment = NSTextAlignmentCenter;
        hollowLabel.layer.masksToBounds = YES;
        hollowLabel.layer.cornerRadius = width/2.0;
        hollowLabel.layer.borderWidth = [[configureDict objectForKey:SXJFWaveBorderWidth] doubleValue];
        UIColor *hwcolor = (UIColor *)[configureDict objectForKey:SXJFWaveHollowBorderColor];
        hollowLabel.layer.borderColor = hwcolor.CGColor?:[UIColor redColor].CGColor;
        [self addSubview:hollowLabel];
        
        //底部label
        bottomLabel = [[UILabel alloc] initWithFrame:hollowLabel.frame];
        bottomLabel.textColor = [configureDict objectForKey:SXJFWaveBottomTextColor]?:[UIColor whiteColor];
        bottomLabel.text = textString;
        bottomLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        bottomLabel.backgroundColor = [configureDict objectForKey:SXJFWaveBottomBackgroundColor]?:[UIColor blueColor];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.layer.masksToBounds = YES;
        bottomLabel.layer.cornerRadius = width/2.0;
        bottomLabel.layer.borderWidth = [[configureDict objectForKey:SXJFWaveBorderWidth] doubleValue];
        UIColor *btmcolor = (UIColor *)[configureDict objectForKey:SXJFWaveBottomBorderColor];
        bottomLabel.layer.borderColor = btmcolor.CGColor?:[UIColor redColor].CGColor;
        [self addSubview:bottomLabel];
        
        //顶部label
        topLabel = [[UILabel alloc] initWithFrame:hollowLabel.frame];
        topLabel.textColor = [configureDict objectForKey:SXJFWaveTopTextColor]?:[UIColor redColor];
        topLabel.text = textString;
        topLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        topLabel.backgroundColor = [configureDict objectForKey:SXJFWaveTopBackgroundColor]?:[UIColor blueColor];
        topLabel.textAlignment = NSTextAlignmentCenter;
        topLabel.layer.masksToBounds = YES;
        topLabel.layer.borderWidth = [[configureDict objectForKey:SXJFWaveBorderWidth] doubleValue];
        topLabel.layer.cornerRadius = width/2.0;
        UIColor *topcolor = (UIColor *)[configureDict objectForKey:SXJFWaveTopBorderColor];
        topLabel.layer.borderColor = topcolor.CGColor?:[UIColor redColor].CGColor;
        [self addSubview:topLabel];
        
        
        //贝塞尔曲线绘制
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, textRect.size.height/2)];
        [path addLineToPoint:CGPointMake(textRect.size.width, textRect.size.height/2)];
        [path addLineToPoint:CGPointMake(textRect.size.width, textRect.size.height)];
        [path addLineToPoint:CGPointMake(0, textRect.size.height)];
        [path closePath];
    
        topLayer = [CAShapeLayer layer];
        topLayer.frame = bottomLabel.bounds;
        topLayer.path = path.CGPath;

        
        bottomLayer = [CAShapeLayer layer];
        bottomLayer.frame = bottomLabel.bounds;
        bottomLayer.path = path.CGPath;
        
        //设置mask图层
        topLabel.layer.mask = topLayer;
        bottomLabel.layer.mask = bottomLayer;
        
   
        [self startWaveTimer];
        
    }
    
    
    return self;
}
- (void)startWaveTimer{
    if (!displayLink) {
        
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
}
- (void)waveAnimation{
    
    //改变角速度
    offsetX+=waveSpeed;
    //设置第一条波曲线的路径
    CGMutablePathRef pathRefOne = CGPathCreateMutable();
    CGFloat startY = amplitudeA*sin(offsetX*M_PI/waveWidth)+offsetYK;
    CGPathMoveToPoint(pathRefOne, NULL, 0, startY);
    
    for (CGFloat i=0.0; i<waveWidth; i++) {
        
        CGFloat y = 1*amplitudeA*sinf(2*M_PI*i/waveWidth + offsetX*M_PI/waveWidth) + offsetYK;
        CGPathAddLineToPoint(pathRefOne, NULL, i, y);
        
    }
    CGPathAddLineToPoint(pathRefOne, NULL, waveWidth, 0);
    CGPathAddLineToPoint(pathRefOne, NULL, 0, 0);
    CGPathCloseSubpath(pathRefOne);
    topLayer.path = pathRefOne;
    topLayer.fillColor = [UIColor lightGrayColor].CGColor;
    CGPathRelease(pathRefOne);
    
    
    //设置第二条波曲线的路径
    CGMutablePathRef pathRefTwo = CGPathCreateMutable();
    CGFloat startY2 = amplitudeA*sinf(offsetX*M_PI/waveWidth + M_PI/3)+offsetYK;
    CGPathMoveToPoint(pathRefTwo, NULL, 0, startY2);
    //第二个波曲线的公式
    for (CGFloat j = 0.0; j < waveWidth; j ++) {
        CGFloat y = 1*amplitudeA*sinf(2*M_PI*j/waveWidth + offsetX*M_PI/waveWidth + M_PI/3) + offsetYK;
        CGPathAddLineToPoint(pathRefTwo, NULL, j, y);
    }
    
    CGPathAddLineToPoint(pathRefTwo, NULL, waveWidth, bottomLabel.frame.size.height);
    CGPathAddLineToPoint(pathRefTwo, NULL, 0, bottomLabel.frame.size.height);
    CGPathCloseSubpath(pathRefTwo);
    bottomLayer.path = pathRefTwo;
    bottomLayer.fillColor = [UIColor blackColor].CGColor;
    CGPathRelease(pathRefTwo);
    
}
- (void)stopRemoveWaveAnimation
{
    [displayLink invalidate];
    displayLink = nil;
    if (self) {
        [self removeFromSuperview];
    }
   
}

@end
