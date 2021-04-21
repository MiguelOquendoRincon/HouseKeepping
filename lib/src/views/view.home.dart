import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:house_kepping/src/preferences/preferences.dart';

import 'package:house_kepping/src/components/component.addEventButton.dart';
import 'package:house_kepping/src/components/component.progressBar.dart';
import 'package:house_kepping/src/components/component.totalRooms.dart';
import 'package:house_kepping/src/components/component.roomsList.dart';
import 'package:house_kepping/src/logic/logic.paginationLogic.dart';
import 'package:house_kepping/src/components/component.timer.dart';

const LIMIT = 5;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  
  
  double grlWidth;
  Size size;
  bool playing = false;
  List roomsCleaned = [];
  Map roomCleaned = {};

  Stopwatch stopWatch = Stopwatch();

  //Here we load our user preferences to set the expend time in one room.
  final prefs = UserPreferences();
  //Here we load some important information about our methods to get rooms.
  final logic = PaginationLogic();
  

  
  //We declared the controller for the tabs and scroll.
  TabController _tabController;
  final controller = ScrollController();
  //We assigned the list of tabs, if we need to add one more, here is the place.
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'All',),
    new Tab(text: 'Current',),
    new Tab(text: 'Pending(10)'),
    new Tab(text: 'Cleaned(10)',)
  ];

  void _listener(){
    //Here we decide if we need more data.
    if((controller.offset >= controller.position.maxScrollExtent) && !logic.loading){
      logic.loadData(logic.items.last.position, LIMIT);
    }
  }

  @override
  void initState(){
    logic.loadData(null, LIMIT);
    _tabController = new TabController(length: myTabs.length, vsync: this);
    _tabController.index = 2;
    controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.removeListener(_listener);
    stopWatch.stop();
    stopWatch.reset();
    super.dispose();
  }


/* 
 #####   #    #  #  #       #####  
 #    #  #    #  #  #       #    # 
 #####   #    #  #  #       #    # 
 #    #  #    #  #  #       #    # 
 #    #  #    #  #  #       #    # 
 #####    ####   #  ######  ##### 
*/
  @override
  Widget build(BuildContext context) {

    /*We obligate to redraw the page if something in tabController index change.*/
    // _tabController.addListener(() { 
    //   if(_tabController.index != 1){
    //     setState(() => playing = false);
    //   }else{
    //     setState(() {});
    //   }
    // });

    

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
    );
  }


/*
   ##    #       #      
  #  #   #       #      
 #    #  #       #      
 ######  #       #      
 #    #  #       #      
 #    #  ######  ###### 
*/
  Widget _all(BuildContext context){
    return AnimatedBuilder(
      animation: logic,
      builder: (_, __){
        return Container(
          width: grlWidth,
          color: Theme.of(context).backgroundColor.withOpacity(0.3),
          child: RefreshIndicator(
            onRefresh: () async{
              logic.items.clear();
              logic.loadData(0, LIMIT);
              setState(() {});
            },
            child: SingleChildScrollView(
              child: logic.items.length != 0 
              ?
              Column(
                children: [
                  ProgressIndicatorComponent(
                    doneTotal: roomsCleaned.length.toString(),
                    totalRooms: logic.items.length.toString(),
                    percent: logic.items.length != 0 ? (roomsCleaned.length / logic.items.length) : 0.0
                  ),
                  
                  TotalRoomsComponent(
                    totalRooms: logic.items.length,
                  ),
                  
                  RoomListComponent(
                    myTabController: _tabController,
                    logic: logic,
                  ),

                  SizedBox(height: 20.0)
                ],
              )
              :
              Container(margin: EdgeInsets.only(top: 50.0), child: Center(child: CircularProgressIndicator(), )),
            ),
          ),
        );
      },
    );
  }


