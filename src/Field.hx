import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFieldAutoSize;

import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class Field extends flash.display.Sprite{ //Klasa używana jako pole na planszy (rozrzeszająca obiekt Sprite)
	public var value : Int; //pole przechowujące aktualną wartość pola
	public var text : TextField; //obiekt odpowiedzialny za rysowanie aktualnej wartości pola
	public function new(x : Int, y : Int, s : Int, val : Int){ //konstruktor
		super();
		this.x = x;
		this.y = y;
		value = val;

		text = new TextField(); 
		var txtF = new TextFormat(65, TextFormatAlign.CENTER); //Format tekstu wykorzystanego przy wypisywaniu wartości pola
		text.autoSize = TextFieldAutoSize.NONE;
		text.defaultTextFormat = txtF;
		text.width = 80;
		text.height = 80;
		text.selectable = false;

		update();
		addChild(text);
	}
	public function update(){ //funkcja odpowiedzialna za aktualizacje wartości i koloru pola
		value %= 10; //zerowanie pola w przypadku gdy zostanie wprowadzona wartość większa niż 9
		if(value == 0){ //przy wartości zero wyświetlona zostaje pusta komórka
			text.text = ''; 
		} else {
			text.text = Std.string(value); //w przeciwnym razie aktualizuje wartość pola tekstowego (TextField text)
		}
		switch (value) { //kolorowanie komórki w zależności od wartości
			case 0: graphics.beginFill(0xffffff);
			case 1: graphics.beginFill(0xdfaf4b);
			case 2: graphics.beginFill(0xd54e88);
			case 3: graphics.beginFill(0xf0522b);
			case 4: graphics.beginFill(0x008c72);
			case 5: graphics.beginFill(0xb4cd3d);
			case 6: graphics.beginFill(0x006aa8);
			case 7: graphics.beginFill(0x7d7b7e);
			case 8: graphics.beginFill(0xa288ad);
			case 9: graphics.beginFill(0xe6c9bb);	
		}
		graphics.drawRect(0, 0, 80, 80); //wypełnienianie komórki wybranym kolorem
	}
}