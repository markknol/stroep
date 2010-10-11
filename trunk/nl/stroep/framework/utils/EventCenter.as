package nl.stroep.framework.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Global eventdispatching singleton class 
	 * @author Mark Knol
	 */
	public class EventCenter 
	{
		private var eventsList:Object = {};
		
		private static var instance:EventCenter;
		private static var allowInstantiation:Boolean = false;
		
		private var dispatcher:EventDispatcher;
		private var eventRemover:EventRemover;
		
		public static function getInstance():EventCenter
		{
			if ( instance == null )
			{
				allowInstantiation = true;
				
				instance = new EventCenter();
				
				allowInstantiation = false;
			}
			return instance;
		}
		
		public function EventCenter()
		{
			if ( !allowInstantiation )
			{
				throw new Error("Error: Instantiation failed: Use EventCenter.getInstance() instead of new.");
			}
			else
			{
				dispatcher = new EventDispatcher();
				eventRemover = new EventRemover(dispatcher);
			}
		}
		
		public function dispatchEvent( event:Event ):void
		{
			//trace("eventcenter dispatched ", event.type);
			dispatcher.dispatchEvent( event );
		}
		
		/// Add global listener
		public function addListener(scope:*, type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture);
			
			try 
			{ 
				eventRemover.addEventListener(type, listener, useCapture, scope); 
			} 
			catch (e:Error) 
			{
				trace("failed to add eventRemover to ", this, type)
			}
		}
		
		/// Manually remove global listener
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
			
			try 
			{ 
				eventRemover.removeEventListener(type, listener, useCapture); 
			} 
			catch (e:Error) 
			{
				trace("failed to remove eventRemover to ", this, type)
			}
		}
		
		/// remove listeners from scope
		public function removeListeners(scope:*):void 
		{
			eventRemover.removeListenersByScope(scope);
		}
	}
}