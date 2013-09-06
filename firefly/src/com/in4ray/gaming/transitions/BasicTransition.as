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
	import com.in4ray.gaming.events.ViewEvent;
import com.in4ray.gaming.navigation.View;
import com.in4ray.gaming.navigation.ViewNavigator;
	import com.in4ray.gaming.navigation.ViewState;
	
	/**
	 * Basic transition without animation. 
	 */	
	public class BasicTransition implements ITransition
	{
		/**
		 * Constructor.
		 *  
		 * @param trigger Event trigger.
		 * @param fromState Transition from state.
		 * @param toState Transition to state.
		 */		
		public function BasicTransition(trigger:String, fromState:String, toState:String)
		{
			_trigger = trigger;
			_toState = toState;
			_fromState = fromState;
		}
		
		private var _fromState:String;
		public function set fromState(value:String):void
		{
			_fromState = value;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get fromState():String
		{
			return _fromState;
		}
		
		private var _toState:String;
		public function set toState(value:String):void
		{
			_toState = value;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get toState():String
		{
			return _toState;
		}
		
		private var _trigger:String;
		public function set trigger(value:String):void
		{
			_trigger = value;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get trigger():String
		{
			return _trigger;
		}
		
		
		
		protected var _navigator:ViewNavigator;
		/**
		 * @inheritDoc
		 */	
		public function set navigator(value:ViewNavigator):void
		{
			_navigator = value;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get isPlaying():Boolean
		{
			return false;
		}
		
		/**
		 * @private
		 */	
		protected var _fromView:View;
		
		/**
		 * @private
		 */
		protected var _toView:View;
		
		/**
		 * @private
		 */
		protected var callBack:Function;
		
		/**
		 * @private
		 */
		protected var params:Array;
		
		/**
		 * @inheritDoc
		 */
		public function play(fromView:View, toView:View, callBack:Function=null, ...params):void
		{
			_fromView = fromView;
			_toView = toView;
			
			this.callBack = callBack;
			this.params = params;
			
			_navigator.hideView(_fromView);
			dispatchRemoving();
			dispatchRemoved();
			_navigator.showView(_toView);
			dispatchAdding();
			dispatchAdded();
			_navigator.textureManager.switchToState(_toView.state.textureState);
		}
		
		/**
		 * @inheritDoc
		 */
		public function end():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		protected function invokeCallback():void
		{
			if(callBack != null)
				callBack.apply(null, params);
		}
		
		/**
		 * @inheritDoc
		 */
		protected function dispatchRemoving():void
		{
			if(_fromView)
				_fromView.view.dispatchEvent(new ViewEvent(ViewEvent.REMOVING_FROM_NAVIGATOR));
		}
		/**
		 * @inheritDoc
		 */
		protected function dispatchRemoved():void
		{
			if(_fromView)
				_fromView.view.dispatchEvent(new ViewEvent(ViewEvent.REMOVED_FROM_NAVIGATOR));
		}
		
		/**
		 * @inheritDoc
		 */
		protected function dispatchAdding():void
		{
			if(_toView)
				_toView.view.dispatchEvent(new ViewEvent(ViewEvent.ADDING_TO_NAVIGATOR));
		}
		
		/**
		 * @inheritDoc
		 */
		protected function dispatchAdded():void
		{
			if(_toView)
				_toView.view.dispatchEvent(new ViewEvent(ViewEvent.ADDED_TO_NAVIGATOR));
		}
	}
}