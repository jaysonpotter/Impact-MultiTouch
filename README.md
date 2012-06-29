ImpactMultiTouch
================

This files provide multitouch functionality to [impact](http://impactjs.com). It works in your desktop browser, mobile browser and iOSImpact.

It consists of three parts:

1. The multitouch plugin `multitouch.js`
2. Compatibility files for iOSImpact `JS_TouchInput.*`
3. A button class that uses multitouch

In the button class you can see how to handle touches. 
There is a big difference between one touch and multiple touches. You can see the difference quite good when comparing the button class in this repo with my first one here: <https://gist.github.com/1395616>

Install
-------

Move the `multitouch.js` and `button.js`into your plugin Folder. If you want to use this plugin in iOS, replace the `JS_TouchInput.h` and `JS_TouchInput.m` (located in `Classes/Impact/`) with the ones provided by this repo.

Important
---------

The multitouch.js plugin ovverrides the initMouse method of ig.Input. This is required cause the normal ig.Input registers it's own touch handlers which interfere with the ones used here. This could make this plugin incompatible with future versions of impact.

This plugin is tested with impact 1.19