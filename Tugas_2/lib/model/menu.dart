class Menu {
  String image;
  String name;
  int price;

  Menu({
    required this.image,
    required this.name,
    required this.price,
  });
}

var getData = [
  Menu(
    image: "https://media.suara.com/pictures/970x544/2021/09/11/51670-big-mac-beef-rasher.jpg",
    name: "Big Mac",
    price: 50000,
  ),
  Menu(
    image:"https://cdn-2.tstatic.net/jakarta/foto/bank/images/es-krim-mcflurry.jpg",
    name: "Mc Flurry",
    price: 15000,
  ),
  Menu(
    image:"https://nilaigizi.com/assets/images/produk/produk_1582689482.jpg",
    name: "Mc Muffin",
    price: 35000,
  ),
  Menu(
    image: "https://d1sag4ddilekf6.azureedge.net/compressed/items/IDGFSTI00001mce1543417287791458440/photo/a8f4132e_TPO111084.jpg",
    name: "Chicken Spicy",
    price: 17500,
  ),
  Menu(
    image: "https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1637809781/I4St3X7jFbDeXYREbXo1_kpyuuw.jpg",
    name: "Chicken",
    price: 15000,
  ),
];
