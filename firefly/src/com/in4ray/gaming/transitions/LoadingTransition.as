// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.transitions
{
import com.in4ray.gaming.navigation.View;
import com.in4ray.gaming.navigation.ViewState;

	/**
	 * Transition that shows loading view while transiting with fade effect. 
	 */	
	public class LoadingTransition extends BasicTransition
	{
		/**
		 * Constructor.
		 *  
		 * @param trigger Event trigger.
		 * @param fromState Transition from state.
		 * @param toState Transition to state.
		 * @param loadingViewState Loading view state that will be shown while transiting. 
		 */		
		public function LoadingTransition(trigger:String, fromState:String, toState:String, loadingViewState:ViewState)
		{
			super(trigger, fromState, toState);
			
			this.loadingView = new View(loadingViewState, loadingViewState.getView(null));
		}
		
		/**
		 * @private 
		 */		
		protected var _isPlaying:Boolean;
		
		/**
		 * @inheritDoc 
		 */
		override public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		/**
		 * Tarnsition effect duration in milliseconds. 
		 */		
		public var duration:Number = 300;
	
		/**
		 * @private 
		 */		
		protected var parallel:ParallelTransition;
		
		/**
		 *  Loading view that will be shown while transiting.
		 */		
		public var loadingView:View;
		
		/**
		 * @inheritDoc 
		 */		
		override public function play(fromView:View, toView:View, callBack:Function=null, ...params):void
		{
			_fromView = fromView;
			_toView = toView;
			
			this.callBack = callBack;
			this.params = params;
			
			_isPlaying = true;
			
			loadingView.state.textureState = fromView ? fromView.state.textureState : null;
			
			parallel = new ParallelFadeTransition(trigger);
			parallel.navigator = _navigator;
			parallel.duration = duration;
			parallel.play(_fromView, loadingView, fromTransitionComplete);
		}
		
		/**
		 * @private 
		 */		
		protected function fromTransitionComplete():void
		{
			_navigator.textureManager.switchToStateAsync(_toView.state.textureState, textureLoaded);
		}
		
		/**
		 * @private 
		 */	
		protected function textureLoaded():void
		{
			parallel = new ParallelFadeTransition(trigger);
			parallel.navigator = _navigator;
			parallel.duration = duration;
			parallel.play(loadingView, _toView, toTransitionComplete);
		}
		
		/**
		 * @private 
		 */	
		protected function toTransitionComplete():void
		{
			_isPlaying = false;
			invokeCallback();
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function end():void
		{
			//can't stop this
		}
	}
}