/*                                              
  ####   #    #  #####   #####   ######  #    #  ##### 
 #    #  #    #  #    #  #    #  #       ##   #    #   
 #       #    #  #    #  #    #  #####   # #  #    #   
 #       #    #  #####   #####   #       #  # #    #   
 #    #  #    #  #   #   #   #   #       #   ##    #   
  ####    ####   #    #  #    #  ######  #    #    #                                                          
*/
  Widget _current(BuildContext context){
    return AnimatedBuilder(
      animation: logic,
      builder:(_, __){
        return logic.room != null 
        ?
        Container(
          width: grlWidth,
          color: Theme.of(context).backgroundColor.withOpacity(0.3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProgressIndicatorComponent(
                  doneTotal: roomsCleaned.length.toString(),
                  totalRooms: logic.items.length.toString(),
                  percent: (roomsCleaned.length / logic.items.length),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: size.width * 0.9,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xFFBEC2C5)
                    )
                  ),
                  child: playing 
                  ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('In Progress', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C), fontWeight: FontWeight.bold),),
                      Container(
                        child: TimerText(
                          stopwatch: stopWatch,
                        ),
                      ),
                      Text(logic.room.idRoom, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0)),
                      Text(logic.room.description + ' / Target: 20 Mins.', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C)),)
                    ],
                  )
                  :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next Assignment', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C), fontWeight: FontWeight.bold),),
                      Text(logic.room.idRoom, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      Text(logic.room.description, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C)),)
                    ],
                  )
                ),
                
                playing 
                ?
                Column(
                  children: [
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
                        onPressed: (){
                          _showBottomModal(context);
                        },
                      ),
                    ),
                    AddEventButtonComponent(),
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
                              child: Icon(Icons.check, color: Colors.white,),
                            ),
                            Container(
                              width: (size.width * 0.9) * 0.8,
                              child: Text('COMPLETE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                            )
                          ],
                        ),
                        onPressed: (){
                            roomCleaned = {
                              "idRoom": logic.room.idRoom,
                              "description": logic.room.description,
                              "status": logic.room.status,
                              "credits": logic.room.credits,
                              "guest": logic.room.guest,
                              "checkIn": logic.room.checkIn,
                              "checkOut": logic.room.checkOut,
                              "internalStatus": 2,
                              "time": prefs.totalTime,
                              "position": logic.room.position
                            };

                            roomsCleaned.add(roomCleaned);
                            stopWatch.stop();
                            stopWatch.reset();
                            logic.resetRoom();
                            prefs.totalTime = '';
                            _tabController.animateTo((_tabController.index + 2));
                            
                        },
                      ),
                    ),
                  ]
                )
                :
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
                    onPressed: (){
                        stopWatch.start();
                        setState((){
                          playing = true;
                        });
                    },
                  ),
                ), 
                _moreInfo(context),
                SizedBox(height: 20.0)
              ],
            )
          ),
        )
        :
        Container(
          child: Center(
            child: Text('Ups! Here are not nothing'),
          ),
        );
      },
    );
  }


  _showBottomModal(context){
    return showModalBottomSheet(
      context: context, 
      builder: (context){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text('Confirm Action', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
              )
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text('The room activity will be paused. What would you like to do?', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                overflow: TextOverflow.ellipsis, 
                maxLines: 4
              )
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
                onPressed: (){
                  stopWatch.stop();
                  Navigator.pop(context);
                },
              ),
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
                      child: Text('CONTINUE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                    )
                  ],
                ),
                onPressed: (){
                  stopWatch.start();
                  Navigator.pop(context);
                },
              ),
            ), 
          ],
        );
      }
    );
  }


