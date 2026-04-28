import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/kost_model.dart';

class HomeController extends GetxController {
  var selectedFilter = 'Semua'.obs;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.grid_view_rounded, 'label': 'Semua'},
    {'icon': Icons.location_on_outlined, 'label': 'Terdekat'},
    {'icon': Icons.local_offer_outlined, 'label': 'Termurah'},
    {'icon': Icons.male, 'label': 'Putra'},
    {'icon': Icons.female, 'label': 'Putri'},
    {'icon': Icons.people_outline, 'label': 'Campuran'},
  ];

  List<Kost> get filteredKosts {
    if (selectedFilter.value == 'Semua') {
      return mockKosts;
    } else if (selectedFilter.value == 'Terdekat') {
      return nearbyKosts;
    } else if (selectedFilter.value == 'Termurah') {
      return List.from(mockKosts)..sort((a, b) => a.price.compareTo(b.price));
    } else {
      return mockKosts.where((k) => k.type == selectedFilter.value).toList();
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  Future<void> refreshData() async {
    // Simulasi memuat ulang data dari server
    await Future.delayed(const Duration(seconds: 1));
    selectedFilter.refresh(); // Memicu update UI untuk mensimulasikan refresh
  }
}
