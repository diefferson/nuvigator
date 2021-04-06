import 'package:example/samples/bloc/samples_bloc.dart';
import 'package:example/samples/navigation/samples_router.dart';
import 'package:flutter/material.dart';
import 'package:nuvigator/nuvigator.dart';
import 'package:provider/provider.dart';

import '../modules/composer/navigation/composer_routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SamplesBloc>(context);
    final router = NuRouter.of<SamplesRouter>(context);
    final headingStle = Theme.of(context).textTheme.headline3;
    final toggleStyle = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuvigator example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Hero(
                  tag: 'HERO',
                  child: FlutterLogo(
                    size: 96,
                  ),
                ),
                Text(
                  'Nuvigator',
                  style: headingStle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Navigate using deep links',
                      style: toggleStyle,
                    ),
                    Switch(
                      value: bloc.navigateUsingDeepLink,
                      onChanged: (value) => bloc.navigateUsingDeepLink = value,
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    if (bloc.navigateUsingDeepLink) {
                      router.openDeepLink<void>(Uri.parse(
                          'exapp://deepprefix/friendRequests?numberOfRequests=10'));
                    } else {
                      router.toFriendRequests(numberOfRequests: 5);
                    }
                  },
                  child: const Text('Review friend requests'),
                ),
                RaisedButton(
                  onPressed: () async {
                    String text;

                    if (bloc.navigateUsingDeepLink) {
                      text = await router.openDeepLink<String>(Uri.parse(
                        'exapp://deepprefix/composer/text?initialText=Hello+deep+link%21',
                      ));
                    } else {
                      text = await router.composerRouter.toComposeText();
                    }

                    if (text != null) {
                      // ignore: unawaited_futures
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Composed message'),
                          content: Text(text),
                        ),
                      );
                    }
                  },
                  child: const Text('Compose a message'),
                ),
                const SizedBox(height: 48),
                const Text(
                  '"Review friend requests" navigates via a nested nuvigator to its initial route, and the routes can close their entire flow in the end.',
                ),
                const SizedBox(height: 8),
                const Text(
                  '"Compose a message" navigates via a grouped router, and all its routes can be accessed directly from here.',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
