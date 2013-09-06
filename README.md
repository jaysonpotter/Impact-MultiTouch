ImpactMultiTouch
================

These files provide multitouch functionality to [impact](http://impactjs.com). It works in your Desktop Browser, in Mobile Safari and iOS (iOSImpact, ejecta is not tested).

It consists of four parts:

1. The multitouch plugin `multitouch.js`
2. Compatibility files for iOSImpact `JS_TouchInput.*`
3. A button class that uses multitouch
4. Sample code (main.js)


Install
-------

Move the files from this repo over to your impact folder.  
If you use iOSImpact check that you don't override the whole `Classes` Folder, only the needed `JS_TouchInput.*` files.

Usage
-----

All current touches are saved in `ig.input.touches`. `ig.input.touches` is an object, so if you want to iterate over all touches, use:

    for ( var t in ig.input.touches ) {
      var touch = ig.input.touches[t]
      // do stuff with touch
    }

A single touch looks like this:

    { 
      x:      // The x Position of the Touch
      y:      // The y Position of the Touch
      id:     // The ID of the touch. In Mobile Safari this is what comes out of e.changedTouches[].identifier. 
              // In iOSImpact this is the adress of the Touch Object. 
      state:  // Can be 'down' or 'up'. If the state is 'up' the touch will be removed in the next frame.
    }

Important
---------

The multitouch.js plugin overrides the initMouse method of ig.Input. This is required cause the normal ig.Input registers it's own touch handlers which interfere with the ones used here. This could make this plugin incompatible with future versions of impact.

This plugin is tested with impact 1.23

Licence
=======

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2011 Philip Wagner <http://think-jeckel.de>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.