// Imports External
import 'package:go_router/go_router.dart';

// Imports Project
import 'package:obus/app/pages/inicial_page.dart';
import 'package:obus/app/pages/search_page.dart';
import 'package:obus/app/pages/monitor_page.dart';


// * App Routes
class Routes {
    static const home = '/';
    static const intro = '/intro';

    static const search = '/pesquisa-do-onibus';
    static const monitor = '/acompanhamento-do-onibus/:id';
}

// * App Navigation
class RouteGenerator {
    GoRouter get generateRoute => GoRouter(

        initialLocation: Routes.home, //? trocar por search
        routes: [

            // Home
            GoRoute(
                name: Routes.home,
                path: Routes.home,
                builder: (context, state) => const InicialPage(),
            ),

            // Intro
            GoRoute(
                name: Routes.intro,
                path: Routes.intro,
                builder: (context, state) => const InicialPage(),
            ),

            // Pesquisa do Onibus
            GoRoute(
                name: Routes.search,
                path: Routes.search,
                builder: (context, state) => const SearchPage(),
            ),

            // Acompanhamento do Onibus
            GoRoute(
                name: Routes.monitor,
                path: Routes.monitor,
                builder: (context, state) => MonitorPage(goRouterState: state)
            ),

        ],

        errorBuilder: (context, state) => const InicialPage(),

    );
}
