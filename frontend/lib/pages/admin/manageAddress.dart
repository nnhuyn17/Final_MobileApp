import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageAddress extends StatefulWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  List<Map<String, dynamic>> addresses = [];
  bool isLoading = false;
  String? errorMessage;

  // State variables for province, district, and ward
  List<String> provinces = [];
  Map<String, String> provinceIdMap = {};
  String? selectedProvince;
  List<String> districts = [];
  Map<String, String> districtIdMap = {};
  String? selectedDistrict;
  List<String> wards = [];
  String? selectedWard;
  TextEditingController otherInfoController = TextEditingController(); // Controller for other information

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url = Uri.parse('https://backend-final-web.onrender.com/getAlladdress');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Status'] == 'Success') {
          setState(() {
            addresses = List<Map<String, dynamic>>.from(data['address']);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Error: ${data['Status']}';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'HTTP Error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: $error';
        isLoading = false;
      });
    }

    // Fetch provinces
    try {
      final provinceResponse = await http.get(Uri.parse('https://vapi.vnappmob.com/api/province'));
      if (provinceResponse.statusCode == 200) {
        final provinceData = json.decode(provinceResponse.body);
        final List<dynamic> provinceList = provinceData['results'];

        // Clear existing map entries
        provinceIdMap.clear();

        // Populate the provinceIdMap
        for (var province in provinceList) {
          String provinceId = province['province_id'];
          String provinceName = province['province_name'];
          provinceIdMap[provinceName] = provinceId;
        }

        final List<String> provinceNames = provinceList.map((e) => e['province_name'].toString()).toList();
        setState(() {
          provinces = provinceNames;
        });
      } else {
        // Handle error fetching provinces
      }
    } catch (error) {
      // Handle error fetching provinces
    }
  }

  Future<void> fetchDistricts(String? provinceId) async {
    if (provinceId != null) {
      setState(() {
        selectedDistrict = null; // Reset selected district
        districts.clear(); // Clear the previous districts
        districtIdMap.clear(); // Clear previous district IDs
        wards.clear(); // Clear wards since districts changed
        selectedWard = null; // Reset selected ward
      });
      final url = Uri.parse('https://vapi.vnappmob.com/api/province/district/$provinceId');
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['results'] != null) {
            final districtList = data['results'];
            for (var district in districtList) {
              String districtId = district['district_id'];
              String districtName = district['district_name'];
              districtIdMap[districtName] = districtId;
            }
            setState(() {
              districts = List<String>.from(districtList.map((result) => result['district_name']));
            });
          } else {
            // Handle no districts found for the province
          }
        } else {
          // Handle HTTP error
        }
      } catch (error) {
        // Handle network error
      }
    }
  }

  Future<void> fetchWards(String? districtName) async {
    if (districtName != null) {
      final districtId = districtIdMap[districtName];
      print(districtId);
      if (districtId != null) {
        setState(() {
          selectedWard = null; // Reset selected ward
          wards.clear(); // Clear the previous wards
        });
        final url = Uri.parse('https://vapi.vnappmob.com/api/province/ward/$districtId');
        try {
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data['results'] != null) {
              setState(() {
                wards = List<String>.from(data['results'].map((result) => result['ward_name']));
                print(wards);
              });
            } else {
              // Handle no wards found for the district
            }
          } else {
            // Handle HTTP error
          }
        } catch (error) {
          // Handle network error
        }
      }
    }
  }

  void updateAddress(int id) async {
    print(id);
    // Merge all information to form the updated address
    final otherInformation = otherInfoController.text;
    final updatedAddress = '$otherInformation, $selectedWard, $selectedDistrict, $selectedProvince';
    print(updatedAddress);

    // Send updated address to backend
    final url = Uri.parse('https://backend-final-web.onrender.com/UpdateAddressByID/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'address': updatedAddress});

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Address updated successfully
        fetchData(); // Refresh the address list
      } else {
        // Handle error updating address
        print('Failed to update address. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle error updating address
      print('Error updating address: $error');
    }
  }

  void addNewAddress() {
    // Show popup to add a new address
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Address'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select Province'),
                    value: selectedProvince,
                    onChanged: (newValue) {
                      setState(() {
                        selectedProvince = newValue;
                        fetchDistricts(provinceIdMap[newValue] ?? '');
                      });
                    },
                    items: provinces.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    hint: Text('Select District'),
                    value: selectedDistrict,
                    onChanged: (newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                        wards.clear();
                        fetchWards(newValue);
                      });
                    },
                    items: districts.isNotEmpty
                        ? districts.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                        : [
                      DropdownMenuItem(
                        value: null,
                        child: Text('Loading districts...'),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    hint: Text('Select Ward'),
                    value: selectedWard,
                    onChanged: (newValue) {
                      setState(() {
                        selectedWard = newValue;
                      });
                    },
                    items: wards.isNotEmpty
                        ? wards.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                        : [
                      DropdownMenuItem(
                        value: null,
                        child: Text('Loading wards...'),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: otherInfoController,
                    decoration: InputDecoration(
                      hintText: 'Enter Other Information',
                      labelText: 'Other Information',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform add new address logic
                    addAddress();
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void addAddress() async {
    final otherInformation = otherInfoController.text;
    final newAddress = '$otherInformation, $selectedWard, $selectedDistrict, $selectedProvince';
    print(newAddress);

    final url = Uri.parse('https://backend-final-web.onrender.com/createAddress');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'address': newAddress});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        // Address added successfully
        fetchData(); // Refresh the address list
      } else {
        // Handle error adding address
        print('Failed to add address. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle error adding address
      print('Error adding address: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Addresses'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Number of addresses: ${addresses.length}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return ListTile(
                  title: Text(address['address']),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Show popup to edit
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text('Edit Address'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DropdownButton<String>(
                                      hint: Text('Select Province'),
                                      value: selectedProvince,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedProvince = newValue;
                                          fetchDistricts(provinceIdMap[newValue] ?? '');
                                        });
                                      },
                                      items: provinces.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: 10),
                                    DropdownButton<String>(
                                      hint: Text('Select District'),
                                      value: selectedDistrict,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedDistrict = newValue;
                                          wards.clear();
                                          fetchWards(newValue);
                                        });
                                      },
                                      items: districts.isNotEmpty
                                          ? districts.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                          : [
                                        DropdownMenuItem(
                                          value: null,
                                          child: Text('Loading districts...'),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    DropdownButton<String>(
                                      hint: Text('Select Ward'),
                                      value: selectedWard,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedWard = newValue;
                                        });
                                      },
                                      items: wards.isNotEmpty
                                          ? wards.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                          : [
                                        DropdownMenuItem(
                                          value: null,
                                          child: Text('Loading wards...'),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: otherInfoController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Other Information',
                                        labelText: 'Other Information',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Perform update logic
                                      updateAddress(address['id']);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Update'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: addresses.length < 4
          ? FloatingActionButton(
        onPressed: addNewAddress,
        child: Icon(
          Icons.add,
          color: Colors.black, // Change the icon color here
        ),
        backgroundColor: Colors.blue, // Change the background color here
        tooltip: 'Add Address',
      )
          : null,
    );
  }
}
