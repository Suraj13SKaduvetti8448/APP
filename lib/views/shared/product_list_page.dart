import 'package:flutter/material.dart';
import '../../core/constants.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _search = TextEditingController();
  String _category = 'All';
  String _sort = 'Name ↑';

  // Mock products front-end only
  final List<_P> _all = [
    _P('Classic Wooden Chair', 'Chair', 12999, AppConst.mockProduct),
    _P('Minimal Coffee Table', 'Table', 15999, 'https://images.unsplash.com/photo-1582582494700-9509b8d03d4f?w=800&q=60'),
    _P('Modern Sofa 3-Seater', 'Sofa', 45999, 'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=800&q=60'),
    _P('Study Desk Pro', 'Table', 21999, 'https://images.unsplash.com/photo-1598300053656-5a0d4b5a5d4f?w=800&q=60'),
    _P('Ergo Office Chair', 'Chair', 18999, 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=800&q=60'),
  ];

  List<_P> get _filtered {
    var list = _all.where((p) {
      final q = _search.text.trim().toLowerCase();
      final matchText = q.isEmpty || p.name.toLowerCase().contains(q);
      final matchCat = _category == 'All' || p.category == _category;
      return matchText && matchCat;
    }).toList();

    switch (_sort) {
      case 'Price ↑': list.sort((a,b)=>a.price.compareTo(b.price)); break;
      case 'Price ↓': list.sort((a,b)=>b.price.compareTo(a.price)); break;
      case 'Name ↓': list.sort((a,b)=>b.name.compareTo(a.name)); break;
      default: list.sort((a,b)=>a.name.compareTo(b.name));
    }
    return list;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cols = width < 640 ? 1 : width < 980 ? 2 : 3;

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Wrap(
              spacing: 12, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search products...',
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : IconButton(
                        onPressed: () {
                          _search.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                DropdownButton<String>(
                  value: _category,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All categories')),
                    DropdownMenuItem(value: 'Chair', child: Text('Chair')),
                    DropdownMenuItem(value: 'Table', child: Text('Table')),
                    DropdownMenuItem(value: 'Sofa', child: Text('Sofa')),
                  ],
                  onChanged: (v) => setState(() => _category = v!),
                ),
                DropdownButton<String>(
                  value: _sort,
                  items: const [
                    DropdownMenuItem(value: 'Name ↑', child: Text('Name ↑')),
                    DropdownMenuItem(value: 'Name ↓', child: Text('Name ↓')),
                    DropdownMenuItem(value: 'Price ↑', child: Text('Price ↑')),
                    DropdownMenuItem(value: 'Price ↓', child: Text('Price ↓')),
                  ],
                  onChanged: (v) => setState(() => _sort = v!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                childAspectRatio: 4/3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final p = _filtered[i];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(p.image, width: double.infinity, fit: BoxFit.cover),
                        ),
                        ListTile(
                          title: Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text('${p.category} • ₹${p.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _P {
  final String name; final String category; final int price; final String image;
  _P(this.name, this.category, this.price, this.image);
}
