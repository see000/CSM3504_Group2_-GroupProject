import 'package:intl/intl.dart';

import '../model/fleet.dart';

final List<Fleet> fleetList = [
  Fleet(
    'F-1',
    "Car",
    DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
    "Johor",
    "Active",
  ),
  Fleet(
      'F-2',
      "Bike",
      DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      "Selangor",
      "Active"),
  Fleet(
      'F-3',
      "Lorry",
      DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      "Kuala Lumpur",
      "Active"),
  Fleet(
    'F-4',
    "Car",
    DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
    "Perlis",
    "Active",
  ),
  Fleet(
      'F-5',
      "Lorry",
      DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      "Kelantan",
      "Active"),
  Fleet(
      'F-6',
      "Lorry",
      DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      "Kelantan",
      "Active"),
  Fleet(
      'F-7',
      "Lorry",
      DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      "Kelantan",
      "Active"),
  Fleet(
      'F-8',
      "Lorry",
      DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
      "Kelantan",
      "Active")
];
