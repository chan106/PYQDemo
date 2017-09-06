//
//  UIView+JCDrawTool.m
//  Zebra
//
//  Created by 奥赛龙-Guo.JC on 2016/11/2.
//  Copyright © 2016年 奥赛龙科技. All rights reserved.
//

#import "UIView+JCDrawTool.h"

@implementation UIView (JCDrawTool)
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
     colorMultiple:(NSInteger)multiple{
    //1.第一个圆
    CGContextAddArc(ctx, rect.size.width/2, rect.size.height/2, r, -M_PI_2, -M_PI_2+anglePercent*M_PI*2, 0);
    
    CGContextSetLineWidth(ctx, width);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, red/255.0, green/255.0, blue/255.0, 1);
    // 渲染一次
    CGContextStrokePath(ctx);
    
    //2.弧度比大于1，第二个圆
    if (anglePercent>=1) {
        
        CGContextAddArc(ctx, rect.size.width/2, rect.size.height/2, r, -M_PI_2,  -M_PI_2+(anglePercent-1)*M_PI*2, 0);
        
        CGContextSetLineWidth(ctx, width+2);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        // 设置画笔颜色
//        if(colorValue>=kFirstRound&&colorValue<kSecondRound) {
//            CGContextSetRGBStrokeColor(ctx, red, (green-(colorValue-kFirstRound)*multiple)/255.0, blue/255.0, 1);
//        }else{
            CGContextSetRGBStrokeColor(ctx, red, (green-12*multiple)/255.0, blue/255.0, 1);
//        }
        
    }
    
    // 3.显示所绘制的东西
    CGContextStrokePath(ctx);
}

#pragma mark 绘制直线
- (void)drawLineStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{

    //提示 使用ref的对象不用使用*
    //1.获取上下文.-UIView对应的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.创建可变路径并设置路径
    //当我们开发动画的时候，通常制定对象运动的路线，然后由动画负责动画效果
    CGMutablePathRef path = CGPathCreateMutable();
    //2-1.设置起始点
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    //2-2.设置目标点
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    CGPathAddLineToPoint(path, NULL, 50, 200);
    //封闭路径
    //第一种方法
    //CGPathAddLineToPoint(path, NULL, 50, 50);
    //第二张方法
    CGPathCloseSubpath(path);
    //3.将路径添加到上下文
    CGContextAddPath(context, path);
    //4.设置上下文属性
    //4.1.设置线条颜色
    /*
     red 0～1.0  red / 255
     green 0～1.0  green / 255
     blue 0～1.0  blue / 255
     plpha   透明度  0 ～ 1.0
     0 完全透明
     1.0 完全不透明
     提示：在使用rgb设置颜色时。最好不要同时指定rgb和alpha,否则会对性能造成影响。
     
     线条和填充默认都是黑色
     */
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
    //设置填充颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1.0);
    //4.2 设置线条宽度
    CGContextSetLineWidth(context, 3.0f);
    //设置线条顶点样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置连接点的样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //设置线条的虚线样式
    /*
     虚线的参数：
     phase：相位，虚线的起始位置＝通常使用 0 即可，从头开始画虚线
     lengths:长度的数组
     count ： lengths 数组的个数
     */
    CGFloat lengths[2] = {20.0,10.0};
    CGContextSetLineDash(context, 0, lengths, 3);
    //5.绘制路径
    /*
     kCGPathStroke:划线（空心）
     kCGPathFill: 填充（实心）
     kCGPathFillStroke：即划线又填充
     */
    CGContextDrawPath(context, kCGPathFillStroke);
    //6.释放路径
    CGPathRelease(path);
    
}

- (CAShapeLayer *)drawLineStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)color lineWidth:(CGFloat)lineWidth{
    
    //画线
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[color CGColor]];
    [solidShapeLayer setStrokeColor:[color CGColor]];
    solidShapeLayer.lineWidth = lineWidth ;
    CGPathMoveToPoint(solidShapePath, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(solidShapePath, NULL, endPoint.x,endPoint.y);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    return solidShapeLayer;
}

