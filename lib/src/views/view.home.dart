import 'package:flutter/material.dart';
import 'package:house_kepping/src/components/component.progressBar.dart';
import 'package:house_kepping/src/components/component.roomsList.dart';
import 'package:house_kepping/src/components/component.totalRooms.dart';

import 'package:percent_indicator/percent_indicator.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  
  
  double grlWidth;
  Size size;


  Map rooms = {
    "rooms": [
      {
        "id": "Room 10042-1.0C",
        "description": "Individual - Vacant",
        "status": "Arrived",
        "credits": "1.5",
        "guest": "Lola Bunny",
        "checkIn": "11/24/20 - 4:40PM",
        "checkOut": "11/30/20 - 3:20PM",
        "internalStatus": 1
      },
      {
        "id": "Room 10043-1.0C",
        "description": "Individual - Vacant",
        "status": "Arrived",
        "credits": "1.5",
        "guest": "Lola Bunny",
        "checkIn": "11/24/20 - 4:40PM",
        "checkOut": "11/30/20 - 3:20PM",
        "internalStatus": 1
      },
      {
        "id": "Room 10044-1.0C",
        "description": "Individual - Vacant",
        "status": "Arrived",
        "credits": "1.5",
        "guest": "Lola Bunny",
        "checkIn": "11/24/20 - 4:40PM",
        "checkOut": "11/30/20 - 3:20PM",
        "internalStatus": 1
      },
      {
        "id": "Room 10045-1.0C",
        "description": "Individual - Vacant",
        "status": "Arrived",
        "credits": "1.5",
        "guest": "Lola Bunny",
        "checkIn": "11/24/20 - 4:40PM",
        "checkOut": "11/30/20 - 3:20PM",
        "internalStatus": 1
      }
    ],
  };

  //We assigned the list of tabs, if we need to add one more, here is the place. And we declared the controller for the tabs.
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'All',),
    new Tab(text: 'Current',),
    new Tab(text: 'Pending(8)',),
    new Tab(text: 'Cleaned(10)',)
  ];

  @override
  void initState(){
    super.initState();
    _tabController = new TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Get screen mobile size
    size = MediaQuery.of(context).size;
    //Assign 95% of screen mobile size, we use it to set the width to all fathers container.
    grlWidth = size.width * 0.95;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 180,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu_rounded),
                  Row(
                    children: [
                      Icon(Icons.filter_alt_outlined),
                      SizedBox(width: 20.0),
                      Icon(Icons.search_outlined)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Text('Housekeeping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
              SizedBox(height: 5.0),
              Text('Keep every room clean.', style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 15.0)),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
            labelColor: Theme.of(context).secondaryHeaderColor,
            indicatorColor: Color(0xFF0E6FF0),
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 15.0),
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _all(context),
            _current(context),
            _pending(context),
            _cleaned(context),
          ],
        ),

        floatingActionButton: TextButton(
          child: Text('Hola'),
          onPressed: (){
            Navigator.pushNamed(context, 'prueba');
          },
        ),
      );
  }




  Widget _all(BuildContext context){
    return Container(
      width: grlWidth,
      color: Theme.of(context).backgroundColor.withOpacity(0.3),
      child: RefreshIndicator(
        onRefresh: (){},
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProgressIndicatorComponent(
                doneTotal: 10.toString(),
                percent: 0.5,
              ),
              
              TotalRoomsComponent(
                totalRooms: 8,
              ),
              
              RoomListComponent(
                myTabController: _tabController,
                rooms: rooms,
              ),

              SizedBox(height: 20.0)
            ],
          )
        ),
      ),
    );
  }



  Widget _current(BuildContext context){
    return Container(
      width: grlWidth,
      color: Theme.of(context).backgroundColor.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProgressIndicatorComponent(
              doneTotal: 10.toString(),
              percent: 0.5,
            ),
            
            Container(
              margin: EdgeInsets.only(top: 30.0),
              width: size.width * 0.9,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Color(0xFFBEC2C5)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Next Assignment', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C), fontWeight: FontWeight.bold),),
                  Text('Room 10054', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0)),
                  Text('Individual', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C)),)
                ],
              )
            ),
            
            Container(
              width: size.width * 0.9,
              height: 60.0,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFF55C448),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: (size.width * 0.9) * 0.1,
                      child: Icon(Icons.play_arrow, color: Colors.white,),
                    ),
                    Container(
                      width: (size.width * 0.9) * 0.8,
                      child: Text('START CLEANING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                    )
                  ],
                ),
                onPressed: (){},
              ),
            ),

            Container(
              width: size.width * 0.9,
              height: 60.0,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFF88C3E),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                child: Row(
                  children: [
                    Container(
                      width: (size.width * 0.9) * 0.15,
                      child: Icon(Icons.pause, color: Colors.white,),
                    ),
                    Container(
                      width: (size.width * 0.9) * 0.7,
                      child: Text('PAUSE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                    )
                  ],
                ),
                onPressed: (){},
              ),
            ),

            Container(
              width: size.width * 0.9,
              height: 60.0,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFF8B83E),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: (size.width * 0.9) * 0.1,
                      child:Icon(Icons.add, color: Colors.white,),
                    ),
                    Container(
                      width: (size.width * 0.9) * 0.8,
                      child: Text('CREATE EVENT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                    )
                    
                    
                  ],
                ),
                onPressed: (){},
              ),
            ),

            Container(
              width: size.width * 0.9,
              height: 60.0,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 2.0,
                  color: Color(0xFF1693FE),
                )
              ),
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('VIEW MORE', style: TextStyle(color: Color(0xFF1693FE), fontWeight: FontWeight.bold),),
                    SizedBox(width: 20.0,),
                    Icon(Icons.arrow_right_rounded, color: Color(0xFF1693FE),),
                  ],
                ),
                onPressed: (){},
              ),
            ),

             _moreInfo(context),


            SizedBox(height: 20.0)
          ],
        )
      ),
    );
  }

  Widget _moreInfo(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      width: grlWidth * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Status'),
              Text(rooms['rooms'][0]['status'], style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Credits'),
              Text(rooms['rooms'][0]['credits'], style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Guest'),
              Text(rooms['rooms'][0]['guest'], style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Check In'),
              Text(rooms['rooms'][0]['checkIn'], style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Check Out'),
              Text(rooms['rooms'][0]['checkOut'], style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ],
      ),
    );
  }

  Widget _pending(BuildContext context){
    return Container(
      width: grlWidth,
      color: Theme.of(context).backgroundColor.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProgressIndicatorComponent(
              doneTotal: 10.toString(),
              percent: 0.5,
            ),
            
            TotalRoomsComponent(
              totalRooms: 8,
            ),
            
            RoomListComponent(
              myTabController: _tabController,
              rooms: rooms,
            ),

            SizedBox(height: 20.0)
          ],
        )
      ),
    );
  }

  Widget _cleaned(BuildContext context){
    return Container(
      width: grlWidth,
      color: Theme.of(context).backgroundColor.withOpacity(0.3),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProgressIndicatorComponent(
              doneTotal: 10.toString(),
              percent: 0.5,
            ),
            
            TotalRoomsComponent(
              totalRooms: 8,
            ),
            
            RoomListComponent(
              myTabController: _tabController,
              rooms: rooms,
            ),

            SizedBox(height: 20.0)
          ],
        )
      ),
    );
  }



} 