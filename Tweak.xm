// fuck https://apt.abcydia.com/read-1480.html !

// static BOOL enableGesture = YES;

@interface SBGrabberTongue : NSObject
-(UIGestureRecognizer *)edgePullGestureRecognizer;
@end

@interface SBFloatingDockRootViewController : UIViewController
// @property (nonatomic, retain) SBFloatingDockRootViewController *viewController;
@property (nonatomic,retain) SBGrabberTongue * grabberTongue;
-(UIGestureRecognizer *)screenEdgePanGestureRecognizer;
-(void)_beginPresentationTransition;
-(void)setPresentationProgress:(double)arg1 animated:(BOOL)arg111 interactive:(BOOL)arg2 withCompletion:(/*^block*/id)arg3 ;
-(void)searchGesture:(id)arg1 completedShowing:(BOOL)arg2 ;
@end

@interface SBFloatingDockController : NSObject
@property (nonatomic, retain) SBFloatingDockRootViewController *viewController;
@end

/* %hook SBFloatingDockRootViewController

%end */

%hook SBFloatingDockController

-(BOOL)floatingDockRootViewControllerShouldBeginScreenEdgeGestureRecognizer:(UIGestureRecognizer *)arg1 {
	return %orig;
}

+ (BOOL)isFloatingDockSupported {
	return YES;
}

- (BOOL)_systemGestureManagerAllowsFloatingDockGesture {
  if([[[self.viewController grabberTongue] edgePullGestureRecognizer] locationInView:((UIGestureRecognizer *)[[self.viewController grabberTongue] edgePullGestureRecognizer]).view].x < 180) {
    return YES;
  }
	return NO;
}

%end

%hook SBFloatingDockSuggestionsModel

- (BOOL)_shouldProcessAppSuggestion:(id)arg1 {
	return YES;
}

- (BOOL)recentsEnabled {
	return YES;
}
%end

%hook SBPlatformController

-(long long)medusaCapabilities {
	return 1;
}

%end

%hook SBMainWorkspace
-(BOOL)isMedusaEnabled {
	return YES;
}
%end

%hook SBApplication
-(BOOL)isMedusaCapable {
	return YES;
}
%end
