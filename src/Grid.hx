import flash.display.Sprite;
//klasa rysująca siatkę planszy
class Grid extends flash.display.Sprite{
		//pozioma linia	biorąca za argument pozycję y oraz czy linia powinna być grubsza
		private function drawHorizontalLane(y : Int, thick : Bool){
			graphics.lineStyle(3, 0x000000, 1);
			if(thick)graphics.lineStyle(5, 0x000000, 1);
			graphics.moveTo(0, y);
			graphics.lineTo(720, y);
		}
		//pionowa linia
		private function drawVerticalLane(x : Int, thick : Bool){
			graphics.lineStyle(3, 0x000000, 1);
			if(thick)graphics.lineStyle(5, 0x000000, 1);
			graphics.moveTo(x, 0);
			graphics.lineTo(x, 720);
		}
		public function new() {
			super();
			for (y in 0...9) {
				drawHorizontalLane(y*80-1, y%3==0); //w przypadku gdy y|3 linia powinna być gruba
			}
			for (x in 0...9) {
				drawVerticalLane(x*80-1, x%3==0);
			}
		}
}