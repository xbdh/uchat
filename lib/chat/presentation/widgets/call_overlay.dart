import 'package:flutter/material.dart';

class CallOverlay {
  OverlayEntry? _overlayEntry;
  final BuildContext context;

  CallOverlay(this.context);

  void show({
    required String friendImage,
    required String friendName,
    required String callType,
    required VoidCallback onReject,
    required VoidCallback onAccept,
  }) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(friendImage),
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(friendName, style: TextStyle(fontSize: 16)),
                    Text("${callType} call", style: TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                        onReject();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.call_end, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                        onAccept();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.phone, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void remove() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
