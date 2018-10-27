import 'package:flutter/material.dart';
import '../colors/allcolors.dart';

AppColors c = AppColors();
TextStyle styling = TextStyle(
  fontSize: 15.0,
  color: c.lightPink
);
Padding closeIconPadding = Padding(padding: EdgeInsets.only(top: 0.0, left: 0.0));
Padding textPadding = Padding(padding: EdgeInsets.only(left: 16.0, ));
Divider tileDivider = Divider(color: c.deepPurple2, height: 0.0,);

class DrawersElements {
  Widget buildDrawers(BuildContext context) {
    return Drawer(
      child: Container(
        color: c.deepPurple,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: closeIconPadding.padding,
                  child: ListTile(
                    leading: Icon(Icons.close, color: c.lightPink,),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                tileDivider,
                Padding(
                  padding: textPadding.padding,
                  child: ListTile(
                    title: Text("Blocked Users", style: styling,),
                    onTap: () {
                      //Navigate to appropriate page
                    },
                  ),
                ),
                tileDivider,
                Padding(
                  padding: textPadding.padding,
                  child: ListTile(
                    title: Text("Invite Code", style: styling),
                    onTap: () {
                      //Navigate to appropriate page
                    },
                  ),
                ),
                tileDivider,
                Padding(
                  padding: textPadding.padding,
                  child: ListTile(
                    title: Text("Feedback/Bugs", style: styling),
                    onTap: () {
                      //Navigate to appropriate page
                    },
                  ),
                ),
                tileDivider,
                Padding(
                  padding: textPadding.padding,
                  child: ListTile(
                    title: Text("Rate the app", style: styling),
                    onTap: () {
                      //Navigate to appropriate page
                    },
                  ),
                ),
                tileDivider,
                Padding(
                  padding: textPadding.padding,
                  child: ListTile(
                    title: Text("Help", style: styling),
                    onTap: () {
                      //Navigate to appropriate page
                    },
                  ),
                ),
                tileDivider,
                Padding(
                  padding: textPadding.padding,
                  child: ListTile(
                    title: Text("Logout", style: styling),
                    onTap: () {
                      //Navigate to appropriate page
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
