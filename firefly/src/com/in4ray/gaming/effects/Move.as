// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.effects
{
	import com.in4ray.gaming.components.IVisualElement;
	import com.in4ray.gaming.layouts.$x;
	import com.in4ray.gaming.layouts.$y;
	
	import flash.geom.Point;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;

	[Deprecated]
	/**
	 * Animation that moves object, changing $x and $y layout values. 
	 */	
	public class Move extends AnimationBase
	{
		
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in milliseconds.
		 * @param toX Animate to x position.
		 * @param toY Animate to y position.
		 * @param fromX Animate from x position.
		 * @param fromY Animate from y position.
         * @param useTheJuggler If false, the tween won't be add to the Juggler. You can play the tween manually using {@link advanceTime}
		 */		
		public function Move(target:IVisualElement=null, duration:Number=NaN, toX:Number=NaN, toY:Number=NaN, fromX:Number = NaN, fromY:Number = NaN, useTheJuggler:Boolean = true)
		{
			super(target, duration, useTheJuggler);
			
			this.toX = toX;
			this.toY = toY;
			this.fromX = fromX;
			this.fromY = fromY;
		}
		
		/**
		 * Animate from x position. 
		 */		
		public var fromX:Number;
		
		/**
		 * Animate to x position.
		 */		
		public var toX:Number;
		
		/**
		 * Animate from y position.
		 */		
		public var fromY:Number;
		
		/**
		 * Animate to y position.
		 */		
		public var toY:Number;
		
		/**
		 * Move speed px per second.
		 */		
		public var speed:Number;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			var d:Number;
			
			if(!isNaN(speed))
			{
				var frX:Number = !isNaN(fromX) ? fromX : valueX;
				var frY:Number = !isNaN(fromY) ? fromY : valueY;
				duration = new Point(toX - frX, toY - frY).length/speed; 
			}
			
			var tween:Tween = new Tween(this, (isNaN(duration) ? 1000 : duration)/1000, (transition ? transition : Transitions.LINEAR));
			
			if(!isNaN(delay))
				tween.delay = delay/1000;

            setTweenCallbacks(tween);

			if(!isNaN(toX))
				tween.animate("valueX", toX);
			if(!isNaN(toY))
				tween.animate("valueY", toY);
			
			return tween;
		}
		
		
		/**
		 * @private 
		 */	
		protected function get targetElement():IVisualElement
		{
			return target as IVisualElement;
		}
		
		/**
		 * @private 
		 */		
		public function get valueX():Number
		{
			return targetElement.getLayout($x).value;
		}

		/**
		 * @private 
		 */	
		public function set valueX(value:Number):void
		{
			targetElement.setLayoutValue($x, value);
		}
		
		/**
		 * @private 
		 */	
		public function get valueY():Number
		{
			return targetElement.getLayout($y).value;
		}
		
		/**
		 * @private 
		 */	
		public function set valueY(value:Number):void
		{
			targetElement.setLayoutValue($y, value);
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function play():void
		{
			if(!isNaN(fromX))
				valueX = fromX;
			
			if(!isNaN(fromY))
				valueY = fromY;
			
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function end():void
		{
			valueX = toX;
			valueY = toY;
			
			super.end();
		}
	}
}