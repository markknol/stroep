package nl.stroep.flashflowfactory.transitions 
{
	import com.gskinner.motion.GTween;
	import nl.stroep.flashflowfactory.Page;
	import nl.stroep.flashflowfactory.transitions.interfaces.ITransition;
	/**
	 * Transition which slides from a specified distance to a direction type options.
	 * 
	 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
	 * @author Mark Knol
	 */
	public class SlideTransition implements ITransition
	{
		public static const FROM_TOP:String = "from_top";
		public static const FROM_RIGHT:String = "from_right";
		public static const FROM_BOTTOM:String = "from_bottom";
		public static const FROM_LEFT:String = "from_left";
		public static const FROM_RANDOM:String = "from_random";
		
		public var type:String;
		public var distance:uint;
		public var fadeEnabled:Boolean;
		
		
		public function SlideTransition( type:String = "from_left", distance:uint = 300, fadeEnabled:Boolean = true ) 
		{
			this.type = type;
			this.distance = distance;
			this.fadeEnabled = fadeEnabled;
		}
		/* INTERFACE nl.stroep.flashflowfactory.transitions.interfaces.ITransition */
		
		public function animateIn(page:Page, speed:Number, easing:Function):void
		{
			var vars:Object = {}
			
			if (fadeEnabled) {
				page.alpha = 0;
				vars.alpha = 1; 
			}
			
			var currentType:String = this.type;
			
			if (type == FROM_RANDOM) currentType = getRandomType();
			switch (currentType) 
			{
				case FROM_TOP:
					page.y -= distance
					vars.y = page.y + distance;
					break;
			
				case FROM_RIGHT: 
					page.x += distance
					vars.x = page.x - distance;
					break;
				
				case FROM_BOTTOM: 
					page.y += distance
					vars.y = page.y - distance;
					break;
					
				case FROM_LEFT: 
					page.x -= distance
					vars.x = page.x + distance;
					break;
					
				default:
					throw new Error("Unknown Slide type");
			}
			
			var tween:GTween = new GTween(page, speed, vars, { ease: easing } );
			tween.onComplete = page.onShowComplete;
		}
		
		private function getRandomType():String
		{
			var random:int = int(Math.random() * 4);
			if (random == 0) return FROM_TOP;
			if (random == 1) return FROM_RIGHT;
			if (random == 2) return FROM_BOTTOM;
			if (random == 3) return FROM_LEFT;
			return getRandomType();
		}
		
		public function animateOut(page:Page, speed:Number, easing:Function):void
		{
			var vars:Object = { }
			
			if (fadeEnabled) {
				page.alpha = 1;
				vars.alpha = 0; 
			}
			
			var currentType:String = this.type;
			
			if (type == FROM_RANDOM) currentType = getRandomType();
			
			
			switch (currentType) 
			{
				case FROM_TOP:
					vars.y = page.y + distance;
					break;
			
				case FROM_RIGHT: 
					vars.x = page.x - distance;
					break;
				
				case FROM_BOTTOM: 
					vars.y = page.y - distance;
					break;
					
				case FROM_LEFT: 
					vars.x = page.x + distance;
					break;
					
				default:
					throw new Error("Unknown Slide type");
			}
			
			var tween:GTween = new GTween(page, speed, vars, { ease: easing } );
			tween.onComplete = page.onHideComplete;
		}
		
		
		
	}

}