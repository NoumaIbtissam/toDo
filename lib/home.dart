import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/taskPage.dart';
import 'package:todo/toDoCard.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseToDo _dbHelper = DatabaseToDo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          width: double.infinity,
        padding: EdgeInsets.all(25.0),

        // we use Stack to place things above each other
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 32.0,
                  ),
                  child: Text("ToDos",style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                    child: FutureBuilder<List>(

                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context,snapshot){
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){
                              return ToDoCard(
                                  snapshot.data![index].title,
                                  snapshot.data![index].description,
                              );
                            },
                            );
                      },
                    )
                ),


              ],
            ),

            // we use positioned to control position of widgets
            Positioned(
              bottom: 0.0,
              right: 0.0,

              // we use gestureDectector so that we can call onTap function
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TaskPage()),
                  ).then((value) {
                    setState(() {

                    });
                  });
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    //color: Color(0xff742CFA),
                    // lets try gradient instead of color

                    gradient: LinearGradient(
                      colors: [Colors.purpleAccent,Colors.deepPurple],
                      begin: Alignment(0.0,-1.0),
                      end: Alignment(0.0,1.0),
                    ),
                    borderRadius: BorderRadius.circular(20.5),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              )


            ),],
        )

      ),)
    );
  }
}
