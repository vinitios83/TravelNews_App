import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../controller/b2b_controller.dart';
import '../../../controller/create_deal_controller.dart';
import '../../../models/association_model.dart';
import '../../../models/b2b_model.dart';

import 'package:velocity_x/velocity_x.dart';

class PackageUpdareScreen extends StatefulWidget {
  const PackageUpdareScreen({
    Key? key,
    required this.association,
    required this.username,
    required this.hotel,
    required this.password,
  }) : super(key: key);
  final Association association;
  final Hotel hotel;
  final String username;
  final String password;
  final TextStyle headerStyle = const TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
    height: 1.5,
  );
  final TextStyle footerStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
    height: 2.0,
  );
  final TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
    fontStyle: FontStyle.italic,
    height: 2.0,
  );
  @override
  _PackageUpdareScreenState createState() =>
      // ignore: no_logic_in_create_state
      _PackageUpdareScreenState(myhotel: hotel);
}

class _PackageUpdareScreenState extends State<PackageUpdareScreen> {
  _PackageUpdareScreenState({
    required this.myhotel,
  });
  final Hotel myhotel;
  final _formKey = GlobalKey<FormBuilderState>();
  CreateDealController createDealController = Get.put(CreateDealController());
  B2BController b2bController = Get.find();
  final TextEditingController dealNameController = TextEditingController();
  final TextEditingController dealDurartionController = TextEditingController();
  int dealType = 0;
  final TextEditingController dealPriceForOtherB2B = TextEditingController();
  final TextEditingController dealPrice = TextEditingController();
  int airport = 0;
  int inclusion = 0;
  int rating = 0;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dealDestinationController =
      TextEditingController();
  final TextEditingController personNameController = TextEditingController();
  final TextEditingController personContactController = TextEditingController();
  final TextEditingController personEmailController = TextEditingController();
  int expire = 0;

