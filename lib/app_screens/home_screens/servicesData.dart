import 'package:flutter/material.dart';
import 'package:dakibaa/models/product_model_services.dart';
import 'dart:convert';
import '../../Colors/colors.dart';
import '../../models/serviceModel.dart';
import '../../common/constant.dart';

class Counter extends StatefulWidget {
  final int? index;
  final List<ServiceModelNew>? listData;

  Counter({this.index, this.listData});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int services = 1;
  int producttotal = 0;
  int total = 0;
  int? price;
  late int person_mult_price;
  ProductServicesModel? productModel;
  var pic_list = [
    "images/bartender.jpg",
    "images/beverage.jpg",
    "images/butler.jpg",
    "images/glassware.jpg"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mult_rate();
    services = 1;
    product.clear();
    totalrates();
  }

  void totalrates() {
    if (person! <= 15) {
      for (int i = 0; i < widget.listData!.length; i++) {
        if (widget.listData![i].id == 1) {
          producttotal += widget.listData![i].rate15!;
        }
        if (widget.listData![i].id == 2) {
          producttotal += widget.listData![i].rate15!;
        }
      }
      totalAmount = producttotal;
      if (widget.listData![widget.index!].id == 3) {
        totalamount_bev = totalAmount + person_mult_price;
      }
      if (widget.listData![widget.index!].id == 4) {
        totalamount_bev = totalamount_bev + person_mult_price;
        totalAmount = totalamount_bev;
      }
      for (int i = 0; i < widget.listData!.length; i++) {
        productModel = ProductServicesModel(
          "",
          "",
          0,
        );
        productModel!.prod_id = widget.listData![i].id.toString();
        productModel!.total = totalAmount;
        if (widget.listData![i].productname == "Beverage") {
          productModel!.qyt = person;
        } else if (widget.listData![i].productname == "Glassware") {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e!.toJson()).toList());
    } else if (person! <= 30) {
      for (int i = 0; i < widget.listData!.length; i++) {
        if (widget.listData![i].id == 1) {
          producttotal += widget.listData![i].rate30!;
        }
        if (widget.listData![i].id == 2) {
          producttotal += widget.listData![i].rate30!;
        }
      }
      totalAmount = producttotal;
      if (widget.listData![widget.index!].id == 3) {
        totalamount_bev = totalAmount + person_mult_price;
      }
      if (widget.listData![widget.index!].id == 4) {
        totalamount_bev = totalamount_bev + person_mult_price;
        totalAmount = totalamount_bev;
      }
      for (int i = 0; i < widget.listData!.length; i++) {
        productModel = ProductServicesModel(
          "",
          "",
          0,
        );
        productModel!.prod_id = widget.listData![i].id.toString();
        productModel!.total = totalAmount;
        if (widget.listData![widget.index!].id == 3 &&
            widget.listData![widget.index!].id == 4) {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e!.toJson()).toList());
    } else if (person! <= 50) {
      for (int i = 0; i < widget.listData!.length; i++) {
        if (widget.listData![i].id == 1) {
          producttotal += widget.listData![i].rate50!;
        }
        if (widget.listData![i].id == 2) {
          producttotal += widget.listData![i].rate50!;
        }
      }
      totalAmount = producttotal;
      if (widget.listData![widget.index!].id == 3) {
        totalamount_bev = totalAmount + person_mult_price;
      }
      if (widget.listData![widget.index!].id == 4) {
        totalamount_bev = totalamount_bev + person_mult_price;
        totalAmount = totalamount_bev;
      }
      for (int i = 0; i < widget.listData!.length; i++) {
        productModel = ProductServicesModel(
          "",
          "",
          0,
        );
        productModel!.prod_id = widget.listData![i].id.toString();
        productModel!.total = totalAmount;
        if (widget.listData![widget.index!].id == 3 &&
            widget.listData![widget.index!].id == 4) {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e!.toJson()).toList());
    } else if (person! <= 75) {
      for (int i = 0; i < widget.listData!.length; i++) {
        if (widget.listData![i].id == 1) {
          producttotal += widget.listData![i].rate75!;
        }
        if (widget.listData![i].id == 2) {
          producttotal += widget.listData![i].rate75!;
        }
      }
      totalAmount = producttotal;
      if (widget.listData![widget.index!].id == 3) {
        totalamount_bev = totalAmount + person_mult_price;
      }
      if (widget.listData![widget.index!].id == 4) {
        totalamount_bev = totalamount_bev + person_mult_price;
        totalAmount = totalamount_bev;
      }
      for (int i = 0; i < widget.listData!.length; i++) {
        productModel = ProductServicesModel(
          "",
          "",
          0,
        );
        productModel!.prod_id = widget.listData![i].id.toString();
        productModel!.total = totalAmount;
        if (widget.listData![widget.index!].id == 3 &&
            widget.listData![widget.index!].id == 4) {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e!.toJson()).toList());
    } else if (person! <= 1000) {
      for (int i = 0; i < widget.listData!.length; i++) {
        if (widget.listData![i].id == 1) {
          producttotal += widget.listData![i].rate100!;
        }
        if (widget.listData![i].id == 2) {
          producttotal += widget.listData![i].rate100!;
        }
      }
      totalAmount = producttotal;
      if (widget.listData![widget.index!].id == 3) {
        totalamount_bev = totalAmount + person_mult_price;
      }
      if (widget.listData![widget.index!].id == 4) {
        totalamount_bev = totalamount_bev + person_mult_price;
        totalAmount = totalamount_bev;
      }
      for (int i = 0; i < widget.listData!.length; i++) {
        productModel = ProductServicesModel(
          "",
          "",
          0,
        );
        productModel!.prod_id = widget.listData![i].id.toString();
        productModel!.total = totalAmount;
        if (widget.listData![widget.index!].id == 3 &&
            widget.listData![widget.index!].id == 4) {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        product.add(productModel);
      }
      jsons = jsonEncode(product.map((e) => e!.toJson()).toList());
    }
  }

  void addItemToList() {
    setState(() {
      if (product.isEmpty) {
        productModel = ProductServicesModel(
          "",
          "",
          0,
        );
        productModel!.prod_id = widget.listData![widget.index!].id.toString();
        if (person! <= 15) {
          productModel!.total = price;
        } else if (person! <= 30) {
          productModel!.total = price;
        } else if (person! <= 50) {
          productModel!.total = price;
        } else if (person! <= 75) {
          productModel!.total = price;
        } else if (person! <= 1000) {
          productModel!.total = price;
        }
        if (widget.listData![widget.index!].id == 3) {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        if (widget.listData![widget.index!].id == 4) {
          productModel!.qyt = person;
        } else {
          productModel!.qyt = services;
        }
        product.add(productModel);
      } else {
        if (product[widget.index!]!.prod_id ==
            widget.listData![widget.index!].id.toString()) {
          if (person! <= 15) {
            productModel!.total = price;
          } else if (person! <= 30) {
            productModel!.total = price;
          } else if (person! <= 50) {
            productModel!.total = price;
          } else if (person! <= 75) {
            productModel!.total = price;
          } else if (person! <= 1000) {
            productModel!.total = price;
          }
          if (widget.listData![widget.index!].id == 3 &&
              widget.listData![widget.index!].id == 4) {
            productModel!.qyt = person;
          } else {
            productModel!.qyt = services;
          }
          for (int i = 0; i < product.length; i++) {
            product[i]!.total = totalAmount;
          }
          product[widget.index!]!.qyt = productModel!.qyt;
        }
        jsons = jsonEncode(product.map((e) => e!.toJson()).toList());
      }
    });
  }

  void gls_rate() {
    if (checkedValue_2 == true) {
      if (person! <= 15) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;

        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 30) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 50) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 75) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 1000) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      }
    } else if (checkedValue_2 == false) {
      if (person! <= 15) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 30) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 50) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 75) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 1000) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      }
    }
  }

  void bev_rate() {
    if (checkedValue_1 == true) {
      if (person! <= 15) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;

        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 30) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 50) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 75) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      } else if (person! <= 1000) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount - person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount - person_mult_price;
        }
      }
    } else if (checkedValue_1 == false) {
      if (person! <= 15) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 30) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 50) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 75) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      } else if (person! <= 1000) {
        if (widget.listData![widget.index!].id == 3) {
          totalAmount = totalAmount + person_mult_price;
        } else if (widget.listData![widget.index!].id == 4) {
          totalAmount = totalAmount + person_mult_price;
        }
      }
    }
  }

  void mult_rate() {
    if (person! <= 15) {
      if (widget.listData![widget.index!].id == 3) {
        person_mult_price = person! * widget.listData![widget.index!].rate15!;

      } else if (widget.listData![widget.index!].id == 4) {
        person_mult_price = person! * widget.listData![widget.index!].rate15!;

      }
    }
    if (person! <= 30) {
      if (widget.listData![widget.index!].id == 3) {
        person_mult_price = person! * widget.listData![widget.index!].rate30!;

      } else if (widget.listData![widget.index!].id == 4) {
        person_mult_price = person! * widget.listData![widget.index!].rate30!;

      }
    }
    if (person! <= 50) {
      if (widget.listData![widget.index!].id == 3) {
        person_mult_price = person! * widget.listData![widget.index!].rate50!;

      } else if (widget.listData![widget.index!].id == 4) {
        person_mult_price = person! * widget.listData![widget.index!].rate50!;

      }
    }
    if (person! <= 75) {
      if (widget.listData![widget.index!].id == 3) {
        person_mult_price = person! * widget.listData![widget.index!].rate75!;

      } else if (widget.listData![widget.index!].id == 4) {
        person_mult_price = person! * widget.listData![widget.index!].rate75!;

      }
    }
    if (person! <= 1000) {
      if (widget.listData![widget.index!].id == 3) {
        person_mult_price = person! * widget.listData![widget.index!].rate100!;

      } else if (widget.listData![widget.index!].id == 4) {
        person_mult_price = person! * widget.listData![widget.index!].rate100!;

      }
    }
  }

  void add_services() {
    setState(() {
      services++;
      if (person! <= 15) {
        price = services * widget.listData![widget.index!].rate15!;
        totalAmount = totalAmount + widget.listData![widget.index!].rate15!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 30) {
        price = services * widget.listData![widget.index!].rate30!;
        totalAmount = totalAmount + widget.listData![widget.index!].rate30!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 50) {
        price = services * widget.listData![widget.index!].rate50!;
        totalAmount = totalAmount + widget.listData![widget.index!].rate50!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 75) {
        price = services * widget.listData![widget.index!].rate75!;
        totalAmount = totalAmount + widget.listData![widget.index!].rate75!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 1000) {
        price = services * widget.listData![widget.index!].rate100!;
        totalAmount = totalAmount + widget.listData![widget.index!].rate100!;
        producttotal = totalAmount;

        addItemToList();
      }
    });
  }

  void miuns_services() {
    setState(() {
      services--;
      if (person! <= 15) {
        price = services * widget.listData![widget.index!].rate15!;
        totalAmount = totalAmount - widget.listData![widget.index!].rate15!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 30) {
        price = services * widget.listData![widget.index!].rate30!;
        totalAmount = totalAmount - widget.listData![widget.index!].rate30!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 50) {
        price = services * widget.listData![widget.index!].rate50!;
        totalAmount = totalAmount - widget.listData![widget.index!].rate50!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 75) {
        price = services * widget.listData![widget.index!].rate75!;
        totalAmount = totalAmount - widget.listData![widget.index!].rate75!;
        producttotal = totalAmount;

        addItemToList();
      } else if (person! <= 1000) {
        price = services * widget.listData![widget.index!].rate100!;
        totalAmount = totalAmount - widget.listData![widget.index!].rate100!;
        producttotal = totalAmount;

        addItemToList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, blurRadius: 3, offset: Offset(0, 5))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  pic_list[widget.index!],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.listData![widget.index!].productname!.toUpperCase(),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppTheme().colorBlack,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                widget.listData![widget.index!].productname == "Beverage"
                    ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: Checkbox(
                          activeColor: AppTheme().colorBlack,
                          checkColor: AppTheme().colorWhite,
                          value: checkedValue_1,
                          onChanged: (value) {
                            bev_rate();
                            setState(() {
                              checkedValue_1 = value;
                            });
                          }),
                    ))
                    : widget.listData![widget.index!].productname == "Glassware"
                    ? Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: Checkbox(
                          activeColor: AppTheme().colorBlack,
                          checkColor: AppTheme().colorWhite,
                          value: checkedValue_2,
                          onChanged: (value) {
                            gls_rate();
                            setState(() {
                              checkedValue_2 = value;
                            });
                          })),
                )
                    : Container()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      children: [
                        person! <= 15
                            ? Text(
                          'Price ₹ ${widget.listData![widget.index!].rate15}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppTheme().colorBlack,
                              fontFamily: 'Montserrat-SemiBold',
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )
                            : person! <= 30
                            ? Text(
                          'Price ₹${widget.listData![widget.index!].rate30}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppTheme().colorBlack,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 10,
                          ),
                        )
                            : person! <= 50
                            ? Text(
                          'Price ₹${widget.listData![widget.index!]
                              .rate50}',
                          textAlign: TextAlign.left,
                          //overflow:TextOverflow.ellipsis ,
                          style: TextStyle(
                            color: AppTheme().colorBlack,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 10,
                          ),
                        )
                            : person! <= 75
                            ? Text(
                          'Price ₹${widget.listData![widget.index!]
                              .rate75! *
                              services}',
                          textAlign: TextAlign.left,
                          //overflow:TextOverflow.ellipsis ,
                          style: TextStyle(
                            color: AppTheme().colorBlack,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 10,
                          ),
                        )
                            : person! <= 1000
                            ? Text(
                          'Price ₹${widget
                              .listData![
                          widget
                              .index!]
                              .rate100! *
                              services}',
                          textAlign: TextAlign.left,
                          //overflow:TextOverflow.ellipsis ,
                          style: TextStyle(
                            color: AppTheme().colorBlack,
                            fontFamily:
                            'Montserrat-SemiBold',
                            fontSize: 10,
                          ),
                        )
                            : "" as Widget,
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          child: widget.listData![widget.index!].productname ==
                              "Beverage"
                              ? Row(
                            children: [
                              services == 0
                                  ? Icon(Icons.remove_circle,
                                  color: AppTheme().colorBlack)
                                  : InkWell(
                                onTap: () {
                                  // miuns_services();
                                },
                                child: Icon(Icons.remove_circle,
                                    color: AppTheme().colorWhite),
                              ),
                              person! <= 15
                                  ? Text(
                                '${person}x${widget.listData![widget.index!]
                                    .rate15}',
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().colorBlack,
                                  fontFamily: 'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 30
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget.index!]
                                    .rate30}',
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 50
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget
                                    .index!]
                                    .rate50}',
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 75
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget
                                    .index!]
                                    .rate75}',
                                textAlign:
                                TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 1000
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget.index!]
                                    .rate100}',
                                textAlign:
                                TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : "" as Widget,
                              const Padding(
                                  padding: EdgeInsets.only(left: 2)),
                            ],
                          )
                              : widget.listData![widget.index!].productname ==
                              "Glassware"
                              ? Row(
                            children: [
                              services == 0
                                  ? Icon(Icons.remove_circle,
                                  color: AppTheme().colorBlack)
                                  : InkWell(
                                onTap: () {
                                  //miuns_services();
                                },
                                child: Icon(Icons.remove_circle,
                                    color:
                                    AppTheme().colorWhite),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 2)),
                              person! <= 15
                                  ? Text(
                                '${person}x${widget.listData![widget.index!].rate15}',
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme().colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 30
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget
                                    .index!]
                                    .rate30}',
                                textAlign: TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 50
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget
                                    .index!]
                                    .rate50}',
                                textAlign:
                                TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 75
                                  ? Text(
                                '${person}x${widget
                                    .listData![
                                widget.index!]
                                    .rate75}',
                                textAlign:
                                TextAlign.left,
                                //overflow:TextOverflow.ellipsis ,
                                style: TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : person! <= 1000
                                  ? Text(
                                '${person}x${widget.listData![widget.index!]
                                    .rate100}',
                                textAlign:
                                TextAlign
                                    .left,
                                //overflow:TextOverflow.ellipsis ,
                                style:
                                TextStyle(
                                  color: AppTheme()
                                      .colorBlack,
                                  fontFamily:
                                  'Montserrat-SemiBold',
                                  fontSize: 12,
                                ),
                              )
                                  : "" as Widget,
                              const Padding(
                                  padding: EdgeInsets.only(left: 2)),
                            ],
                          )
                              : Row(
                            children: [
                              services == 0
                                  ? Icon(Icons.remove_circle,
                                  color: AppTheme().colorBlack)
                                  : InkWell(
                                onTap: () {
                                  miuns_services();
                                },
                                child: Icon(Icons.remove_circle,
                                    color:
                                    AppTheme().colorBlack),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 2)),
                              Text(
                                services == 1
                                    ? "1"
                                    : services.toString(),
                                style: TextStyle(
                                    color: AppTheme().colorBlack),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 2)),
                              InkWell(
                                onTap: () {
                                  add_services();
                                },
                                child: Icon(Icons.add_circle_sharp,
                                    color: AppTheme().colorBlack),
                              )
                            ],
                          )))
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                        color: AppTheme().colorBlack,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: person! <= 15
                            ? Text(
                          widget.listData![widget.index!].productname ==
                              "Glassware"
                              ? '₹$person_mult_price'
                              : widget.listData![widget.index!]
                              .productname ==
                              "Beverage"
                              ? '₹$person_mult_price'
                              : '₹${widget.listData![widget.index!]
                              .rate100! *
                              services}',
                          style: TextStyle(
                              color: AppTheme().colorWhite,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person! <= 30
                            ? Text(
                          widget.listData![widget.index!]
                              .productname ==
                              "Glassware"
                              ? '₹$person_mult_price'
                              : widget.listData![widget.index!]
                              .productname ==
                              "Beverage"
                              ? '₹$person_mult_price'
                              : '₹${widget.listData![widget.index!]
                              .rate100! *
                              services}',
                          style: TextStyle(
                              color: AppTheme().colorWhite,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person! <= 50
                            ? Text(
                          widget.listData![widget.index!]
                              .productname ==
                              "Glassware"
                              ? '₹$person_mult_price'
                              : widget.listData![widget.index!]
                              .productname ==
                              "Beverage"
                              ? '₹$person_mult_price'
                              : '₹${widget
                              .listData![
                          widget
                              .index!]
                              .rate100! *
                              services}',
                          style: TextStyle(
                              color: AppTheme().colorWhite,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person! <= 75
                            ? Text(
                          widget.listData![widget.index!]
                              .productname ==
                              "Glassware"
                              ? '₹$person_mult_price'
                              : widget
                              .listData![
                          widget.index!]
                              .productname ==
                              "Beverage"
                              ? '₹$person_mult_price'
                              : '₹${widget
                              .listData![
                          widget
                              .index!]
                              .rate100! *
                              services}',
                          style: TextStyle(
                              color: AppTheme().colorWhite,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : person! <= 1000
                            ? Text(
                          widget.listData![widget.index!]
                              .productname ==
                              "Glassware"
                              ? '₹$person_mult_price'
                              : widget
                              .listData![
                          widget
                              .index!]
                              .productname ==
                              "Beverage"
                              ? '₹$person_mult_price'
                              : '₹${widget.listData![widget.index!]
                              .rate100! *
                              services}',
                          style: TextStyle(
                              color:
                              AppTheme().colorWhite,
                              fontFamily: "Montserrat",
                              fontSize: 15),
                        )
                            : "" as Widget?))),
          ],
        ),
      ),
    );
  }
}
