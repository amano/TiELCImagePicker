//
//  AssetCell.m
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetCell.h"
#import "ELCAsset.h"

@implementation ELCAssetCell

@synthesize rowAssets;
@synthesize height;

-(id)initWithAssets:(NSArray*)_assets reuseIdentifier:(NSString*)_identifier {
    
	if((self = [super initWithStyle:UITableViewStylePlain reuseIdentifier:_identifier])) {
        
		self.rowAssets = _assets;
	}
	
	return self;
}

-(void)setAssets:(NSArray*)_assets {
	
	for(UIView *view in [self subviews]) 
    {		
		[view removeFromSuperview];
	}
	
	self.rowAssets = _assets;
}

-(void)layoutSubviews {
    
    if (self.height == 0)
    {
        self.height = kDefaultHeight;
    }

    CGFloat width = self.frame.size.width;
    NSUInteger numPerRow = width / self.height;
    CGFloat spacing = (width - (self.height * numPerRow)) / (float) (numPerRow + 1);
    
	CGRect frame = CGRectMake(spacing, 2, self.height, self.height);
	
	for(ELCAsset *elcAsset in self.rowAssets) {
		
		[elcAsset setFrame:frame];
		[elcAsset addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:elcAsset action:@selector(toggleSelection)] autorelease]];
		[self addSubview:elcAsset];
		
		frame.origin.x = frame.origin.x + frame.size.width + spacing;
	}
}

-(void)dealloc 
{
	[rowAssets release];
    
	[super dealloc];
}

@end
