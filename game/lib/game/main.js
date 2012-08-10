ig.module( 
  'game.main' 
)
.requires(
  'impact.game',
  'impact.font',

  'plugins.multitouch',
  'plugins.button'
  
  // require all ios plugins for compatability
  // ,'plugins.ios.ios'
)
.defines(function(){

MyGame = ig.Game.extend({

  font: new ig.Font( 'media/font.png' ),
  
  debugMultiTouch: false,
  touchColors: {},

  init: function() {
    ig.input.bind( ig.KEY.MOUSE1, 'click' )

    ig.game.spawnEntity( Button, ig.system.width / 2 - 75, ig.system.height / 2 - 22, {
      size: { x: 150, y: 45 },
      animSheet: new ig.AnimationSheet( 'media/button.png', 150, 45 ),
      text: [ 'Start Test' ],
      textPos: { x: 75, y: 16 },
      textAlign: ig.Font.ALIGN.CENTER,

      pressedUp: function() {
        this.kill()
        ig.game.debugMultiTouch = true
      }
    })
  },
  
  draw: function() {
    this.parent()
    
    if ( this.debugMultiTouch ) {
      for ( var t in ig.input.touches ) {
        if ( !this.touchColors[t] ) this.touchColors[t] = this.randomColorStr()
        
        ig.system.context.fillStyle = this.touchColors[t]
        ig.system.context.fillRect( ig.input.touches[t].x - 40, ig.input.touches[t].y - 40, 80, 80 )
      }
    }
  },
  
  randomColorStr: function() {
    return 'rgb(' + (Math.random() * 255 | 0) + ',' + (Math.random() * 255 | 0) + ',' + (Math.random() * 255 | 0) + ')'
  }

});

ig.main( '#canvas', MyGame, 60, 480, 320, 1 );

});
