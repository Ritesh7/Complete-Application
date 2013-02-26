﻿package com.application.util
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.application.events.StageManagerEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	

	/**
	 * Creates an instance of the StageManager that aligns items according to their selected alignment mode.  Also dispatches an event, ON_RESIZE, that allows for further manipulation of items to the stage sizing.
	 * 
	 * @author Matt Przybylski [http://www.reintroducing.com]
	 * @version 1.0
	 */
	public class StageManager extends EventDispatcher
	{
//- PRIVATE & PROTECTED VARIABLES -------------------------------------------------------------------------

		private var _stage:Stage;
		private var _items:Array;
		private var _resizeStyle:String;
		private var _easeTime:Number;
		private var _easeFunc:Function;
		private var _tweenX:Tween;
		private var _tweenY:Tween;
		
//- PUBLIC & INTERNAL VARIABLES ---------------------------------------------------------------------------
		
		
		
//- CONSTRUCTOR	-------------------------------------------------------------------------------------------
	
		/**
		 * Creates a new instance of the StageManager class.
		 * 
		 * @param $stage A reference to the main stage.
		 * @param $resizeStyle A string value that represents how to move the clips into position ("easing" or "instant").
		 * @param $easeTime If the $resizeStyle is set to "easing", time (in seconds) it takes to ease clips into position.
		 * @param $easeFunc If the $resizeStyle is set to "easing", the easing function used to ease clips into position.
		 * 
		 * @return void
		 */
		public function StageManager($stage:Stage, $resizeStyle:String, $easeTime:Number, $easeFunc:Function):void
		{
			this._stage 		= $stage;
			this._items 		= new Array();
	        this._resizeStyle 	= $resizeStyle;
	        this._easeTime 		= $easeTime;
	        this._easeFunc 		= $easeFunc;
	        
	        this._stage.scaleMode = StageScaleMode.NO_SCALE;
	        this._stage.align = StageAlign.TOP_LEFT;
	        this._stage.addEventListener(Event.RESIZE, onResize);
		}

//- PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
		
		private function onResize($evt:Event):void
		{
			if (this._resizeStyle == "instant")
			{
				this.doInstantResize();
			}
			else if (this._resizeStyle == "easing")
			{
				this.doEasingResize();
			}
			
			this.dispatchEvent(new StageManagerEvent(StageManagerEvent.ON_RESIZE, {}));
		}
		
		// Resizes the clips using no easing but instant movement.
		private function doInstantResize():void
		{
			var numClips:int = this._items.length;
			
			for (var i:int = 0; i < numClips; i++)
			{
				var clip:DisplayObject = this._items[i].item;
				var clipX:Number = this._items[i].x;
				var clipY:Number = this._items[i].y;
				
				switch (this._items[i].mode)
				{
					case "TL":
						clip.x = (0 + clipX);
						clip.y = (0 + clipY);
						break;
					
					case "TC":
						clip.x = (((this._stage.stageWidth * .5) - (clip.width * .5)) + clipX);
						clip.y = (0 + clipY);
						break;
						
					case "TR":
						clip.x = ((this._stage.stageWidth - clip.width) + clipX);
						clip.y = (0 + clipY);
						break;
						
					case "ML":
						clip.x = (0 + clipX);
						clip.y = (((this._stage.stageHeight * .5) - (clip.height * .5)) + clipY);
						break;
						
					case "MC":
						clip.x = (((this._stage.stageWidth * .5) - (clip.width * .5)) + clipX);
						clip.y = (((this._stage.stageHeight * .5) - (clip.height * .5)) + clipY);
						break;
						
					case "MR":
						clip.x = ((this._stage.stageWidth - clip.width) + clipX);
						clip.y = (((this._stage.stageHeight * .5) - (clip.height * .5)) + clipY);
						break;
						
					case "BL":
						clip.x = (0 + clipX);
						clip.y = ((this._stage.stageHeight - clip.height) + clipY);
						break;
						
					case "BC":
						clip.x = (((this._stage.stageWidth * .5) - (clip.width * .5)) + clipX);
						clip.y = ((this._stage.stageHeight - clip.height) + clipY);
						break;
						
					case "BR":
						clip.x = ((this._stage.stageWidth - clip.width) + clipX);
						clip.y = ((this._stage.stageHeight - clip.height) + clipY);
						break;
				}
			}
		}
		
		// Resizes the clips using an easing equation.
		private function doEasingResize():void
		{
			var numClips:int = this._items.length;
			
			for (var i:int = 0; i < numClips; i++)
			{
				var clip:DisplayObject = this._items[i].item;
				var clipX:Number = this._items[i].x;
				var clipY:Number = this._items[i].y;
				var x:Number;
				var y:Number;
				
				switch (this._items[i].mode)
				{
					case "TL":
						x = (0 + clipX);
						y = (0 + clipY);
						break;
					
					case "TC":
						x = (((this._stage.stageWidth * .5) - (clip.width * .5)) + clipX);
						y = (0 + clipY);
						break;
						
					case "TR":
						x = ((this._stage.stageWidth - clip.width) + clipX);
						y = (0 + clipY);
						break;
						
					case "ML":
						x = (0 + clipX);
						y = (((this._stage.stageHeight * .5) - (clip.height * .5)) + clipY);
						break;
						
					case "MC":
						x = (((this._stage.stageWidth * .5) - (clip.width * .5)) + clipX);
						y = (((this._stage.stageHeight * .5) - (clip.height * .5)) + clipY);
						break;
						
					case "MR":
						x = ((this._stage.stageWidth - clip.width) + clipX);
						y = (((this._stage.stageHeight * .5) - (clip.height * .5)) + clipY);
						break;
						
					case "BL":
						x = (0 + clipX);
						y = ((this._stage.stageHeight - clip.height) + clipY);
						break;
						
					case "BC":
						x = (((this._stage.stageWidth * .5) - (clip.width * .5)) + clipX);
						y = ((this._stage.stageHeight - clip.height) + clipY);
						break;
						
					case "BR":
						x = ((this._stage.stageWidth - clip.width) + clipX);
						y = ((this._stage.stageHeight - clip.height) + clipY);
						break;
				}
				clip.x = x;
				clip.y = y;
				//TweenLite.to(clip, this._easeTime,{x:x,y:y});
				//this._tweenX = new Tween(clip, "x", this._easeFunc,10,20, .5, true);
				//this._tweenY = new Tween(clip, "y", this._easeFunc, clip.y, y, this._easeTime, true);
			}
		}
		
//- PUBLIC & INTERNAL METHODS -----------------------------------------------------------------------------
	
		/**
		 * Initializes the StageManager and helps avoid the FireFox bug (won't manage the stage on initial load).
		 * 
		 * @return void
		 */
		public function init():void
		{
			this._stage.dispatchEvent(new Event(Event.RESIZE));
		}

		/**
		 * Adds an item to the items array so that is is tracked when resizing. $offsetX and $offsetY are optional and can be left blank to use no offsets.
		 * 
		 * <p>
		 * The $alignMode parameter can be any of the following string values:
		 * <ul>
		 * <li>"TL": top left</li>
		 * <li>"TC": top center</li>
		 * <li>"TR": top right</li>
		 * <li>"ML": middle left</li>
		 * <li>"MC": middle center</li>
		 * <li>"MR": middle right</li>
		 * <li>"BL": bottom left</li>
		 * <li>"BC": bottom center</li>
		 * <li>"BR": bottom right</li>
		 * </ul>
		 * </p>
		 * 
		 * @param $item The item that is to be added to the items array.
		 * @param $alignMode A string value that represents the mode to align the item to.
		 * @param $offsetX An optional number that represents the value to offset the item on its x axis from its align spot (negative offsets left).
		 * @param $offsetY An optional number that represents the value to offset the item on its y axis from its align spot (negative offsets up).
		 * 
		 * @return void
		 */
		public function addItem($item:DisplayObject, $alignMode:String, $offsetX:Number = 0, $offsetY:Number = 0):void
		{
			this._items.push({item: $item, mode: $alignMode, x: $offsetX, y: $offsetY});
		}
		
		/**
		 * Removes an item from the items array so it is no longer tracked by the resizing.
		 * 
		 * @param $item The item that is to be removed from the items array.
		 * 
		 * @return void
		 */
		public function removeItem($item:DisplayObject):void
		{
			var numClips:int = this._items.length;
			
			for (var i:int = 0; i < numClips; i++)
			{
				var item:DisplayObject = this._items[i].item;
				
				if (item == $item)
				{
					this._items.splice(i, 1);
				}
			}
		}
	
//- EVENT HANDLERS ----------------------------------------------------------------------------------------
	
		
	
//- GETTERS & SETTERS -------------------------------------------------------------------------------------
	
		/**
		 * Returns the current items array.
		 * 
		 * @return An array of the items currently being aligned to the stage.
		 */
		public function get items():Array
		{
			return this._items;
		}
	
//- HELPERS -----------------------------------------------------------------------------------------------
	
		public override function toString():String
		{
			return "com.reintroducing.utils.StageManager";
		}
	
//- END CLASS ---------------------------------------------------------------------------------------------
	}
}