//
//  Asset.m
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"
#import "TiUtils.h"

@implementation ELCAsset

@synthesize asset;
@synthesize parent;
@synthesize height;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(id)initWithAsset:(ALAsset*)_asset withHeight:(CGFloat) inHeight {
	
	if ((self = [super initWithFrame:CGRectMake(0, 0, 0, 0)])) {
		
		self.asset = _asset;
		
        if (inHeight == 0)
        {
            self.height = kDefaultHeight;
        }
        else
        {
            self.height = inHeight;
        }
        
		CGRect viewFrames = CGRectMake(0, 0, self.height, self.height);
		
		UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:viewFrames];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		[assetImageView release];
        
        NSString *resourceurl = [[NSBundle mainBundle] resourcePath];
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/modules/%@/%@",resourceurl,@"jp.kray.ti.elcimagepicker",@"Overlay.png"]];
        UIImage *overlayImage = [UIImage imageWithContentsOfFile:[url path]];
		overlayView = [[UIImageView alloc] initWithFrame:viewFrames];
		[overlayView setImage:overlayImage];
		[overlayView setHidden:YES];
		[self addSubview:overlayView];
    }
    
	return self;	
}

-(id)initWithAsset:(ALAsset*)_asset {
    return [self initWithAsset:_asset withHeight:0];
}


-(void)toggleSelection {
    
	overlayView.hidden = !overlayView.hidden;
    
//    if([(ELCAssetTablePicker*)self.parent totalSelectedAssets] >= 10) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Maximum Reached" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//		[alert show];
//		[alert release];	
//
//        [(ELCAssetTablePicker*)self.parent doneAction:nil];
//    }
}

-(BOOL)selected {
	
	return !overlayView.hidden;
}

-(void)setSelected:(BOOL)_selected {
    
	[overlayView setHidden:!_selected];
}

- (void)dealloc 
{    
    self.asset = nil;
	[overlayView release];
    [super dealloc];
}

@end

