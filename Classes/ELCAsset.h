//
//  Asset.h
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define kDefaultHeight 75

@interface ELCAsset : UIView {
	ALAsset *asset;
	UIImageView *overlayView;
	BOOL selected;
	id parent;
    CGFloat height;
}

@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, assign) id parent;
@property (nonatomic, assign) CGFloat height;

-(id)initWithAsset:(ALAsset*)_asset;
-(id)initWithAsset:(ALAsset*)_asset withHeight:(CGFloat) inHeight;
-(BOOL)selected;

@end