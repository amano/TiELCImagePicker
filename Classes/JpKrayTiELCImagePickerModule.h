/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import "KrollCallback.h"
#import "ELCAlbumPickerController.h"

@interface JpKrayTiELCImagePickerModule : TiModule {
    KrollCallback *pickerSuccessCallback;
	KrollCallback *pickerErrorCallback;
	KrollCallback *pickerCancelCallback;
    ELCAlbumPickerController *_albumController;
}

@end
