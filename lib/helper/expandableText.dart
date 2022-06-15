import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return widget.text.length > 98
        ? Column(children: <Widget>[
            AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 100),
                child: ConstrainedBox(
                    constraints: widget.isExpanded
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 50.0),
                    child: Text(
                      widget.text,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ))),
            Container(
              height: 40,
              child: TextButton(
                  child: Text(
                    widget.isExpanded ? 'Hide' : 'Show more',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  onPressed: () =>
                      setState(() => widget.isExpanded = !widget.isExpanded)),
            )
          ])
        : Text(
            widget.text,
            softWrap: true,
            overflow: TextOverflow.fade,
          );
  }
}
