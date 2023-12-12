import 'dart:math';

import 'package:flutter/material.dart';

import '../data/animal.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _kodeController = TextEditingController();
  final _infoController = TextEditingController();
  int id = 0;

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      setState(() {
        final Animal animal = args as Animal;
        id = animal.id;
        _kodeController.text = animal.kode;
        _namaController.text = animal.nama;
        _infoController.text = animal.info;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Animal'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text('Edit Animal', style: TextStyle(
                    fontSize: 24
                  ), textAlign: TextAlign.center),
                ),
                // input kode
                TextFormField(
                  controller: _kodeController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Kode'
                  )
                ),
                // input nama
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Nama'
                  ),
                ),
                // input keterangan
                TextFormField(
                  controller: _infoController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Keterangan',
                  ),
                  maxLines: 2, minLines: 1
                ),
                // tombol
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Random random = Random();
                        String kode = _kodeController.text;
                        String nama = _namaController.text;
                        String info = _infoController.text;
                        Animal animal = Animal(
                          id: id > 0 ? id : random.nextInt(100),
                          kode: kode,
                          nama: nama,
                          info: info
                        );
                        Navigator.pop(context, animal);
                      },
                      child: const Text('SIMPAN'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}