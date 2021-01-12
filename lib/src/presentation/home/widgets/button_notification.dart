import 'package:flutter/material.dart';

class ButtonNotification extends StatelessWidget {
  const ButtonNotification({
    this.iconColor,
    this.labelColor,
    this.labelCount = 0,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;
  final int labelCount;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/Gestion');
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              Icons.notifications,
              color: this.iconColor,
              size: 28,
            ),
          ),
          Container(
            child: Center(
              child: Text(
                this.labelCount.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.merge(
                      /*       TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 9), */
                      TextStyle(color: Colors.white, fontSize: 9),
                    ),
              ),
            ),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: this.labelColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: BoxConstraints(
                minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
          ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}