  @override
  void initState() {
    dealNameController.text = myhotel.dealName;
    dealDurartionController.text = '${myhotel.dealDuration}';
    dealType = int.parse(myhotel.dealType);
    dealPriceForOtherB2B.text = myhotel.dealPublicPrice.split('.')[0];
    dealPrice.text = myhotel.dealPrivatePrice.split('.')[0];
    airport = int.parse(myhotel.dealAirportStatus!);
    inclusion = int.parse(myhotel.dealInclusion);
    rating = int.parse(myhotel.dealHotelCategory);
    descriptionController.text =
        myhotel.dealDescription.replaceAll('BREAKLINE', ' ');
    countryController.text = myhotel.state;
    dealDestinationController.text = myhotel.city;
    personNameController.text = myhotel.contactPerson;
    personContactController.text = myhotel.contactNumber;
    personEmailController.text = myhotel.contactPemail;
    expire = int.parse(myhotel.dealExpire);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Package'),
          actions: [
            IconButton(
              onPressed: () {
                context.loaderOverlay.show();
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  Map<String, String> body = {
                    "id": myhotel.id,
                    "deal_name": dealNameController.text,
                    "deal_duration": dealDurartionController.text,
                    "deal_type": dealType.toString(),
                    "deal_public_price": dealPriceForOtherB2B.text,
                    "deal_private_price": dealPrice.text,
                    "deal_airport_status": airport.toString(),
                    "deal_inclusion": inclusion.toString(),
                    "deal_hotel_category": rating.toString(),
                    "deal_description": descriptionController.text,
                    "deal_expire": expire.toString(),
                    "state": countryController.text,
                    "city": dealDestinationController.text,
                    "contact_person": personNameController.text,
                    "contact_pemail": personEmailController.text,
                    "contact_number": personContactController.text,
                    "assoc_name": widget.association.name,
                    "isfeatured": "0"
                  };
                  createDealController
                      .createPackage(
                    body: body,
                    username: widget.username,
                    password: widget.password,
                    time: DateTime.now().toIso8601String(),
                    isUpdate: true,
                  )
                      .then((value) {
                    if (value) {
                      b2bController.fetchB2BDeals().then(
                            (value) => b2bController
                                .fetchMyDeals(
                              userid: widget.username,
                            )
                                .then(
                              (value) {
                                context.loaderOverlay.hide();
                                VxToast.show(
                                  context,
                                  msg: 'Package Updated Sucessfully',
                                );
                              },
                            ),
                          );
                    } else {
                      context.loaderOverlay.hide();
                      VxToast.show(
                        context,
                        msg: 'Something went wrong',
                      );
                    }
                  });
                } else {
                  context.loaderOverlay.hide();
                  VxToast.show(
                    context,
                    msg: 'Make sure every field must be valid',
                  );
                }
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                // color: AppTheme.kMarqueeColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deal Name',
                      style: widget.headerStyle,
                    ),
                    DealNameField(dealNameController: dealNameController),
                    const HeightBox(20),
                    Text(
                      'Duration',
                      style: widget.headerStyle,
                    ),
                    DealDurationField(
                        dealDurartionController: dealDurartionController),
                    const HeightBox(20),
                    Text(
                      'Deal Type',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown',
                      initialValue: 'Public (Visible to all)',
                      // maxHeight: 60,
                      // mode: Mode.BOTTOM_SHEET,
                      // popupBackgroundColor: AppTheme.kMarqueeColor,
                      items: [
                        'Public (Visible to all)',
                        'Private (Visible to ${widget.association.name})',
                      ],
                      onChanged: (value) {
                        setState(() {
                          dealType =
                              ('Public (Visible to all)' == value) ? 0 : 1;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          dealType =
                              ('Public (Visible to all)' == value) ? 0 : 1;
                        });
                      },
                    ),
                    const HeightBox(20),
                    (dealType == 0)
                        ? Text(
                            'Deal price for other B2B',
                            style: widget.headerStyle,
                          )
                        : const SizedBox.shrink(),
                    (dealType == 0)
                        ? DealPriceB2BField(
                            dealPriceB2BController: dealPriceForOtherB2B,
                          )
                        : const SizedBox.shrink(),
                    HeightBox(
                      (dealType == 0) ? 20 : 0,
                    ),
                    Text(
                      'Deal Price for ${widget.association.name}',
                      style: widget.headerStyle,
                    ),
                    DealPriceField(
                      dealPriceController: dealPrice,
                      org: widget.association.name,
                    ),
                    const HeightBox(20),
                    Text(
                      'Airport Transfers',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown_airport',
                      initialValue: 'Yes',
                      // maxHeight: 60,
                      // mode: Mode.BOTTOM_SHEET,
                      // popupBackgroundColor: AppTheme.kMarqueeColor,
                      items: const [
                        'Yes',
                        'No',
                      ],
                      onChanged: (value) {
                        setState(() {
                          airport = ('Yes' == value) ? 0 : 1;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          airport = ('Yes' == value) ? 0 : 1;
                        });
                      },
                    ),
                    const HeightBox(20),
                    Text(
                      'Inclusions',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown_inclusion',
                      initialValue: 'CP',
                      // maxHeight: 60,
                      // mode: Mode.BOTTOM_SHEET,
                      // popupBackgroundColor: AppTheme.kMarqueeColor,
                      items: const ['CP', 'MAP', 'AP'],
                      onChanged: (value) {
                        setState(() {
                          inclusion = ('CP' == value)
                              ? 0
                              : ('MAP' == value)
                                  ? 1
                                  : 2;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          inclusion = ('CP' == value)
                              ? 0
                              : ('MAP' == value)
                                  ? 1
                                  : 2;
                        });
                      },
                    ),
                    const HeightBox(20),
                    Text(
                      'Hotel Category',
                      style: widget.headerStyle,
                    ),
                    FormBuilderRatingBar(
                      name: 'rating_bar',
                      initialRating: 2.0,
                      minRating: 2.0,
                      maxRating: 5.0,
                      updateOnDrag: true,
                      onChanged: (val) {
                        rating = (val! - 2.0).toInt();
                      },
                    ),
                    const HeightBox(20),
                    Text(
                      'Description',
                      style: widget.headerStyle,
                    ),
                    DealDescriptionField(
                      dealDesController: descriptionController,
                    ),
                    const HeightBox(20),
                    Text(
                      'Country/State',
                      style: widget.headerStyle,
                    ),
                    DealCountryField(
                      dealNameController: countryController,
                    ),
                    const HeightBox(20),
                    Text(
                      'Destination',
                      style: widget.headerStyle,
                    ),
                    DealDestinationField(
                        dealDestinationController: dealDestinationController),
                    const HeightBox(20),
                    Text(
                      'Expire after',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown_expire',
                      initialValue: '1 Day',
                      // maxHeight: 60,
                      // mode: Mode.BOTTOM_SHEET,
                      // popupBackgroundColor: AppTheme.kMarqueeColor,
                      items: const [
                        '1 Day',
                        '1 Week',
                        '2 Month',
                        '3 Months',
                        '1 Year',
                      ],
                      onChanged: (value) {
                        setState(() {
                          switch (value) {
                            case '1 Day':
                              expire = 0;
                              break;
                            case '1 Week':
                              expire = 1;
                              break;
                            case '2 Month':
                              expire = 2;
                              break;
                            case '3 Months':
                              expire = 3;
                              break;
                            case '1 Year':
                              expire = 4;
                              break;
                            default:
                              expire = 4;
                          }
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          switch (value) {
                            case '1 Day':
                              expire = 0;
                              break;
                            case '1 Week':
                              expire = 1;
                              break;
                            case '2 Month':
                              expire = 2;
                              break;
                            case '3 Months':
                              expire = 3;
                              break;
                            case '1 Year':
                              expire = 4;
                              break;
                            default:
                              expire = 4;
                          }
                        });
                      },
                    ),
                    const HeightBox(30),
                    const Text(
                      'Enter Contact Person Detail',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const HeightBox(20),
                    const Text(
                      '*Use comma(,) to add multiple numbers,email ids,states,cities',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const HeightBox(20),
                    Text(
                      'Name',
                      style: widget.headerStyle,
                    ),
                    PersonNameField(personNameController: personNameController),
                    const HeightBox(20),
                    Text(
                      'Contact No.',
                      style: widget.headerStyle,
                    ),
                    PersonContactField(
                        personContactController: personContactController),
                    const HeightBox(20),
                    Text(
                      'Email Id',
                      style: widget.headerStyle,
                    ),
                    PersonEmailField(
                      personEmailController: personEmailController,
                    ),
                    const HeightBox(20),
                    Obx(() {
                      if (createDealController.isLoading.isTrue) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              context.loaderOverlay.show();
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                Map<String, String> body = {
                                  "id": myhotel.id,
                                  "deal_name": dealNameController.text,
                                  "deal_duration": dealDurartionController.text,
                                  "deal_type": dealType.toString(),
                                  "deal_public_price":
                                      dealPriceForOtherB2B.text,
                                  "deal_private_price": dealPrice.text,
                                  "deal_airport_status": airport.toString(),
                                  "deal_inclusion": inclusion.toString(),
                                  "deal_hotel_category": rating.toString(),
                                  "deal_description":
                                      descriptionController.text,
                                  "deal_expire": expire.toString(),
                                  "state": countryController.text,
                                  "city": dealDestinationController.text,
                                  "contact_person": personNameController.text,
                                  "contact_pemail": personEmailController.text,
                                  "contact_number":
                                      personContactController.text,
                                  "assoc_name": widget.association.name,
                                  "isfeatured": "0"
                                };
                                createDealController
                                    .createPackage(
                                  body: body,
                                  username: widget.username,
                                  password: widget.password,
                                  time: DateTime.now().toIso8601String(),
                                  isUpdate: true,
                                )
                                    .then((value) {
                                  if (value) {
                                    b2bController.fetchB2BDeals().then(
                                          (value) => b2bController
                                              .fetchMyDeals(
                                            userid: widget.username,
                                          )
                                              .then(
                                            (value) {
                                              context.loaderOverlay.hide();
                                              VxToast.show(
                                                context,
                                                msg: 'Deal Updated Sucessfully',
                                              );
                                            },
                                          ),
                                        );
                                  } else {
                                    context.loaderOverlay.hide();
                                    VxToast.show(
                                      context,
                                      msg: 'Something went wrong',
                                    );
                                  }
                                });
                              } else {
                                context.loaderOverlay.hide();
                                VxToast.show(
                                  context,
                                  msg: 'Make sure every field must be valid',
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                // primary: AppTheme.kPrimaryColor,
                                ),
                            child: const Text('Update Package'),
                          ),
                        );
                      }
                    }),
                    const HeightBox(20),
                    const Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DealDurationField extends StatelessWidget {
  const DealDurationField({
    Key? key,
    required this.dealDurartionController,
  }) : super(key: key);

  final TextEditingController dealDurartionController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'b2bprice',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter Deal Duration',
      ),
      controller: dealDurartionController,
      validator: (_) {
        if (dealDurartionController.text.isNumericOnly &&
            dealDurartionController.text.length < 5) {
          if (int.parse(dealDurartionController.text) > 365) {
            return 'Deal duration max value is 365';
          } else if (int.parse(dealDurartionController.text) < 1) {
            return 'Invalid Deal duration';
          } else {
            return null;
          }
        } else {
          return 'Must be a valid input';
        }
      },
    );
  }
}

