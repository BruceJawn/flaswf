/*
  HXSL/Stage3D 2D Filter Example
  Jan. 4, 2014, Updated for HaXe 3 and HXSL 2; BY Bruce Jawn
  [http://bruce-lab.blogspot.com]
	  
*Copyright (c) <2014> <Bruce Jawn>
*This software is released under the MIT License
*<http://www.opensource.org/licenses/mit-license.php>
*/
import format.agal.Tools;

@:bitmap("hxlogo.png")
class HaxeLogo extends flash.display.BitmapData {
}

@:bitmap("ShrineNearDarjeeling.png")
class BGTex extends flash.display.BitmapData {
}

class Shader extends hxsl.Shader {

  static var SRC = {
    var input : {
    /*input vertex format: 
	pos.x:float; pos.y:float; pos.z:float; uv.u:float; uv.v:float;
	should be consistent with the input vertexbuffer*/
    pos : Float3,/*vertex position as input*/
	uv : Float2/*texture uv as input*/
    };
	var tuv : Float2;/*temp uv variable for output*/
    function vertex() {
      out = input.pos.xyzw;/*set vertex position*/ 
	  tuv = input.uv;
    }
    function fragment(tex : Texture, tex1 : Texture) {
	   //similar to Pixel Bender's evaluatePixel() function
	   var gamma:Float =0.6;
       var numColors:Float=8.0;
       var c:Float4 = tex.get(tuv, wrap);//similar to Pixel Bender's sampleNearest(src,outCoord());
	   

       c.r = pow(c.r, (gamma));
       c.g = pow(c.g, (gamma));
       c.b = pow(c.b, (gamma));
       c = c * numColors;
	   
	   //c = int(c);//runtime assert error, why?
	   c = c - frac(c);//work around for above error
	   
       c = c / numColors;

       c.r = pow(c.r, (1.0/gamma));
       c.g = pow(c.g, (1.0/gamma));
       c.b = pow(c.b, (1.0/gamma));

       out = tex1.get(tuv, wrap) * 0.1 + c*0.9;/*set output color*/ //similar to Pixel Bender's dst =;
    }
  };

}

class Shader2DTest {

  var stage : flash.display.Stage;
  var s : flash.display.Stage3D;
  var c : flash.display3D.Context3D;
  var shader : Shader;
  
  var vertexbuffer : flash.display3D.VertexBuffer3D;
  var indexbuffer : flash.display3D.IndexBuffer3D;
  var texture : flash.display3D.textures.Texture;
  var texture1 : flash.display3D.textures.Texture;
  function new() {
    stage = flash.Lib.current.stage;
    s = stage.stage3Ds[0];
    s.addEventListener( flash.events.Event.CONTEXT3D_CREATE, onReady );
    flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME, update);//For animation purpose
    s.requestContext3D(); 
  }//end of function new


  function onReady( _ ) {
    c = s.context3D;
    c.enableErrorChecking = true;
    c.configureBackBuffer( stage.stageWidth, stage.stageHeight, 0, true );

    shader = new Shader();
    /*
      Let's draw a plane, which contains 2 triangles:

      0------1
      |     /|
      | t0 / |
      |   /  |
      |  /   |
      | / t1 |
      |/     |
      3------2
      0-3: vertex index
      t0-t1: triangle index
    */
    vertexbuffer = c.createVertexBuffer(4,5);/*4: vertex number, 5: input length for each vertex*/

    var myVertexes:flash.Vector<Float> = new flash.Vector<Float>(0,false);
    myVertexes.push(-1);//vertex.x
	myVertexes.push(1);//vertex.y
	myVertexes.push(0.0);//vertex.z
	myVertexes.push(0);//u
	myVertexes.push(0);//v
	 
	myVertexes.push(1);//vertex.x
	myVertexes.push(1);//vertex.y
	myVertexes.push(0.0);//vertex.z
	myVertexes.push(1);//u
	myVertexes.push(0);//v
	 
	 
	myVertexes.push(1);//vertex.x
	myVertexes.push(-1);//vertex.y
	myVertexes.push(0.0);//vertex.z
	myVertexes.push(1);//u
	myVertexes.push(1);//v
	 
	  
	myVertexes.push(-1);//vertex.x
	myVertexes.push(-1);//vertex.y
	myVertexes.push(0.0);//vertex.z
	myVertexes.push(0);//u
	myVertexes.push(1);//v
	
    vertexbuffer.uploadFromVector(myVertexes,0,4);
    indexbuffer = c.createIndexBuffer(6);

    var myIndexes:flash.Vector<UInt> = new flash.Vector<UInt>(0, false);
	//up:t0
	myIndexes.push(0);//triangle.a:0
	myIndexes.push(1);//triangle.b:1
	myIndexes.push(3);//triangle.c:3
	//down:t1
	myIndexes.push(1);//triangle.a:1
	myIndexes.push(2);//triangle.b:2
	myIndexes.push(3);//triangle.c:3
	  
    indexbuffer.uploadFromVector(myIndexes, 0, 6);
	
	var logo = new HaxeLogo(0,0);
    texture1 = c.createTexture(logo.width, logo.height, flash.display3D.Context3DTextureFormat.BGRA, false);
    texture1.uploadFromBitmapData(logo);
	
	var bgtex = new BGTex(0,0);
    texture = c.createTexture(bgtex.width, bgtex.height, flash.display3D.Context3DTextureFormat.BGRA, false);
    texture.uploadFromBitmapData(bgtex);

  }//end of function onReady

  function update(_) {
    if( c == null ) return;

    c.clear(0, 0, 0, 1);
    c.setDepthTest( true, flash.display3D.Context3DCompareMode.LESS_EQUAL );
    //c.setCulling(flash.display3D.Context3DTriangleFace.BACK);
    /*shader.init(
		{},
		{tex: texture, tex1: texture1}
		);
		*/
	shader.tex = texture;
	shader.tex1 = texture1;
    //draw the triangles  
    shader.bind(c, vertexbuffer);
    c.drawTriangles(indexbuffer,0,-1);
    c.present();
  }//end of function update

  static function main() {
    var inst = new Shader2DTest();
  }//end of function main

}//end of class