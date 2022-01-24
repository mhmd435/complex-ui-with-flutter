
import 'package:flutter/material.dart';

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 250));
  var childRadius = 0.0;
  var _canBeDragged;
  double maxSlide = 225.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void toggle() {
    if(_animationController.isDismissed){
      childRadius = 30.0;
      _animationController.forward();
    }else{
      _animationController.reverse().whenComplete(() => childRadius = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        // onHorizontalDragEnd: ,
        onTap: toggle,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context,_){
            double slide = _animationController.value * maxSlide;
            double scale = 1 - (_animationController.value * 0.4);
            return Stack(
              children: [
                myDrawer(),
                Transform(
                    transform: Matrix4.identity()..translate(slide)..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: myChild()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget myDrawer(){
    return Container(
      color: Colors.blueAccent[700],
      child: Row(
        children: [
          Flexible(
              flex: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60,),
                    Text("Besenior Header",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Divider(),
                    ListTile(title: Text("home"),onTap: (){

                    },),
                    ListTile(title: Text("plan"),),
                    ListTile(title: Text("shop"),),
                    ListTile(title: Text("news"),),
                    Divider(),
                    ListTile(title: Text("logout"),),
                    ListTile(title: Text("Exit"),),
                    ElevatedButton(onPressed: (){}, child: Text("Subcribe")),
                  ],
                ),
              )),
          Flexible(
              flex: 45,
              child: Container(
              )),
        ],
      ),
    );
  }

  Widget myChild(){
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(blurRadius: 30.0,color: Colors.black)],
        borderRadius: BorderRadius.all(Radius.circular(childRadius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(childRadius)),
        child: Scaffold(
          appBar: AppBar(leading: IconButton(onPressed: (){toggle();}, icon: const Icon(Icons.view_headline)),),
          body: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 30.0,color: Colors.black)],
              gradient: LinearGradient(colors: [
                Colors.blueAccent,
                Colors.redAccent
              ],begin: Alignment.topLeft,),
            ),
            child: const Center(
              child: Text("Besenior test App", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed && details.globalPosition.dx < double.infinity;
    bool isDragCloseFromRight = _animationController.isDismissed && details.globalPosition.dx > MediaQuery.of(context).size.width;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }



  void _onDragUpdate(DragUpdateDetails details) {
    if(_canBeDragged){
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }
}