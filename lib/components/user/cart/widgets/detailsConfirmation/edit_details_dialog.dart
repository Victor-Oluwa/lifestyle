// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifestyle/state/providers/provider_model/user_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/components/user/cart/widgets/detailsConfirmation/proceed_button.dart';

import '../../../../../Common/colors/lifestyle_colors.dart';
import '../../../../../state/providers/actions/provider_operations.dart';

class EditBillingDetailsDialog extends StatefulWidget {
  const EditBillingDetailsDialog({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final WidgetRef ref;

  @override
  State<EditBillingDetailsDialog> createState() =>
      _EditBillingDetailsDialogState();
}

class _EditBillingDetailsDialogState extends State<EditBillingDetailsDialog> {
  getUser() {
    return widget.ref.read(userProvider);
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    final user = widget.ref.read(userProvider);
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _addressController = TextEditingController(text: user.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: LifestyleColors.kTaupeDarkened,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  color: LifestyleColors.kTaupeBackground,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: _nameController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Name (Read Only)',
                          labelStyle: const TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.sp)),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        validator: (value) {
                          if (!RegExp(
                                  r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$")
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Email (Read Only)',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.sp)),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.sp)),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.sp)),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      OrderDetailsProceedButton(
                        text: 'Save',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final cartFunction =
                                widget.ref.read(cartFunctionProvider);
                            cartFunction.saveUserBillingDetails(
                                address: _addressController.text,
                                phone: _phoneController.text);
                          }

                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
