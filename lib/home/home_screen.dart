import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:rocket_guide/home/rocket_list_tile.dart';
import 'package:rocket_guide/rocket_details/rocket_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Guide'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        // future: context.watch<Backend>().getRockets(),
        // future: Provider.of<Backend>(context).getRockets(),
        future: context.read<Backend>().getRockets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error ocurred. ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final rockets = snapshot.data;
            return ListView(
              children: [
                for (final rocket in rockets) ...[
                  RocketListTile(
                    rocket: rocket,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RocketDetailsScreen(rocket: rocket),
                    )),
                  ),
                  const Divider(height: 0),
                ]
                // RocketListTile(
                //   rocket: _rocket,
                //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //builder: (context) => RocketDetailsScreen(rocket: rocket),
                //));,
                // )
              ],
            );
          }
        },
      ),
    );
  }
}
