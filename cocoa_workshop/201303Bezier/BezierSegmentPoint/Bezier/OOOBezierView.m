//
//  OOOBezierView.m
//  Bezier
//
//  Created by 大森 智史 on 2013/03/03.
//  Copyright (c) 2013年 Satoshi Oomori. All rights reserved.
//

#import "OOOBezierView.h"
#import "OOOPathObject.h"

//PIを3.14...と定義
#define PI 3.14159265358979323846

//関数定義degrees*PI/180がradians
static inline double radians(double degrees) { return degrees * PI / 180; }

@implementation OOOBezierView
CGPoint getPointCB(t,x1,y1,x2,y2,x3,y3,x4,y4) {

    CGFloat tp = (1-t);
    CGFloat x = t*t*t*x4 + 3*t*t*tp*x3 + 3*t*tp*tp*x2 + tp*tp*tp*x1;
    CGFloat y = t*t*t*y4 + 3*t*t*tp*y3 + 3*t*tp*tp*y2 + tp*tp*tp*y1;

    return CGPointMake(x, y);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
     
        

    }
    return self;
}

-(void) timerControl:(NSTimer *)aTimer
{
    //if (currentPosition.y>0){
    [self setNeedsDisplay];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                 target:		self
                                               selector:	@selector( timerControl: )
                                               userInfo:	nil
                                                repeats:	NO];
    
        t = t+0.01;
        //NSLog(@"%f",t);
        if (t>=1){
            t = 0;
            
        };
    
    //}
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //どの指かタッチしたら
    __block NSInteger loopCount = 0;
    [[event allTouches] enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
     {
         //NSLog(@"(%f,%f)",[obj locationInView:self].x,[obj locationInView:self].y);
         touchBegin = CGPointMake([obj locationInView:self].x,[obj locationInView:self].y);
         
         OOOAppDelegate *appDelegate = (OOOAppDelegate *)[[UIApplication sharedApplication] delegate];
         NSMutableArray *pathObjects = [appDelegate pathObjects];
//         UIBezierPath *currentPath = [UIBezierPath bezierPath];
         
         OOOPathObject *pathObj = [pathObjects objectAtIndex: loopCount ];
         
         for (OOOPointObject *pointObj in pathObj.pointArray) {
             NSLog(@"OOOPathObject %d ,%.2f,%.2f",loopCount,pathObj.startPoint.x,pathObj.startPoint.y);
         }
         
         
         loopCount++;
         *stop = YES;
         
         
     }];
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:		self
                                           selector:	@selector( timerControl: )
                                           userInfo:	nil
                                            repeats:	NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    [[event allTouches] enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
     {
         //NSLog(@"(%f,%f)",[obj locationInView:self].x-touchBegin.x,[obj locationInView:self].y-touchBegin.y);
         //currentPosition = CGPointMake([obj locationInView:self].x-touchBegin.x,[obj locationInView:self].y-touchBegin.y);
         
         OOOAppDelegate *appDelegate = (OOOAppDelegate *)[[UIApplication sharedApplication] delegate];
         NSMutableArray *pathObjects = [appDelegate pathObjects];
         OOOPathObject *pathObj = [pathObjects objectAtIndex:0];
         OOOPointObject *pointObj = [pathObj.pointArray objectAtIndex:0];
         pointObj.startPoint = CGPointMake([obj locationInView:self].x,[obj locationInView:self].y);
         pathObj.startPoint = CGPointMake([obj locationInView:self].x,[obj locationInView:self].y);
         
         *stop = YES;
     }];
    [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[event allTouches] enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
     {
         NSLog(@"(%f,%f)",[obj locationInView:self].x,[obj locationInView:self].y);
         touchBegin = CGPointMake([obj locationInView:self].x,[obj locationInView:self].y);
         
         OOOAppDelegate *appDelegate = (OOOAppDelegate *)[[UIApplication sharedApplication] delegate];
         NSMutableArray *pathObjects = [appDelegate pathObjects];
         OOOPathObject *pathObj = [pathObjects objectAtIndex:0];
         OOOPointObject *pointObj = [pathObj.pointArray objectAtIndex:0];
         pointObj.startPoint = CGPointMake(pointObj.startPoint.x,pointObj.startPoint.y);
         //pathObj.startPoint = CGPointMake(pointObj.startPoint.x+currentPosition.x,pointObj.startPoint.y+currentPosition.y);
         
         [self setNeedsDisplay];
         
         
         *stop = YES;
     }];
    
    [self setNeedsDisplay];

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    BOOL isPad = [[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    
    if (isPad) {
        
    } else {
        //iPhone用
        
    }
    OOOAppDelegate *appDelegate = (OOOAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *pathObjects = [appDelegate pathObjects];

    
    UIBezierPath *currentPath = [UIBezierPath bezierPath];
    
    //for (OOOPathObject *pathObj in pathObjects) {
      
        OOOPathObject *pathObj = [pathObjects objectAtIndex:0];
        [currentPath moveToPoint:CGPointMake(pathObj.startPoint.x,pathObj.startPoint.y)];
        
        for (OOOPointObject *pointObj in pathObj.pointArray) {
            //OOOPointObject *pointObj = [pathObj.pointArray objectAtIndex:0];
            [currentPath addCurveToPoint:pointObj.endPoint// CGPointMake(100,200)
                           controlPoint1:CGPointMake(pointObj.startPoint.x+pointObj.p1Offset.x,pointObj.startPoint.y+pointObj.p1Offset.y)
                           controlPoint2:CGPointMake(pointObj.endPoint.x+pointObj.p2Offset.x,pointObj.endPoint.y+pointObj.p2Offset.y)];
            
            UIBezierPath *p1Path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(pointObj.startPoint.x+pointObj.p1Offset.x,pointObj.startPoint.y+pointObj.p1Offset.y,3, 3)];
            [p1Path fill];
            UIBezierPath *p2Path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(pointObj.endPoint.x+pointObj.p2Offset.x,pointObj.endPoint.y+pointObj.p2Offset.y,3, 3)];
            [p2Path fill];
            
            //座標を求める
            float x1 = pointObj.startPoint.x;
            float cp1x = pointObj.startPoint.x+pointObj.p1Offset.x;
            float cp2x = pointObj.endPoint.x+pointObj.p2Offset.x;
            float x2 = pointObj.endPoint.x;
            float y1 = pointObj.startPoint.y;
            float cp1y = pointObj.startPoint.y+pointObj.p1Offset.y;
            float cp2y = pointObj.endPoint.y+pointObj.p2Offset.y;
            float y2 = pointObj.endPoint.y;
            
            float tp = (1-t);
            CGFloat x = t*t*t*x2 + 3*t*t*tp*cp2x + 3*t*tp*tp*cp1x + tp*tp*tp*x1;
            CGFloat y = t*t*t*y2 + 3*t*t*tp*cp2y + 3*t*tp*tp*cp1y + tp*tp*tp*y1;
            
            
            UIBezierPath *pointPath = [UIBezierPath bezierPath];
            
            //[pointPath addArcWithCenter:CGPointMake(x4,y4) radius:20.0 startAngle:0 endAngle:radians(360) clockwise:YES];
            [pointPath addArcWithCenter:CGPointMake(x,y) radius:20.0 startAngle:0 endAngle:radians(360) clockwise:YES];
            [[UIColor greenColor] setFill];
            [pointPath fill];
            
        }
//}
    
    [[UIColor blackColor] setStroke];
    [currentPath setLineWidth:2.0];
    [currentPath stroke];
    
    

}


@end
