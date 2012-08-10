#import "JS_TouchInput.h"


@implementation JS_TouchInput

- (id)initWithContext:(JSContextRef)ctx object:(JSObjectRef)obj argc:(size_t)argc argv:(const JSValueRef [])argv {
	if( self = [super initWithContext:ctx object:obj argc:argc argv:argv] ) {
		[Impact instance].touchDelegate = self;
		landscapeMode = [Impact landscapeMode];
	}
	return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self invokeCallback:callbackStart withTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self invokeCallback:callbackMove withTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self invokeCallback:callbackEnd withTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [self invokeCallback:callbackEnd withTouches:touches];
}

- (void)invokeCallback:(JSObjectRef)callback withTouches:(NSSet *)touches {
  
  Impact * impact = [Impact instance];
  
	if ( !callback || [touches count] < 1  ) return;
	
  NSEnumerator *enumerator = [touches objectEnumerator];
  id value;
  
  while ( ( value = [enumerator nextObject] ) ) {
    UITouch * touch = value;
    
    CGPoint pos = [touch locationInView:touch.view];
    float x, y;
    
    // Set x,y according to device orientation
    if( landscapeMode ) {
      // Statusbar orientation is always in sync with screen orientation
      UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
      if( orientation == UIInterfaceOrientationLandscapeRight ) {
        x = pos.y;
        y = 320 - pos.x;
      }
      else {
        x = 480 - pos.y;
        y = pos.x;
      }
    }
    else {
      x = pos.x;
      y = pos.y;
    }
    
    // Prepare arguments and invoke the callback
    
    JSValueRef params[] = {
      JSValueMakeNumber(impact.ctx, x),
      JSValueMakeNumber(impact.ctx, y),
      JSValueMakeNumber(impact.ctx, (int) touch )
    };
    
    [impact invokeCallback:callback thisObject:NULL argc:3 argv:params];
  }
}


JS_FUNC( JS_TouchInput, touchStart, ctx, argc, argv ) {
	callbackStart = JSValueToObject(ctx, argv[0], NULL);
	JSValueProtect(ctx, callbackStart);
	return NULL;
}

JS_FUNC( JS_TouchInput, touchEnd, ctx, argc, argv ) {
	callbackEnd = JSValueToObject(ctx, argv[0], NULL);
	JSValueProtect(ctx, callbackEnd);
	return NULL;
}

JS_FUNC( JS_TouchInput, touchMove, ctx, argc, argv ) {
	callbackMove = JSValueToObject(ctx, argv[0], NULL);
	JSValueProtect(ctx, callbackMove);
	return NULL;
}

@end
