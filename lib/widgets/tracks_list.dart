import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/models/current_track_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_ui/data/data.dart';

class TracksList extends StatelessWidget {
  final List<Song> tracks;

  const TracksList({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle:
          Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 12.0),
      dataRowMaxHeight: 54.0,
      dataRowMinHeight: 54.0,
      showCheckboxColumn: false,
      columns: const [
        DataColumn(label: Text('# TITLE')),
        DataColumn(label: Text('ARTIST')),
        DataColumn(label: Text('ALBUM')),
        DataColumn(label: Icon(Icons.access_time)),
      ],
      rows: tracks.map((e)  {
        final selected =
            context.watch<CurrentTrackModel>().selected?.id == e.id;

        final textStyleForHead = TextStyle(
          color: selected
              ? Theme.of(context).highlightColor
              : Theme.of(context).iconTheme.color,
        );
        final textStyle = TextStyle(
          color: selected
              ? Theme.of(context).highlightColor
              : Theme.of(context).cardColor,
        );
        return DataRow(
          cells: [
            DataCell(
              Text(e.title, style: textStyleForHead),
            ),
            DataCell(
              Text(e.artist, style: textStyle),
            ),
            DataCell(
              Text(e.album, style: textStyle),
            ),
            DataCell(
              Text(e.duration, style: textStyle),
            ),
          ],
          selected: selected,
          onSelectChanged: (_) =>
              context.read<CurrentTrackModel>().selectTrack(e),
        );
      }).toList(),
    );
  }
}
