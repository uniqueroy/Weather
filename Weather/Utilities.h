//
//  Utilities.h
//  Weather
//
//  Created by Roy Hsiao on 4/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNetworkUtil.h"
@class WaitUIView;

@interface Utilities : NSObject<UIAlertViewDelegate, WNetworkUtilDelegate>{
    id<WNetworkUtilDelegate> _delegate;
}

+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;

//+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (NSMutableDictionary *) networkUtilParseUrl: (NSString *) urlStr
                                 withFirstNode: (NSString *) firstNode
                               withSecondeNode: (NSString *) secondNode
                                 withDelegate: (id<WNetworkUtilDelegate>) theDelegate;
+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (CGFloat) calculateLabelHeightWithContent: (NSString *) content withFont: (UIFont *) font withLabelWidth: (CGFloat) labelWidth;
@end
