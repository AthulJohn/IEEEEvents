import 'package:flutter/material.dart';
import '../values.dart';

class Filters extends StatefulWidget {
  final bool all, upcoming, ongoing;
  final Function onall, onupcoming, onongoing;
  Filters(
      {this.all,
      this.upcoming,
      this.ongoing,
      this.onall,
      this.onongoing,
      this.onupcoming});
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'All Events',
            style: TextStyle(
                fontSize: widget.all ? 17 : 15,
                color: widget.all ? color[0] : Colors.grey,
                fontWeight: widget.all ? FontWeight.bold : FontWeight.normal),
          ),
          onPressed: widget.onall,
          color: Color(0xFFFFD8CC).withOpacity(widget.all ? 1 : 0.5),
        ),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Upcoming',
            style: TextStyle(
                fontSize: widget.upcoming ? 17 : 15,
                color: widget.upcoming ? color[0] : Colors.grey,
                fontWeight:
                    widget.upcoming ? FontWeight.bold : FontWeight.normal),
          ),
          onPressed: widget.onupcoming,
          color: Color(0xFF2aa665).withOpacity(widget.upcoming ? 0.75 : 0.25),
        ),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Ongoing',
            style: TextStyle(
                fontSize: widget.ongoing ? 17 : 15,
                color: widget.ongoing ? color[0] : Colors.grey,
                fontWeight:
                    widget.ongoing ? FontWeight.bold : FontWeight.normal),
          ),
          onPressed: widget.onongoing,
          color: Color(0xFFff823a).withOpacity(widget.ongoing ? 0.75 : 0.25),
        ),
      ],
    );
  }
}
