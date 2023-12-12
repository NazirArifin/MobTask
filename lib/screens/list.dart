import 'package:flutter/material.dart';

import '../data/animal.dart';

class ListSceen extends StatefulWidget {
  const ListSceen({Key? key}) : super(key: key);

  @override
  State<ListSceen> createState() => _ListSceenState();
}

class _ListSceenState extends State<ListSceen> {
  final List<Animal> _animalList = [];
  Animal? _selected;

  @override
  void initState() {
    super.initState();

    setState(() {
      _animalList.add(Animal(
        id: 1,
        kode: 'cat',
        nama: 'Kucing',
        info: 'Kucing disebut juga kucing domestik atau kucing rumah (nama ilmiah: Felis silvestris catus atau Felis catus)'
      ));
      _animalList.add(Animal(
        id: 2,
        kode: 'dog',
        nama: 'Anjing',
        info: 'Anjing adalah sejenis mamalia karnivora dari keluarga Canidae. Seekor anjing liar memiliki berat 70 sampai 120 pon (32 sampai 54 kg) dan tinggi 23 sampai 25 inci (58 sampai 63 cm) di bagian pundak.'
      ));
      _animalList.add(Animal(
        id: 3,
        kode: 'bird',
        nama: 'Burung',
        info: 'Burung adalah kelompok hewan yang memiliki bulu dan sayap. Umumnya, burung dapat terbang meskipun ada beberapa jenis burung yang tidak dapat terbang seperti burung unta dan burung unta.'
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dynamic result = await Navigator.pushNamed(context, '/add');
          if (result != null) {
            setState(() {
              _animalList.add(result);
            });
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Animals'),
        actions: <Widget>[
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _selected != null ? 1 : 0,
            child: IconButton(
              onPressed: () async {
                final dynamic result = await Navigator.pushNamed(context, '/add', arguments: _selected);
                if (result != null) {
                  setState(() {
                    final index = _animalList.indexWhere((element) => element.id == _selected?.id);
                    _animalList[index] = result;
                    _selected = null;
                  });
                }
              }, 
              icon: const Icon(Icons.edit)
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _selected != null ? 1 : 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _animalList.removeWhere((element) => element.id == _selected?.id);
                  _selected = null;
                });
              },
              icon: const Icon(Icons.delete)
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Animal item = _animalList[index];
          
          return GestureDetector(
            onLongPress: () {
              setState(() => _selected = item);
            },
            onTap: () {
              if (_selected != null) {
                setState(() => _selected = null);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: _selected?.id == item.id ? Colors.blue.shade100 : Colors.transparent,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage('https://loremflickr.com/480/480/${item.kode}'),
                ),
                title: Text(item.nama),
                subtitle: Text(item.info, overflow: TextOverflow.ellipsis)
              ),
            ),
          );
        }, 
        separatorBuilder: (context, index) {
          return const Divider();
        }, 
        itemCount: _animalList.length
      ),
    );
  }
}