class DealNameField extends StatelessWidget {
  const DealNameField({
    Key? key,
    required this.dealNameController,
  }) : super(key: key);

  final TextEditingController dealNameController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter Deal Name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Enter Deal Name',
      ),
      controller: dealNameController,
      validator: (_) {
        if (dealNameController.text.length < 10) {
          return ' Deal name must have at least 10 characters';
        } else {
          return null;
        }
      },
    );
  }
}

class DealPriceB2BField extends StatelessWidget {
  const DealPriceB2BField({
    Key? key,
    required this.dealPriceB2BController,
  }) : super(key: key);

  final TextEditingController dealPriceB2BController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'b2b_price',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter Deal Price',
      ),
      controller: dealPriceB2BController,
      validator: (_) {
        if (dealPriceB2BController.text.isNum) {
          if (dealPriceB2BController.text.isEmpty ||
              double.parse(dealPriceB2BController.text) <= 0) {
            return 'Please enter deal price';
          } else {
            return null;
          }
        } else {
          return 'Must be a valid input';
        }
      },
    );
  }
}

class DealPriceField extends StatelessWidget {
  const DealPriceField({
    Key? key,
    required this.dealPriceController,
    required this.org,
  }) : super(key: key);

  final TextEditingController dealPriceController;
  final String org;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'price',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter Deal price for $org',
      ),
      controller: dealPriceController,
      validator: (_) {
        if (dealPriceController.text.isNum) {
          if (dealPriceController.text.isEmpty ||
              double.parse(dealPriceController.text) <= 0) {
            return 'Please enter deal price';
          } else {
            return null;
          }
        } else {
          return 'Must be a valid input';
        }
      },
    );
  }
}

