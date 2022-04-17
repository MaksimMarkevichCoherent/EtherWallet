import 'package:etherwallet/resources/icons/svg_icons.dart';
import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:etherwallet/utils/wallet_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/dialog/alert.dart';
import 'context/wallet/wallet_handler.dart';
import 'context/wallet/wallet_provider.dart';
import 'model/network_type.dart';

class WalletMainPage extends HookWidget {
  const WalletMainPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final store = useWallet(context);
    final address = store.state.address;
    final network = store.state.network;

    useEffect(() {
      store.initialise();
    }, []);

    useEffect(
      () => store.listenTransfers(address, network),
      [address, network],
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      child: SvgPicture.asset(
                        IconsSVG.logo,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    const Text(
                      "EtherWallet",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'ubuntu',
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Account Overview",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                fontFamily: 'avenir',
              ),
            ),
            const SizedBox(height: 10.0),
            _BalanceWidget(
              store: store,
              onChange: store.changeNetwork,
              currentValue: store.state.network,
              loading: store.state.loading,
              ethBalance: store.state.ethBalance,
              symbol: network.config.symbol,
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir',
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: Icon(Icons.dialpad),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 0.7,
                children: [
                  serviceWidget(
                    img: "sendMoney",
                    name: "Create\nTransaction",
                    onPressed: () => Alert(
                        title: 'Warning',
                        text: 'Current version of application available to create transactions with 0 amount.',
                        actions: [
                          TextButton(
                            child: const Text('Continue'),
                            onPressed: ()  {

                              Navigator.of(context).pushNamed('/transfer', arguments: store.state.network);
                            },
                          )
                        ]).show(context),
                  ),
                  serviceWidget(
                    img: "receiveMoney",
                    name: "Current\nAddress",
                    onPressed: () {
                      Navigator.of(context).pushNamed('/receive', arguments: address);
                    },
                  ),
                  serviceWidget(
                    img: '${network.config.symbol}',
                    name: "Get\n ${network.config.symbol}",
                    onPressed: () async {
                      final url = network.config.faucetUrl;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  serviceWidget(
                    img: "electricity",
                    name: "Reset\n wallet",
                    onPressed: () => Alert(
                        title: 'Warning',
                        text: 'Without your seed phrase or private key you cannot restore your wallet balance',
                        actions: [
                          TextButton(
                            child: const Text('cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text('reset'),
                            onPressed: () async {
                              await store.resetWallet();
                              Navigator.popAndPushNamed(context, '/');
                            },
                          )
                        ]).show(context),
                  ),
                  serviceWidget(
                    img: "ic_key",
                    name: "Reveal\n Key",
                    onPressed: () => Alert(
                        title: 'Private key',
                        text:
                            'WARNING: In production environment the private key should be protected with password.\r\n\r\n${store.getPrivateKey() ?? "-"}',
                        actions: [
                          TextButton(
                            child: const Text('close'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text('copy and close'),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: store.getPrivateKey()));
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Private key copied'),
                                duration: Duration(milliseconds: 800),
                              ));
                            },
                          ),
                        ]).show(context),
                  ),
                  serviceWidget(
                    img: "ic_history",
                    name: "History\n",
                    onPressed: () {
                      Navigator.pushNamed(context, '/history', arguments: address);
                    },
                  ),
                  serviceWidget(img: "flight", name: "Flight\nTicket"),
                  serviceWidget(img: "more", name: "More\n"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _myDefaultFunc() {}

Column serviceWidget({required String img, required String name, Function() onPressed = _myDefaultFunc}) {
  return Column(
    children: [
      Expanded(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color(0xfff1f3f6),
            ),
            child: Center(
              child: img == 'ic_key'
                  ? Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.vpn_key_outlined,
                        color: Color(0xFF39417A),
                        size: 30,
                      ),
                    )
                  : img == 'ic_history'
                      ? Container(
                          margin: const EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.history,
                            color: Color(0xFF39417A),
                            size: 30,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(20.0),
                          decoration:
                              BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/$img.png'))),
                        ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        name,
        style: const TextStyle(
          fontFamily: 'avenir',
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({
    Key? key,
    this.loading = false,
    required this.currentValue,
    required this.onChange,
    required this.ethBalance,
    required this.symbol,
    required this.store,
  }) : super(key: key);

  final WalletHandler store;
  final NetworkType currentValue;
  final bool loading;
  final Function(NetworkType network) onChange;
  final BigInt? ethBalance;
  final String? symbol;

  @override
  Widget build(BuildContext context) {
    final networks = NetworkType.enabledValues;
    const itemHeight = 48.0;

    return GestureDetector(
      onTap: !loading
          ? () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: itemHeight * networks.length,
                    child: Column(
                      children: <Widget>[
                        for (var network in networks)
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(double.infinity, itemHeight),
                            ),
                            onPressed: () {
                              onChange(network);
                              Navigator.pop(context);
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(network.config.label),
                              if (network == currentValue) ...[
                                const SizedBox(width: 10),
                                const Icon(
                                  WalletIcons.check,
                                  size: 15,
                                )
                              ]
                            ]),
                          ),
                      ],
                    ),
                  );
                },
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Color(0xfff1f3f6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${EthAmountFormatter(ethBalance).format()}',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Current $symbol Balance",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              height: 45.0,
              width: 45.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffffac30),
              ),
              child: IconButton(
                onPressed: !store.state.loading
                    ? () async {
                        await store.refreshBalance();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Balance updated'),
                          duration: Duration(milliseconds: 800),
                        ));
                      }
                    : null,
                icon: Icon(Icons.refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
