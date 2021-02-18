import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketDetailsScreen extends StatefulWidget {
  final Rocket rocket;

  const RocketDetailsScreen({
    Key key,
    @required this.rocket,
  })  : assert(rocket != null),
        super(key: key);

  @override
  _RocketDetailsScreenState createState() => _RocketDetailsScreenState();
}

class _RocketDetailsScreenState extends State<RocketDetailsScreen> {
  bool _liked = false;

  bool get _hasAlreadyFlown =>
      widget.rocket.firstFlight.isBefore(DateTime.now());

  int get _daysSinceFirstFlight =>
      widget.rocket.firstFlight.difference(DateTime.now()).abs().inDays;

  String get _firstFlightLabel =>
      DateFormat.yMMMd().format(widget.rocket.firstFlight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rocket.name),
        actions: [
          IconButton(
            icon: Icon(_liked ? AntIcons.heart : AntIcons.heart_outline),
            color: !_liked ? null : Colors.red,
            onPressed: () => setState(() => _liked = !_liked),
          ),
        ],
      ),
      body: ListView(
        children: [
          if (widget.rocket.flickrImages.isNotEmpty)
            Hero(
              tag: 'hero-${widget.rocket.id}-image',
              child: _HeaderImage(
                images: widget.rocket.flickrImages,
              ),
            ),
          ListTile(
            title: Text(
              widget.rocket.name,
              style: textTheme.headline6,
            ),
            subtitle: widget.rocket.active ? null : Text('Inactive'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.rocket.description,
              style: textTheme.subtitle1,
            ),
          ),
          ListTile(
            leading: const Icon(AntIcons.calendar),
            title: Text(_hasAlreadyFlown
                ? '$_daysSinceFirstFlight days since first flight'
                : '$_daysSinceFirstFlight days until first flight'),
            subtitle: Text(_hasAlreadyFlown
                ? 'First flew on $_firstFlightLabel'
                : 'Scheduled to fly on $_firstFlightLabel'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(AntIcons.column_width),
            title: Text('${widget.rocket.diameter}'),
            subtitle: Text('in diameter'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(AntIcons.colum_height),
            title: Text('${widget.rocket.height}'),
            subtitle: Text('in height'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(AntIcons.arrow_down),
            title: Text('${widget.rocket.mass} kg'),
            subtitle: Text('total mass'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () => launch(widget.rocket.wikipedia),
                child: Text('Open Wikipedia Article'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final List<String> images;

  const _HeaderImage({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView(
        children: [
          for (final image in images)
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
