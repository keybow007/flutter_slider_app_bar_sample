import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemContent {
  final Color color;
  final AnimatedIcon icon;
  final String title;

  ItemContent({this.color, this.icon, this.title});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//AnimationController使う時は、SingleTickerProviderStateMixin実装要
//https://api.flutter.dev/flutter/animation/AnimationController-class.html
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  List<ItemContent> _itemContents;
  bool _isForwarded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _itemContents = _buildItemContents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _animate(),
          child: _isForwarded ? Icon(Icons.arrow_back) : Icon(Icons.forward),
        ),
        //https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html
        body: CustomScrollView(
          slivers: <Widget>[
            //https://api.flutter.dev/flutter/material/SliverAppBar-class.html
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              //backgroundColor: Colors.blueAccent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("SliverAppBarSample"),
                //transparent_imageパッケージ要
                //https://flutter.dev/docs/cookbook/images/fading-in-images
                background: FadeInImage.memoryNetwork(
                  fadeInCurve: Curves.bounceIn,
                  placeholder: kTransparentImage,
                  image: "https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg",
                ),
              ),
            ),
            //https://api.flutter.dev/flutter/widgets/SliverList-class.html
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  height: 120.0,
                  color: _itemContents[index].color,
                  child: Center(
                    child: ListTile(
                      leading: _itemContents[index].icon,
                      title: Text(_itemContents[index].title),
                      onTap: () => print("${_itemContents[index].title} tapped!"),
                    ),
                  ),
                );
              }, childCount: _itemContents.length),
            ),
          ],
        ),
      ),
    );
  }

  List<ItemContent> _buildItemContents() {
    return [
      ItemContent(
        color: Colors.blueAccent,
        icon: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          progress: _animationController,
        ),
        title: "add_event",
      ),
      ItemContent(
        color: Colors.redAccent,
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animationController,
        ),
        title: "play_pause",
      ),
      ItemContent(
        color: Colors.brown,
        icon: AnimatedIcon(
          icon: AnimatedIcons.search_ellipsis,
          progress: _animationController,
        ),
        title: "search_ellipsis",
      ),
      ItemContent(
        color: Colors.greenAccent,
        icon: AnimatedIcon(
          icon: AnimatedIcons.home_menu,
          progress: _animationController,
        ),
        title: "home_menu",
      ),
      ItemContent(
        color: Colors.teal,
        icon: AnimatedIcon(
          icon: AnimatedIcons.list_view,
          progress: _animationController,
        ),
        title: "list_view",
      ),
      ItemContent(
        color: Colors.black87,
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationController,
        ),
        title: "menu_close",
      ),
    ];
  }

  _animate() {
    setState(() {
      if (!_isForwarded) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isForwarded = !_isForwarded;
    });
  }
}
