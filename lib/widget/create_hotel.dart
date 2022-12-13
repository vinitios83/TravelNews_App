import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';


import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../controller/b2b_controller.dart';
import '../../controller/create_deal_controller.dart';
import '../../models/association_model.dart';

import 'package:velocity_x/velocity_x.dart';

class CreateHotelScreen extends StatefulWidget {
  const CreateHotelScreen({
    Key? key,
    required this.association,
    required this.username,
    required this.password,
  }) : super(key: key);
  final Association association;
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
  _CreateHotelScreenState createState() => _CreateHotelScreenState();
}

class _CreateHotelScreenState extends State<CreateHotelScreen> {
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
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController dealDestinationController =
      TextEditingController();
  final TextEditingController personNameController = TextEditingController();
  final TextEditingController personContactController = TextEditingController();
  final TextEditingController personEmailController = TextEditingController();
  int expire = 0;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
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
                      'Name',
                      style: widget.headerStyle,
                    ),
                    DealNameField(dealNameController: dealNameController),
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
                      'Hotel Plans',
                      style: widget.headerStyle,
                    ),
                    FormBuilderSearchableDropdown(
                      name: 'searchable_dropdown_inclusion',
                      initialValue: 'CP',
                      // maxHeight: 60,
                      // mode: Mode.DIALOG,
                      
                      dropdownSearchDecoration: const InputDecoration(
                        enabled: false,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                      ),
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
                        setState(
                          () {
                            inclusion = ('CP' == value)
                                ? 0
                                : ('MAP' == value)
                                    ? 1
                                    : 2;
                          },
                        );
                      },
                    ),
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
                      'Description',
                      style: widget.headerStyle,
                    ),
                    DealDescriptionField(
                      dealDesController: descriptionController,
                    ),
                    const HeightBox(20),
                    Text(
                      'State',
                      style: widget.headerStyle,
                    ),
                    DealCountryField(
                      dealNameController: stateController,
                      lableText: 'Enter state name',
                    ),
                    const HeightBox(20),
                    Text(
                      'City',
                      style: widget.headerStyle,
                    ),
                    DealCountryField(
                      dealNameController: cityController,
                      lableText: 'Enter city name',
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
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                context.loaderOverlay.show();
                                Map<String, String> body = {
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
                                  "state": stateController.text,
                                  "city": cityController.text,
                                  "contact_person": personNameController.text,
                                  "contact_pemail": personEmailController.text,
                                  "contact_number":
                                      personContactController.text,
                                  "assoc_name": widget.association.name,
                                  "isfeatured": "0"
                                };
                                createDealController
                                    .createHotel(
                                  body: body,
                                  username: widget.username,
                                  password: widget.password,
                                  time: DateTime.now().toIso8601String(),
                                )
                                    .then((value) {
                                  if (value) {
                                    VxToast.show(
                                      context,
                                      msg: 'Hotel Added Sucessfully',
                                    );
                                    b2bController.fetchB2BDeals();
                                    context.loaderOverlay.hide();
                                  } else {
                                    context.loaderOverlay.hide();
                                    VxToast.show(
                                      context,
                                      msg: 'Something went wrong',
                                    );
                                  }
                                });
                              } else {
                                VxToast.show(
                                  context,
                                  msg: "Validation failed",
                                  bgColor: Colors.redAccent,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              // primary: AppTheme.kPrimaryColor,
                            ),
                            child: const Text('Create Deal'),
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

class DealNameField extends StatelessWidget {
  const DealNameField({
    Key? key,
    required this.dealNameController,
  }) : super(key: key);

  final TextEditingController dealNameController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Enter hotel Name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Enter hotel Name',
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
        hintText: 'Price per night for $org',
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
    required this.lableText,
  }) : super(key: key);

  final TextEditingController dealNameController;
  final String lableText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: lableText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: lableText,
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
