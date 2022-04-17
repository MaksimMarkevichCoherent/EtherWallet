import 'package:etherwallet/components/form/paper_form.dart';
import 'package:etherwallet/components/form/paper_input.dart';
import 'package:etherwallet/components/form/paper_validation_summary.dart';
import 'package:etherwallet/components/wallet/wallet_text_form.dart';
import 'package:etherwallet/components/welcomeButton/welcome_button.dart';
import 'package:etherwallet/context/transfer/wallet_transfer_provider.dart';
import 'package:etherwallet/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TransferForm extends HookWidget {
  const TransferForm({
    Key? key,
    required this.address,
    required this.onSubmit,
  }) : super(key: key);

  final String? address;
  final void Function(String address, String amount) onSubmit;

  @override
  Widget build(BuildContext context) {
    final toController = useTextEditingController(text: address);
    final amountController = useTextEditingController();
    final transferStore = useWalletTransfer(context);

    useEffect(() {
      if (address != null) toController.value = TextEditingValue(text: address!);
    }, [address]);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20.0),
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
                      Container(
                        child: WalletTextForm(
                          controller: toController,
                          label: 'Send to address...',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Address field is required!';
                            }
                          },
                        ),
                        width: 210.0,
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    child: IconButton(
                      color: Colors.grey,
                      iconSize: 36.0,
                      icon: Icon(Icons.qr_code),
                      onPressed: () {
                        //_navigateToQRReader(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              padding: const EdgeInsets.all(30.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color(0xfff1f3f6),
              ),
              child: Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100.0,
                      child: WalletTextForm.decimal(
                        label: 'Amount',
                        controller: amountController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter amount!";
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: WalletTextForm.decimal(
                        label: 'Fee',
                        //controller: _feeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter fee!";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: transferStore.state.errors != null
                  ? PaperValidationSummary(transferStore.state.errors!.toList())
                  : SizedBox(),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              child: WalletButton(
                //isLoading: !isApiCall,
                onTap: () => onSubmit(
                  toController.value.text,
                  amountController.value.text,
                  //EthAmountFormatter(BigInt.tryParse(amountController.value.text)).format().toString(),
                ),
                label: 'Send',
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );

    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: PaperForm(
            padding: 30,
            actionButtons: <Widget>[
              ElevatedButton(
                child: const Text('Transfer now'),
                onPressed: () => onSubmit(
                  toController.value.text,
                  amountController.value.text,
                  //EthAmountFormatter(BigInt.tryParse(amountController.value.text)).format().toString(),
                ),
              )
            ],
            children: <Widget>[
              if (transferStore.state.errors != null) PaperValidationSummary(transferStore.state.errors!.toList()),
              PaperInput(
                controller: toController,
                labelText: 'To',
                hintText: 'Type the destination address',
              ),
              PaperInput(
                controller: amountController,
                labelText: 'Amount',
                hintText: 'And amount',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