- (void)drawLineWithStartPoint:(CGPoint)startPoint
                        endPoint:(CGPoint)endPoint
                       lineColor:(UIColor *)lineColor
                       lineWidth:(CGFloat)lineWidth{
    //画线
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[lineColor CGColor]];
    [solidShapeLayer setStrokeColor:[lineColor CGColor]];
    solidShapeLayer.lineWidth = lineWidth ;
    CGPathMoveToPoint(solidShapePath, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(solidShapePath, NULL, endPoint.x,endPoint.y);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.layer addSublayer:solidShapeLayer];
}


/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL,endPoint.x, endPoint.y);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)drawCircleWithCenter:(CGPoint)center
                      radius:(NSInteger)radius
                  startAngle:(CGFloat)startAngle
                    endAngle:(CGFloat)endAngle
                   clockwise:(BOOL)clockwise
                       color:(UIColor *)color{

    //路径初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    //一个圆得路径
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    //建层，将填充颜色，描边颜色，路径，赋值
    CAShapeLayer *arcLayer=[CAShapeLayer layer];
    arcLayer.path = path.CGPath;//46,169,230
    arcLayer.fillColor = color.CGColor;
//    arcLayer.strokeColor = color.CGColor;
//    arcLayer.lineWidth = 3;
//    arcLayer.frame = CGRectMake(0, 0, radius, radius);
    //将新建的层加到父视图的层里
    [self.layer addSublayer:arcLayer];

}

- (void)drawCirclePieWithCenter:(CGPoint)center
                         radius:(NSInteger)radius
                          color:(UIColor *)color{
    
    UIView *arcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, radius, radius)];
    arcView.center = center;
    arcView.layer.cornerRadius = 0.5*radius;
    arcView.layer.masksToBounds = YES;
    arcView.backgroundColor = color;
    [self addSubview:arcView];
}


- (void)drawArcWithCenter:(CGPoint)center
                      radius:(NSInteger)radius
                  startAngle:(CGFloat)startAngle
                    endAngle:(CGFloat)endAngle
                   clockwise:(BOOL)clockwise
                       color:(UIColor *)color
                   lineWidth:(CGFloat)width
{
    
    //路径初始化
    UIBezierPath *path=[UIBezierPath bezierPath];
    //一个圆得路径
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    //建层，将填充颜色，描边颜色，路径，赋值
    CAShapeLayer *arcLayer=[CAShapeLayer layer];
    arcLayer.path = path.CGPath;//46,169,230
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = color.CGColor;
    arcLayer.lineWidth = width;
    arcLayer.frame = self.frame;
    //将新建的层加到父视图的层里
    [self.layer addSublayer:arcLayer];
    
}


/**
 * @brief  截屏
 * @return 截屏图像
 */
- (UIImage *)screenShot{
    
    //模拟截屏快门,一道白光闪过
    UIView *white = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.rootViewController.view.bounds];
    white.backgroundColor = [UIColor whiteColor];
    white.alpha = 0;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:white];
    [UIView animateWithDuration:.1 animations:^{
        white.alpha = 1;
    } completion:^(BOOL finished) {
        [NSThread sleepForTimeInterval:0.2];
        [UIView animateWithDuration:.6 animations:^{
            white.alpha = 0;
        } completion:^(BOOL finished) {
            [white removeFromSuperview];
        }];
    }];
    
    UIImage* shotImage = nil;
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        shotImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return shotImage;
}

/**
 * @brief          将图片保存至系统相册
 * @param image    图片
 *
 */
- (void)saveImageToSystem:(UIImage *)image{
    //以下为图片保存代码
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存图片到照片库
    
    NSData *imageViewData = UIImagePNGRepresentation(image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pictureName= @"screenShow.png";
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    
}

@end
