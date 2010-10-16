package nl.stroep.flashflowfactory.transitions 
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import nl.stroep.flashflowfactory.Page;
	import nl.stroep.flashflowfactory.transitions.interfaces.ITransition;
	/**
	 * Blur + fading page transition
	 * @author Mark Knol
	 */
	public class BlurTransition implements ITransition
	{
		private var quality:uint;
		private var blurAmount:Number;
		
		public function BlurTransition(quality:uint = 2, blurAmount:Number = 10) 
		{
			this.quality = quality;
			this.blurAmount = blurAmount;
			
			TweenPlugin.activate([AutoAlphaPlugin]);
		}
		
		/* INTERFACE nl.stroep.flashflowfactory.transitions.interfaces.ITransition */
		
		public function animateIn(page:Page, speed:Number, easing:Function):void
		{
			page.alpha = 0;
			TweenLite.to( page, 0, { autoAlpha: 0, blurFilter: { blurX:0, blurY:0, quality:this.quality, remove:false } });
			TweenLite.to( page, speed, { delay:0.01, overwrite:false, autoAlpha: 1, blurFilter: { blurX:0, blurY:0, quality:this.quality, remove:true }, onComplete: page.onShowComplete, ease: easing } );
		}
		
		public function animateOut(page:Page, speed:Number, easing:Function):void
		{
			TweenLite.to( page,  speed, { autoAlpha: 0, blurFilter: { blurX:blurAmount, blurY:blurAmount, quality:this.quality, remove:false }, onComplete: page.onHideComplete, ease: easing } );
		}
	}

}