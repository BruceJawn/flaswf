/*
  Forked from http://haxe.org/doc/advanced/flash3d: Example 0 - Cube
  2011,3,29; BY Bruce Jawn
  [http://bruce-lab.blogspot.com]
*/
import format.agal.Tools;

typedef K = flash.ui.Keyboard;

@:shader({
    var input : {
    /*input vertex format: 
       pos.x:float; pos.y:float; pos.z:float; color.r:float; color.g:float; color.b:float;
       should be consistent with the input vertexbuffer*/
        pos : Float3,/*vertex position as input*/
	col : Float3,/*vertex color as input*/
	};
    var color : Float3;/*temp color variable for output*/
    function vertex( mpos : M44, mproj : M44 ) {
      out = pos.xyzw * mpos * mproj;/*set vertex transformation*/
      color = col;/*set temp color as input color*/
    }
    function fragment() {
      out = color.xyzw;/*set output color*/
    }
  }) class Shader extends format.hxsl.Shader {

  }

class Test {

  var s : flash.display.Stage3D;
  var c : flash.display3D.Context3D;
  var shader : Shader;
  var t : Float;
  var keys : Array<Bool>;

  var camera : Camera;
  var vertexbuffer : flash.display3D.VertexBuffer3D;
  var indexbuffer : flash.display3D.IndexBuffer3D;

  function new() {
    t = 0;
    keys = [];
    var stage = flash.Lib.current.stage;
    s = stage.stage3Ds[0];
    s.viewPort = new flash.geom.Rectangle(0,0,stage.stageWidth,stage.stageHeight);
    s.addEventListener(flash.events.Event.CONTEXT3D_CREATE,onReady);
    stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN,callback(onKey,true));
    stage.addEventListener(flash.events.KeyboardEvent.KEY_UP,callback(onKey,false));
    flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME,update);
    s.requestContext3D();
    
    trace("Click the screen to get Focus!");
    trace("Arrow Keys/Num Key(8246): Rotation"); 
    trace("+/-: Zoom in/out");   
  }//end of function new

  function onKey(down,e : flash.events.KeyboardEvent) {
    keys[e.keyCode] = down;
  }//end of function onKey

  function onReady(_) {
    c = s.context3D;
    c.enableErrorChecking = true;
    var w = Std.int(s.viewPort.width);
    var h = Std.int(s.viewPort.height);
    c.configureBackBuffer( w, h, 0, true );

    shader = new Shader(c);
    camera = new Camera();

    /*
      Let's draw a plane, which contains 12 triangles:

      0------1------2------3
      |     /|     /|     /|
      | t0 / | t2 / | t4 / |
      |   /  |   /  |   /  |
      |  /   |  /   |  /   |
      | / t1 | / t3 | / t5 |
      |/     |/     |/     |
      4------5------6------7
      |     /|     /|     /|
      | t6 / | t8 / | t10/ |
      |   /  |   /  |   /  |
      |  /   |  /   |  /   |
      | / t7 | / t9 | / t11|
      |/     |/     |/     |
      8------9-----10-----11
      0-11: vertex index
      t0-t11: triangle index
    */
    vertexbuffer = c.createVertexBuffer(12,6);

    var myVertexes:flash.Vector<Float> = new flash.Vector<Float>(0,false);
    for(j in 0...3)
      for(i in 0...4)
	{
	  //set the vertex's position
	  myVertexes.push(i);//vertex.x
	  myVertexes.push(j);//vertex.y
	  myVertexes.push(0.0);//vertex.z
	  //set the vertex's color(random)
	  myVertexes.push(Math.random());//color.r
	  myVertexes.push(Math.random());//color.g
	  myVertexes.push(Math.random());//color.b
	}
    vertexbuffer.uploadFromVector(myVertexes,0,12);

    indexbuffer = c.createIndexBuffer(36);
    var myIndexes:flash.Vector<UInt> = new flash.Vector<UInt>(0,false);
    for(i in 0...2)
      for(j in 0...3)
	{
	  //up:t0
	  myIndexes.push(i*4+j);//triangle.a:0
	  myIndexes.push(i*4+(j+1));//triangle.b:1
	  myIndexes.push((i+1)*4+j);//triangle.c:4
	  //down:t1
	  myIndexes.push((i+1)*4+j);//triangle.a:4
	  myIndexes.push(i*4+(j+1));//triangle.b:1
	  myIndexes.push((i+1)*4+(j+1));//triangle.c:5
	}
    indexbuffer.uploadFromVector(myIndexes,0,36);
            
  }//end of function onReady

  function update(_) {
    if( c == null ) return;

    t += 0.01;

    c.clear(0, 0, 0, 1);
    c.setDepthTest(true, flash.display3D.Context3DCompareMode.LESS_EQUAL);
    c.setCulling(flash.display3D.Context3DTriangleFace.BACK);

    if( keys[K.UP] )
      camera.moveAxis(0,-0.1);
    if( keys[K.DOWN] )
      camera.moveAxis(0,0.1);
    if( keys[K.LEFT] )
      camera.moveAxis(-0.1,0);
    if( keys[K.RIGHT] )
      camera.moveAxis(0.1,0);
    if( keys[109] )
      camera.zoom /= 1.05;
    if( keys[107] )
      camera.zoom *= 1.05;
    camera.update();

    var project = camera.m.toMatrix();

    var mpos = new flash.geom.Matrix3D();
    mpos.appendRotation(t * 10,flash.geom.Vector3D.Z_AXIS);

    shader.init(
		{ mpos : mpos, mproj : project },
		{}
		);
    //draw the triangles      		
    shader.bind(vertexbuffer);
    c.drawTriangles(indexbuffer,0,-1);
    c.present();
  }//end of function update

  static function main() {
    haxe.Log.setColor(0xFF0000);
    var inst = new Test();
  }//end of function main

}//end of class