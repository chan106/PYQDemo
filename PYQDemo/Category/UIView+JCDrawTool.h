//
//  UIView+JCDrawTool.h
//  Zebra
//
//  Created by 奥赛龙-Guo.JC on 2016/11/2.
//  Copyright © 2016年 奥赛龙科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JCDrawTool)
/**
 *  画多重圆弧
 *
 *  @param ctx          上下文
 *  @param r            半径
 *  @param anglePercent 角度
 *  @param red          红色值
 *  @param green        绿色值
 *  @param blue         蓝色值
 *  @param colorValue   颜色过渡值
 *  @param multiple     颜色过渡倍数
 */
-(void)drawMoreArc:(CGContextRef)ctx
              rect:(CGRect)rect
            radius:(NSInteger)r
      anglePercent:(double)anglePercent
         lineWidth:(float)width
          redValue:(double)red
        greenValue:(double)green
         blueValue:(double)blue
        colorValue:(double)colorValue
     colorMultiple:(NSInteger)multiple;


/**
 *  画直线
 *
 *  @param startPoint          起点
 *  @param endPoint            终点
 *  @param lineColor           颜色
 *  @param lineWidth           线宽
 */
- (CAShapeLayer *)drawLineStartPoint:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint
                           lineColor:(UIColor*)lineColor
                           lineWidth:(CGFloat)lineWidth;

/**
 *  画直线
 *
 *  @param startPoint          起点
 *  @param endPoint            终点
 *  @param lineColor           颜色
 *  @param lineWidth           线宽
 */
- (void)drawLineWithStartPoint:(CGPoint)startPoint
                        endPoint:(CGPoint)endPoint
                       lineColor:(UIColor*)lineColor
                       lineWidth:(CGFloat)lineWidth;




/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 ** startPoint:     起点
 ** endPoint:       终点
 **/
- (void)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           lineColor:(UIColor *)lineColor
          startPoint:(CGPoint)startPoint
            endPoint:(CGPoint)endPoint;



/**
 *  画圆饼
 *
 *  @param center              圆心点
 *  @param radius              半径
 *  @param startAngle          起始弧度
 *  @param endAngle            结束弧度
 *  @param clockwise           方向
 *  @param color               颜色
 */
- (void)drawCircleWithCenter:(CGPoint)center
                      radius:(NSInteger)radius
                  startAngle:(CGFloat)startAngle
                    endAngle:(CGFloat)endAngle
                   clockwise:(BOOL)clockwise
                       color:(UIColor *)color;

/*!
 *  画圆饼
 *
 *  @param center              圆心点
 *  @param radius              半径
 *  @param startAngle          起始弧度
 *  @param endAngle            结束弧度
 *  @param clockwise           方向
 *  @param color               颜色
 *  @param width               弧宽度
 */
- (void)drawArcWithCenter:(CGPoint)center
                   radius:(NSInteger)radius
               startAngle:(CGFloat)startAngle
                 endAngle:(CGFloat)endAngle
                clockwise:(BOOL)clockwise
                    color:(UIColor *)color
                lineWidth:(CGFloat)width;

/**
 画圆饼
 */
- (void)drawCirclePieWithCenter:(CGPoint)center
                         radius:(NSInteger)radius
                          color:(UIColor *)color;

/**
 * @brief  截屏
 * @return 截屏图像
 */
- (UIImage *)screenShot;

/**
 * @brief          将图片保存至系统相册
 * @param image    图片
 *
 */
- (void)saveImageToSystem:(UIImage *)image;

@end
