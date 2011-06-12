/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "JpKrayTiELCImagePickerModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"

@implementation JpKrayTiELCImagePickerModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"57aae9d7-78a0-451f-83b6-d74d39160235";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"jp.kray.ti.ELCImagePicker";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

- (void)loadImagePicker:(id)args {
    ENSURE_UI_THREAD(loadImagePicker,args);
	ENSURE_SINGLE_ARG_OR_NIL(args,NSDictionary);
    
    NSLog(@"Load ImagePicker\n");
    
    if (args != nil) {
        // callbacks
		if ([args objectForKey:@"success"] != nil) {
			pickerSuccessCallback = [args objectForKey:@"success"];
			ENSURE_TYPE_OR_NIL(pickerSuccessCallback,KrollCallback);
			[pickerSuccessCallback retain];
		}
        
		if ([args objectForKey:@"cancel"] != nil) {
			pickerCancelCallback = [args objectForKey:@"cancel"];
			ENSURE_TYPE_OR_NIL(pickerCancelCallback,KrollCallback);
			[pickerCancelCallback retain];
		}
    }
    
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] init];    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
    albumController.assetFilter = kELCAlbumAllAssets;
    albumController.cellHeight = 75;
    albumController.titleForSelection = NSLocalizedString(@"Pick Something", @"Title for picking items");
    [elcPicker setDelegate:self];    
    
    TiApp *tiApp = [TiApp app];
    [tiApp showModalController:elcPicker animated:YES];
    
    [elcPicker release];
    [albumController release];
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    NSLog(@"success didFinish:\n");
	
	if (pickerSuccessCallback != nil) {
		id listener = [[pickerSuccessCallback retain] autorelease];
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSDictionary *dict in info) {
            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            [images addObject:image];
        }
        
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
		[dictionary setObject:images forKey:@"images"];
		[self _fireEventToListener:@"success" withObject:dictionary listener:listener thisObject:nil];	
	}
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    NSLog(@"cancel didCancel:\n");
    
	if (pickerSuccessCallback != nil) {
		id listener = [[pickerSuccessCallback retain] autorelease];
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
		[self _fireEventToListener:@"success" withObject:dictionary listener:listener thisObject:nil];	
	}
    
    [picker dismissModalViewControllerAnimated:YES];
}

@end