/*
                                 ###                         
 #    #   ####   #####   ######   #   #    #  ######   ####  
 ##  ##  #    #  #    #  #        #   ##   #  #       #    # 
 # ## #  #    #  #    #  #####    #   # #  #  #####   #    # 
 #    #  #    #  #####   #        #   #  # #  #       #    # 
 #    #  #    #  #   #   #        #   #   ##  #       #    # 
 #    #   ####   #    #  ######  ###  #    #  #        ####  
*/
  Widget _moreInfo(BuildContext context){
    return AnimatedBuilder(
      animation: logic,
      builder: (_, __){
        return ExpandableNotifier(
          child: Column(
            children: [
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: Container(
                  width: size.width * 0.9,
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 2.0,
                      color: Color(0xFF1693FE),
                    )
                  ),
                  child: ExpandablePanel(
                    theme: ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      bodyAlignment: ExpandablePanelBodyAlignment.center,
                      tapBodyToCollapse: true,
                      tapBodyToExpand: true,
                    ),
                    header: Container(
                      child: Text('VIEW MORE', style: TextStyle(color: Color(0xFF1693FE), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                    ),
                    collapsed: Container(),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 25.0),
                      width: grlWidth * 0.9,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status'),
                              Text(logic.room.status, style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Credits'),
                              Text(logic.room.credits, style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Guest'),
                              Text(logic.room.guest, style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Check In'),
                              Text(logic.room.checkIn, style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Check Out'),
                              Text(logic.room.checkOut, style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    builder: ( _, collapsed, expanded ){
                      return Expandable(collapsed: collapsed, expanded: expanded);
                    }
                  ),
                )
              )
            ],
          ),
        );
      },
    );
  }


/*                                              
 #####   ######  #    #  #####   #  #    #   ####  
 #    #  #       ##   #  #    #  #  ##   #  #    # 
 #    #  #####   # #  #  #    #  #  # #  #  #      
 #####   #       #  # #  #    #  #  #  # #  #  ### 
 #       #       #   ##  #    #  #  #   ##  #    # 
 #       ######  #    #  #####   #  #    #   ####  
*/
  Widget _pending(BuildContext context){
    return AnimatedBuilder(
        animation: logic,
        builder: (_, __){
          return Container(
            width: grlWidth,
            color: Theme.of(context).backgroundColor.withOpacity(0.3),
            child: RefreshIndicator(
              child: SingleChildScrollView(
                controller: controller,
                child: logic.items.length != 0 
                ?
                Column(
                  children: [
                    ProgressIndicatorComponent(
                      doneTotal: roomsCleaned.length.toString(),
                      totalRooms: logic.items.length.toString(),
                      percent: logic.items.length != 0 ? (roomsCleaned.length / logic.items.length) : 0.0
                    ),
                    
                    TotalRoomsComponent(
                      totalRooms: logic.items.length,
                    ),
                    
                    RoomListComponent(
                      myTabController: _tabController,
                      cleanedRooms: roomsCleaned,
                      logic: logic,
                    ),
                    
                    if(logic.items.length != 0 && logic.loading == true) Container(margin: EdgeInsets.only(bottom: 20.0), child: Center(child: CircularProgressIndicator(), )),
                    

                    SizedBox(height: 20.0)
                  ],
                )
                :
                Container(margin: EdgeInsets.only(top: 50.0), child: Center(child: CircularProgressIndicator(), )),
              ),
              onRefresh: () async{
                logic.items.clear();
                logic.loadData(0, LIMIT);
                setState(() {});
              },
            ),
          );
        },
      );
  }


/*                                             
  ####   #       ######    ##    #    #  ######  #####  
 #    #  #       #        #  #   ##   #  #       #    # 
 #       #       #####   #    #  # #  #  #####   #    # 
 #       #       #       ######  #  # #  #       #    # 
 #    #  #       #       #    #  #   ##  #       #    # 
  ####   ######  ######  #    #  #    #  ######  #####                                               
*/
  Widget _cleaned(BuildContext context){
    double compHeight =  (roomsCleaned.length * 90).toDouble();
    return AnimatedBuilder(
      animation: logic,
      builder: (_, __){
        return Container(
          width: grlWidth,
          color: Theme.of(context).backgroundColor.withOpacity(0.3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProgressIndicatorComponent(
                  doneTotal: roomsCleaned.length.toString(),
                  totalRooms: logic.items.length.toString(),
                  percent: logic.items.length != 0 ? (roomsCleaned.length / logic.items.length) : 0.0
                ),
                
                TotalRoomsComponent(totalRooms: logic.items.length),
                
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  height: compHeight == 0 ? 60 : compHeight,
                  child: roomsCleaned.length != 0 
                    ?
                    ListView.builder(
                      itemCount: roomsCleaned.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (_, index) {
                        final item = roomsCleaned[index];
                        List hourMinut = item['time'].split(':');
                        String finalTime = hourMinut[0] + 'm' + ' ' + hourMinut[1] + 's';
                        return Container(
                            margin: EdgeInsets.only(top: 10.0),
                            height: 80.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                              children: [
                                Column(
                                  children: [
                                    Divider(),
                                    Text(item['idRoom'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                    Text(item['description']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.lock_clock),
                                    Text(finalTime)
                                  ],
                                )
                              ],
                            ),
                          );
                      },
                    )
                    :
                    Container(child:Center(child: Text('Ups! You have a lot of work to do yet')))
                ),


                SizedBox(height: 20.0)
              ],
            )
          ),
        );
      }, 
    );
  }


} 