class DealDescriptionField extends StatelessWidget {
  const DealDescriptionField({
    Key? key,
    required this.dealDesController,
  }) : super(key: key);

  final TextEditingController dealDesController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'description',
      minLines: 3,
      maxLines: 8,
      maxLength: 200,
      decoration: const InputDecoration(
        hintText: 'Please enter description',
      ),
      controller: dealDesController,
    );
  }
}

class DealCountryField extends StatelessWidget {
  const DealCountryField({
    Key? key,
    required this.dealNameController,
  }) : super(key: key);

  final TextEditingController dealNameController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter Country/State Name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Enter country/state name',
      ),
      controller: dealNameController,
      validator: (_) {
        if (dealNameController.text.isEmptyOrNull) {
          return ' Must have a value';
        } else {
          return null;
        }
      },
    );
  }
}

class DealDestinationField extends StatelessWidget {
  const DealDestinationField({
    Key? key,
    required this.dealDestinationController,
  }) : super(key: key);

  final TextEditingController dealDestinationController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter destination Name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Enter destination name',
      ),
      controller: dealDestinationController,
      validator: (_) {
        if (dealDestinationController.text.isEmptyOrNull) {
          return ' Must have a value';
        } else {
          return null;
        }
      },
    );
  }
}

class PersonNameField extends StatelessWidget {
  const PersonNameField({
    Key? key,
    required this.personNameController,
  }) : super(key: key);

  final TextEditingController personNameController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter Person Name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Enter Person Name',
      ),
      controller: personNameController,
      validator: (_) {
        if (personNameController.text.isEmptyOrNull) {
          return 'Must have a valid value';
        } else {
          return null;
        }
      },
    );
  }
}

class PersonContactField extends StatelessWidget {
  const PersonContactField({
    Key? key,
    required this.personContactController,
  }) : super(key: key);

  final TextEditingController personContactController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter Person Contact',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        hintText: 'Enter contact no.',
      ),
      controller: personContactController,
      validator: (_) {
        if (personContactController.text.isEmptyOrNull) {
          return 'Must have a valid value';
        } else if (personContactController.text.length < 10) {
          return 'Must be atleast 10 digits long';
        } else {
          return null;
        }
      },
    );
  }
}

class PersonEmailField extends StatelessWidget {
  const PersonEmailField({
    Key? key,
    required this.personEmailController,
  }) : super(key: key);

  final TextEditingController personEmailController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter Email Id',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Enter email id.',
      ),
      controller: personEmailController,
      validator: (_) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(personEmailController.text);
        if (personEmailController.text.isEmptyOrNull) {
          return 'Must have a valid value';
        } else if (!emailValid) {
          return 'Must have a valid value';
        } else {
          return null;
        }
      },
    );
  }
}
