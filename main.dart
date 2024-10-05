import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopi App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.brown[50],
      ),
      home: SplashScreen(),
    );
  }
}

// SplashScreen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://static.vecteezy.com/system/resources/previews/007/790/471/non_2x/coffee-cup-icon-coffee-logo-cafe-coffee-shop-coffee-isolated-on-white-background-coffee-shop-illustration-simple-sign-free-vector.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

// LoginPage with professional design
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'user' && password == 'password') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Username or Password is incorrect'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF613613),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.shutterstock.com/shutterstock/photos/1097478925/display_1500/stock-vector-default-avatar-profile-icon-vector-social-media-user-image-1821037612.jpg',
              width: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat Datang Kembali!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                primary: Color(0xFF997950),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Forgot password functionality
              },
              child: Text('Lupa Password?'),
            ),
          ],
        ),
      ),
    );
  }
}

// HomePage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Kopi'),
        backgroundColor: Color(0xFF613613),
      ),
      body: MenuPage(
        onAddToCart: (item) {
          setState(() {
            cartItems.add(item);
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Akun'),
  ],
  onTap: (index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(cartItems: cartItems),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountPage(),
        ),
      );
    }
  },
),

    );
  }
}

// MenuPage
class MenuPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  MenuPage({required this.onAddToCart});

  final List<String> coffeeTypes = ['Ekspreso', 'Capucino', 'Mocachino', 'Latte', 'Mocha'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Kopi', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF613613),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: coffeeTypes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(
                          coffeeName: coffeeTypes[index],
                          onAddToCart: onAddToCart,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.brown[50],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.coffee, size: 50, color: Colors.brown[800]),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            coffeeTypes[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800],
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.brown[400]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// OrderPage
class OrderPage extends StatefulWidget {
  final String coffeeName;
  final Function(Map<String, dynamic>) onAddToCart;

  OrderPage({required this.coffeeName, required this.onAddToCart});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int orderCount = 1;
  double sugarAmount = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffeeName),
        backgroundColor: Color(0xFF613613),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Jumlah Pemesanan: $orderCount'),
            Slider(
              value: sugarAmount,
              min: 0,
              max: 20,
              divisions: 20,
              label: '${sugarAmount.toStringAsFixed(1)} gram gula',
              onChanged: (value) {
                setState(() {
                  sugarAmount = value;
                });
              },
            ),
            Text('Gula: ${sugarAmount.toStringAsFixed(1)} gram'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke menu
                  },
                  child: Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Terima kasih telah memesan!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Pesan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onAddToCart({
                      'name': widget.coffeeName,
                      'orderCount': orderCount,
                      'sugarAmount': sugarAmount,
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Keranjang'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// CartPage
class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        backgroundColor: Color(0xFF613613),
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text('Keranjang Kosong'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text(
                            'Jumlah: ${item['orderCount']} - Gula: ${item['sugarAmount']} gram'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              widget.cartItems.removeAt(index); // Hapus item
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: widget.cartItems.isNotEmpty
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Checkout'),
                                content: Text('Terima kasih telah melakukan pemesanan!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.cartItems.clear(); // Kosongkan keranjang
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        : null,
                    child: Text('Checkout'),
                  ),
                ),
              ],
            ),
    );
  }
}




// AccountPage
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF613613),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/user-profile.png'), // Placeholder
            ),
            SizedBox(height: 20),
            Text('Informasi Akun', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown[700])),
            SizedBox(height: 10),
            ListTile(
              title: Text('Username', style: TextStyle(fontSize: 18)),
              subtitle: Text('nama_pengguna', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Aksi edit username
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Edit Username'),
                      content: TextField(
                        decoration: InputDecoration(hintText: 'Masukkan username baru'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Simpan username baru
                            Navigator.pop(context);
                          },
                          child: Text('Simpan'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text('Email', style: TextStyle(fontSize: 18)),
              subtitle: Text('email@example.com', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            ),
            ListTile(
              title: Text('No. HP', style: TextStyle(fontSize: 18)),
              subtitle: Text('081234567890', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            ),
            ListTile(
              title: Text('Gender', style: TextStyle(fontSize: 18)),
              subtitle: Text('Perempuan', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: Colors.brown[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Logout', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
