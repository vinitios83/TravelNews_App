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

class TransportUpdateScreen extends StatefulWidget {
  const TransportUpdateScreen({
    Key? key,
    required this.association,
    required this.username,
    required this.password,
    required this.transport,
  }) : super(key: key);
  final Association association;
  final String username;
  final String password;
  final Transport transport;
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
  _TransportUpdateScreenState createState() =>
      // ignore: no_logic_in_create_state
      _TransportUpdateScreenState(myTransport: transport);
}

class _TransportUpdateScreenState extends State<TransportUpdateScreen> {
  _TransportUpdateScreenState({
    required this.myTransport,
  });
  final Transport myTransport;
  final _formKey = GlobalKey<FormBuilderState>();
  CreateDealController createDealController = Get.put(CreateDealController());
  B2BController b2bController = Get.find();
  final TextEditingController dealNameController = TextEditingController();
  int vechicalType = 0;
  int fuelType = 0;
  final TextEditingController dailyRent = TextEditingController();
  final TextEditingController costPerKM = TextEditingController();
  final TextEditingController costPerHour = TextEditingController();
  final TextEditingController costPerExtraHour = TextEditingController();
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
    dealNameController.text = myTransport.dealName;
    vechicalType = int.parse(myTransport.vechicleCategory);
    fuelType = int.parse(myTransport.fuelType);
    dailyRent.text = myTransport.dailyRent.split('.')[0];
    costPerKM.text = myTransport.costPerKm.split('.')[0];
    costPerHour.text = myTransport.costPerHour.split('.')[0];
    costPerExtraHour.text = myTransport.costPerExtraHour.split('.')[0];
    descriptionController.text =
        myTransport.dealDescription.replaceAll('BREAKLINE', ' ');
    countryController.text = myTransport.state;
    dealDestinationController.text = myTransport.city;
    personNameController.text = myTransport.contactPerson;
    personContactController.text = myTransport.contactNumber;
    personEmailController.text = myTransport.contactPemail;
    expire = int.parse(myTransport.dealExpire);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Transport'),
          actions: [
            IconButton(
              onPressed: () {
                context.loaderOverlay.show();
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  Map<String, String> body = {
                    "id": myTransport.id,
                    "deal_name": dealNameController.text,
                    "vechicle_category": vechicalType.toString(),
                    "fuel_type": fuelType.toString(),
                    "daily_rent": dailyRent.text,
                    "cost_per_km": costPerKM.text,
                    "cost_per_hour": costPerHour.text,
                    "cost_per_extra_hour": costPerExtraHour.text,
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
                      .createTransport(
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
                                .then((value) {
                              context.loaderOverlay.hide();
                              VxToast.show(
                                context,
                                msg: 'Transport Deal Updated Sucessfully',
                              );
                            }),
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
              icon: const Icon(
                Icons.save,
              ),
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
                      'Enter vechicle Category',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown_vechical',
                      initialValue: 'Mini (Economical Cars)',
                      // maxHeight: 80,
                      // mode: Mode.BOTTOM_SHEET,
                      // popupBackgroundColor: AppTheme.kMarqueeColor,
                      items: const [
                        'Mini (Economical Cars)',
                        'Prime Sedan (Specious sedans)',
                        'Prime Play (Music,Tv)',
                        'Compact SUV',
                        'Specious SUV',
                      ],
                      onChanged: (value) {
                        setState(() {
                          switch (value) {
                            case 'Mini (Economical Cars)':
                              vechicalType = 0;
                              break;
                            case 'Prime Sedan (Specious sedans)':
                              vechicalType = 1;
                              break;
                            case 'Prime Play (Music,Tv)':
                              vechicalType = 2;
                              break;
                            case 'Compact SUV':
                              vechicalType = 3;
                              break;
                            case 'Specious SUV':
                              vechicalType = 4;
                              break;
                            default:
                              vechicalType = 0;
                          }
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          switch (value) {
                            case 'Mini (Economical Cars)':
                              vechicalType = 0;
                              break;
                            case 'Prime Sedan (Specious sedans)':
                              vechicalType = 1;
                              break;
                            case 'Prime Play (Music,Tv)':
                              vechicalType = 2;
                              break;
                            case 'Compact SUV':
                              vechicalType = 3;
                              break;
                            case 'Specious SUV':
                              vechicalType = 4;
                              break;
                            default:
                              vechicalType = 0;
                          }
                        });
                      },
                    ),
                    const HeightBox(
                      20,
                    ),
                    Text(
                      'Fuel Type',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown_fuel',
                      initialValue: 'Petrol',
                      // maxHeight: 80,
                      // mode: Mode.BOTTOM_SHEET,
                      // popupBackgroundColor: AppTheme.kMarqueeColor,
                      items: const [
                        'Petrol',
                        'Diesel',
                        'CNG',
                        'Electronic',
                      ],
                      onChanged: (value) {
                        setState(() {
                          switch (value) {
                            case 'Petrol':
                              fuelType = 0;
                              break;
                            case 'Diesel':
                              fuelType = 1;
                              break;
                            case 'CNG':
                              fuelType = 2;
                              break;
                            case 'Electronic':
                              fuelType = 3;
                              break;

                            default:
                              fuelType = 0;
                          }
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          switch (value) {
                            case 'Petrol':
                              fuelType = 0;
                              break;
                            case 'Diesel':
                              fuelType = 1;
                              break;
                            case 'CNG':
                              fuelType = 2;
                              break;
                            case 'Electronic':
                              fuelType = 3;
                              break;
                            default:
                              fuelType = 0;
                          }
                        });
                      },
                    ),
                    const HeightBox(
                      20,
                    ),
                    Text(
                      'Daily Rent',
                      style: widget.headerStyle,
                    ),
                    DealPriceField(
                      dealPriceController: dailyRent,
                      lableText: 'Enter daily Rent',
                    ),
                    const HeightBox(20),
                    Text(
                      'Cost per km',
                      style: widget.headerStyle,
                    ),
                    DealPriceField(
                      dealPriceController: costPerKM,
                      lableText: 'Enter cost per km',
                    ),
                    const HeightBox(20),
                    Text(
                      'Cost per hour',
                      style: widget.headerStyle,
                    ),
                    DealPriceField(
                      dealPriceController: costPerHour,
                      lableText: 'Enter cost per hour',
                    ),
                    const HeightBox(20),
                    Text(
                      'Cost per extra hour',
                      style: widget.headerStyle,
                    ),
                    DealPriceField(
                      dealPriceController: costPerExtraHour,
                      lableText: 'Enter cost per extra hour',
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
                    const Divider(
                      color: Colors.black,
                    ),
                    const HeightBox(20),
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
                    Obx(
                      () {
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
                                    "id": myTransport.id,
                                    "deal_name": dealNameController.text,
                                    "vechicle_category":
                                        vechicalType.toString(),
                                    "fuel_type": fuelType.toString(),
                                    "daily_rent": dailyRent.text,
                                    "cost_per_km": costPerKM.text,
                                    "cost_per_hour": costPerHour.text,
                                    "cost_per_extra_hour":
                                        costPerExtraHour.text,
                                    "deal_description":
                                        descriptionController.text,
                                    "deal_expire": expire.toString(),
                                    "state": countryController.text,
                                    "city": dealDestinationController.text,
                                    "contact_person": personNameController.text,
                                    "contact_pemail":
                                        personEmailController.text,
                                    "contact_number":
                                        personContactController.text,
                                    "assoc_name": widget.association.name,
                                    "isfeatured": "0"
                                  };
                                  createDealController
                                      .createTransport(
                                    body: body,
                                    username: widget.username,
                                    password: widget.password,
                                    time: DateTime.now().toIso8601String(),
                                    isUpdate: true,
                                  )
                                      .then(
                                    (value) {
                                      if (value) {
                                        b2bController.fetchB2BDeals().then(
                                              (value) => b2bController
                                                  .fetchMyDeals(
                                                userid: widget.username,
                                              )
                                                  .then((value) {
                                                context.loaderOverlay.hide();
                                                VxToast.show(
                                                  context,
                                                  msg:
                                                      'Deal Updated Sucessfully',
                                                );
                                              }),
                                            );
                                      } else {
                                        context.loaderOverlay.hide();
                                        VxToast.show(
                                          context,
                                          msg: 'Something went wrong',
                                        );
                                      }
                                    },
                                  );
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
                              child: const Text('Update Transport'),
                            ),
                          );
                        }
                      },
                    ),
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

class DealPriceField extends StatelessWidget {
  const DealPriceField({
    Key? key,
    required this.dealPriceController,
    required this.lableText,
  }) : super(key: key);

  final TextEditingController dealPriceController;
  final String lableText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: lableText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: lableText,
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
