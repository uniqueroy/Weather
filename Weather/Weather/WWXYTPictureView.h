//
//  WWXYTPictureView.h
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDataHandleBase;
@protocol WNetworkUtilDelegate;

extern NSInteger countOfWXYTImage;

@protocol WWXYTPictureViewDelegate;
@interface WWXYTPictureView : UIImageView<WNetworkUtilDelegate>{
    WDataHandleBase * _dataHandle;
    NSInteger _type;
}
@property (strong, atomic) id<WWXYTPictureViewDelegate> delegate;
- (id) initWithType: (NSInteger) theType;
- (void) getImage;
@end

@protocol WWXYTPictureViewDelegate <NSObject>

- (void) drawScrollView: (WWXYTPictureView *) theImageView;

@end