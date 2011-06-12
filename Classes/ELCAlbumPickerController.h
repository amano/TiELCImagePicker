//
//  AlbumPickerController.h
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ELCAlbumPickerFilter {
    kELCAlbumAllAssets = 0,
    kELCAlbumAllPhotos,
    kELCAlbumAllVideos
} ELCAlbumPickerFilter;

@interface ELCAlbumPickerController : UITableViewController {
	
	NSMutableArray *assetGroups;
	NSOperationQueue *queue;
	id parent;
    ELCAlbumPickerFilter assetFilter;
    CGFloat cellHeight;
    NSString *titleForSelection;
}

@property (nonatomic, assign) id parent;
@property (nonatomic, retain) NSMutableArray *assetGroups;
@property (nonatomic, assign) ELCAlbumPickerFilter assetFilter;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, retain) NSString *titleForSelection;

-(void)selectedAssets:(NSArray*)_assets;

@end

