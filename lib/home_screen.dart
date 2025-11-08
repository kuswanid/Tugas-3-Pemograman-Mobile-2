import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Kategori',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            surfaceTintColor: Colors.transparent,
            expandedHeight: 120,
            title: Row(
              children: [
                Icon(Icons.storefront, color: scheme.primary),
                const SizedBox(width: 8),
                const Text('ShopEasy'),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),
              Badge.count(
                count: 2,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(16, 90, 16, 12),
                alignment: Alignment.bottomCenter,
                child: const _SearchBar(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.9),
                itemCount: _banners.length,
                itemBuilder: (context, index) =>
                    _PromoBanner(banner: _banners[index]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Kategori'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Lihat semua'),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) => ChoiceChip(
                  label: Text(_categories[i]),
                  selected: i == 0,
                  onSelected: (_) {},
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _categories.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Flash Sale'),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 18),
                      const SizedBox(width: 6),
                      Text(_countdownString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 320,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) => SizedBox(
                  width: 150,
                  child: ProductCard(product: _flashSale[i], compact: true),
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: _flashSale.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rekomendasi'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Lihat semua'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(product: _products[index]),
                childCount: _products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.44,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 46,
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari produk, merek, atau kategori…',
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (q) {},
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.tune, color: scheme.primary),
            tooltip: 'Filter',
          ),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.banner});
  final _Banner banner;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(banner.imageUrl, fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xAA000000), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        banner.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Cek',
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.compact = false});
  final Product product;
  final bool compact;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(product.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  if (product.discountPercent != null)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '-${product.discountPercent}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Ink(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        iconSize: 20,
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        tooltip: 'Wishlist',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating.toStringAsFixed(1)}',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• ${product.sold}+',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _formatCurrency(product.finalPrice),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: scheme.primary,
                    ),
                  ),
                  if (product.discountPercent != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _formatCurrency(product.price),
                      style: const TextStyle(
                        color: Colors.black45,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Tambah'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.discountPercent,
    this.rating = 4.7,
    this.sold = 100,
  });
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final int? discountPercent;
  final double rating;
  final int sold;
  int get finalPrice => discountPercent == null
      ? price
      : (price * (100 - discountPercent!) / 100).round();
}

class _Banner {
  const _Banner({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
  final String title;
  final String subtitle;
  final String imageUrl;
}

String _formatCurrency(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final pos = s.length - i;
    buffer.write(s[i]);
    if (pos > 1 && pos % 3 == 1) buffer.write('.');
  }
  return 'Rp${buffer.toString()}';
}

String _countdownString() {
  final now = DateTime.now();
  final end = DateTime(now.year, now.month, now.day, now.hour + 3);
  final diff = end.difference(now);
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(diff.inHours)}:${two(diff.inMinutes % 60)}:${two(diff.inSeconds % 60)}';
}

final List<String> _categories = const [
  'Semua',
  'Fashion',
  'Elektronik',
  'Kesehatan',
  'Olahraga',
  'Rumah',
  'Bayi',
  'Hobi',
  'Gaming',
];
final List<_Banner> _banners = const [
  _Banner(
    title: 'Diskon 11.11',
    subtitle: 'Serba hemat sepanjang hari',
    imageUrl:
        'https://images.unsplash.com/photo-1542831371-29b0f74f9713?q=80&w=1600&auto=format&fit=crop',
  ),
  _Banner(
    title: 'Elektronik Terlaris',
    subtitle: 'Upgrade gadget-mu',
    imageUrl:
        'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1600&auto=format&fit=crop',
  ),
  _Banner(
    title: 'Fashion & Style',
    subtitle: 'Diskon hingga 70%',
    imageUrl:
        'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?q=80&w=1600&auto=format&fit=crop',
  ),
];
final List<Product> _flashSale = [
  Product(
    id: 'fs1',
    name: 'Earbuds Wireless BT 5.3',
    price: 249000,
    discountPercent: 30,
    imageUrl: 'https://picsum.photos/seed/earbuds/600/600',
    rating: 4.8,
    sold: 850,
  ),
  Product(
    id: 'fs2',
    name: 'Smartwatch AMOLED',
    price: 599000,
    discountPercent: 35,
    imageUrl: 'https://picsum.photos/seed/watch/600/600',
    rating: 4.6,
    sold: 1200,
  ),
  Product(
    id: 'fs3',
    name: 'Sneakers Lightweight',
    price: 329000,
    discountPercent: 25,
    imageUrl: 'https://picsum.photos/seed/sneaker/600/600',
    rating: 4.7,
    sold: 640,
  ),
];
final List<Product> _products = [
  Product(
    id: 'p1',
    name: 'Keyboard Mekanik 60% RGB',
    price: 749000,
    discountPercent: 20,
    imageUrl: 'https://picsum.photos/seed/keyboard/600/600',
    rating: 4.9,
    sold: 320,
  ),
  Product(
    id: 'p2',
    name: 'Kaos Oversize Unisex',
    price: 99000,
    discountPercent: 10,
    imageUrl: 'https://picsum.photos/seed/tshirt/600/600',
    rating: 4.5,
    sold: 1500,
  ),
  Product(
    id: 'p3',
    name: 'Air Fryer 4L Hemat Listrik',
    price: 899000,
    discountPercent: 22,
    imageUrl: 'https://picsum.photos/seed/airfryer/600/600',
    rating: 4.7,
    sold: 870,
  ),
  Product(
    id: 'p4',
    name: 'Serum Niacinamide 10%',
    price: 129000,
    discountPercent: 15,
    imageUrl: 'https://picsum.photos/seed/serum/600/600',
    rating: 4.6,
    sold: 210,
  ),
  Product(
    id: 'p5',
    name: 'Dumbbell Adjustable 20kg',
    price: 1199000,
    discountPercent: 28,
    imageUrl: 'https://picsum.photos/seed/dumbbell/600/600',
    rating: 4.8,
    sold: 430,
  ),
  Product(
    id: 'p6',
    name: 'Lampu LED Smart Wi‑Fi',
    price: 79000,
    discountPercent: 18,
    imageUrl: 'https://picsum.photos/seed/bulb/600/600',
    rating: 4.4,
    sold: 980,
  ),
];
