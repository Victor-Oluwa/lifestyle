const express = require("express");
const auth = require("../middleweres/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");
const userRouter = express.Router();

userRouter.post('/cart/update-quantity', auth, async (req, res) => {
  try {
    const { productId, quantity } = req.body;
    let user = await findUserById();
    let product = await findProductById(productId);

    let updatedUser = await updateCartQuantity(quantity, user, product);

    user = await updatedUser.save();
    product = await product.save();
    res.status(200).json(user);

  } catch (e) {
    res.status(500).json(`Failed to update quantity ${e}`);

  }


  async function findProductById(id) {
    let product = await Product.findById(id);
    if (!product) {
      throw new Error('Product not found');
    }
    return product;
  }

  async function findUserById() {
    let user = await User.findById(req.user);
    if (!user) {
      throw new Error('User not found');
    }
    return user;
  }

  async function updateCartQuantity(quantity, user, product) {
    let cart = user.cart;
    let cartItem = cart.find((item) => item.product._id.equals(product._id));

    if (!cartItem) {
      throw new Error('Cart item not found');
    }

    // if (typeof product.inStock === 'number' && quantity <= product.inCart) {
    //   product.inCart = cartItem.product.inStock;
    //   product.inStock -= quantity;
    // } else {
    //   product.inStock = 0;
    // }

    // if (cartItem > quantity) {
    //   product.inStock = product.inStock + (cartItem.quantity - quantity);

    // }

    if (typeof product.inStock === 'number' && quantity != 0) {
      cartItem.quantity = quantity;
    }

    return user;
  }

});




userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await findProductById(id);

    if (product.inStock === 0) {
      return res.status(404).json(`${product.name} is out of stock`);
    }

    let user = await findUserById();

    let isProductFound = user.cart.some((cartItem) =>
      cartItem.product._id.equals(product._id)
    );

    if (isProductFound) {
      product = await updateQuantity(product, user)
      product = await product.save();

    } else {
      pushToCart(product, user)
      product = await product.save();

    }

    user = await user.save();
    res.status(200).json(user);
  } catch (error) {
    console.log(error);
    res.status(500).json(`Failed to add product to cart: ${error}`);
  }

  async function findProductById(id) {
    let product = await Product.findById(id);
    if (!product) {
      throw new Error(`Product not found`);
    }
    return product;
  }

  async function findUserById() {
    let user = await User.findById(req.user);
    if (!user) {
      throw new Error(`Product not found`);
    }
    return user;
  }

  async function updateQuantity(product, user) {
    let userCarts = user.cart;
    let cart = await userCarts.find((cartItem) => cartItem.product._id.equals(product._id));

    if (cart.quantity < product.inStock) {
      cart.quantity += 1;
      updateInCartValue(product)
    }
    return product;
  }

  async function pushToCart(product, user) {
    let userCart = user.cart;
    userCart.push({ product, quantity: 1 });
    updateInCartValue(product);
    return product;
  }

  function updateInCartValue(product) {
    if (product.inCart < product.inStock) {
      product.inCart += 1;
    }
  }
});


userRouter.post("/api/order", auth, async (req, res) => {
  let products = [];
  let outOfStock = [];
  try {
    const { cart, totalPrice, address, userName } = req.body;

    for (let index = 0; index < cart.length; index++) {
      const cartItem = cart[index];
      const product = await findProductById(cartItem);

      if (product.inStock >= cartItem.quantity) {
        products.push({
          product: product,
          quantity: cartItem.quantity,
        });
        await product.save();

      } else {
        outOfStock.push({
          product: product,
          requested: cartItem.quantity,
        });
      }
    }



    if (outOfStock.length > 0) {
      await updateProductQuantity(cart);
      return res.status(404).json(outOfStock);
    }

    let order = new Order({
      products: products,
      totalPrice,
      address,
      customerName: userName,
      userId: req.user,
      orderTime: new Date().getTime(),
    });
    order = await order.save();

    res.status(200).json(order);
  } catch (error) {

    res.status(400).json(`Some items are out of stock`);

  }

  async function findProductById(cartItem) {
    const product = await Product.findById(cartItem.product._id);
    if (!product) {
      throw new Error(`Product not found`)
    }
    return product;
  }

  async function updateProductQuantity(cart) {
    for (let index = 0; index < cart.length; index++) {
      let cartItem = cart[index];
      const product = await findProductById(cartItem);
      product.inStock -= cartItem.quantity;
    }
  }
});










userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  const catchCode = 500;

  try {
    const { id } = req.params;
    let product = await findProductById(id);
    let user = await findUserById(req.user);

    user.cart = await updateUserCart(user.cart, product);
    product = await restoreProductQuantity(product.id);


    user = await user.save();
    product = await product.save();

    res.json(user);
  } catch (e) {
    res.status(catchCode).json({ error: e.message });
    console.error(e);
  }

  async function findProductById(id) {
    let product = await Product.findById(id);
    if (!product) {
      throw new Error('Product not found');
    }
    return product;
  }

  async function findUserById(id) {
    const user = await User.findById(id);
    if (!user) {
      throw new Error('Product not found');
    }
    return user;
  }

  async function restoreProductQuantity(id) {
    let product = await findProductById(id);

    product.inStock += 1;
    // product.inStock += 1;

    return product;
  }

  async function updateUserCart(cart, product) {
    return cart.map(item => {
      if (item.product._id.equals(product._id)) {
        return item.quantity == 1 ? null : { ...item, quantity: item.quantity - 1 };
      }
      return item;
    }).filter(Boolean);
  }




});

userRouter.delete(
  "/api/remove-deleted-from-cart/:id",
  auth,
  async (req, res) => {
    try {
      const { id } = req.params;
      const products = await Product.find({});
      let user = await User.findById(req.user);

      const cartIds = user.cart.map((item) => item.product._id);
      const filteredCart = user.cart.filter((item) =>
        products.some((product) => product._id.equals(item.product._id))
      );

      user.cart = filteredCart;

      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
      console.log(e);
    }
  }
);

userRouter.delete("/api/delete-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    let product = await findProductById(id);
    let user = await findUserById(req.user);

    await restoreProductQuantity(product, user);
    await deleteCart(user, id);

    console.log("Cart Product Deleted");

    user = await user.save();
    product = await product.save();
    res.json(user);

  } catch (e) {
    res.status(500).json('Failed to delete product');
    console.log(e);
  }

  async function findProductById(id) {
    let product = await Product.findById(id);
    if (!product) {
      throw new Error('Product not found');
    }
    return product;
  }

  async function findUserById(id) {
    let user = await User.findById(id);
    console.log('User was found:' + user);
    if (!user) {
      throw new Error('User not found');
    }
    return user;
  }

  async function deleteCart(user, id) {
    let cartIndex = user.cart.findIndex((cart) => cart.product._id.equals(id));

    if (cartIndex == -1) {
      throw new Error('Cart product not found');
    }
    user.cart.splice(cartIndex, 1);

  }

  async function restoreProductQuantity(product, user) {
    let cartProduct = user.cart.find((cart) => cart.product._id.equals(product._id));
    if (!cartProduct) {
      throw new Error('Failed to restore product quantity: Product not found');
    }

    product.inStock += cartProduct.quantity;

  }
});

userRouter.post("/api/save-billing-details", auth, async (req, res) => {
  try {
    const { address, phone } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user.phone = phone;
    user = await user.save();
    res.status(200).json(user);
  } catch (e) {
    res.status(500).json({ error: "Failed to save billing data: " + e.message });
  }
});



userRouter.get("/api/orders/me", auth, async (req, res) => {
  try {
    const orders = await findOrdersByUserId(req.user);
    res.status(200).json(orders);
  } catch (e) {
    res.status(404).json(`Failed to fetch your orders ${e}`);

  }

  async function findOrdersByUserId(userId) {
    const orders = await Order.find({ userId: userId });
    if (!orders) {
      throw new Error('Orders not found');
    }
    return orders;
  }
});

userRouter.put("/api/change/profile-picture", async (req, res) => {
  try {
    const { id, image } = req.body;
    console.log(`Passed ID: ${id}`);
    const filter = { _id: id };
    const options = { new: true };
    const update = { picture: image };

    let user = await updateUserAddress(filter, options, update);

    if (user != null) {
      user = await user.save();
      res.status(200).json(user);
    } else {
      res.status(404).json("Failed to update user profile picture");
    }

  } catch (e) {
    console.log(e);
  }

  async function updateUserAddress(filter, options, newValue) {
    if (filter.isEmpty || filter == null) {
      res.status(404).json(`Failed to update profile picture. You provided an empty user ID`)
    } else if (newValue.isEmpty || newValue == null) {
      res.status(404).json(`Failed to update profile picture. You provided an empty user ID photo URL`)

    }
    return await User.findOneAndUpdate(filter, newValue, options);

  }
});


userRouter.post('/order/approve', async (req, res) => {
  try {
    const { orderId, userId } = req.body;
    let order = await Order.findById(orderId);
    let user = await User.findById(userId);


    if (order) {
      await approveOrder(order);
      order = await order.save();
      res.status(201).json(user);
    }

  } catch (e) {
    console.log('Order Approval Error: ' + e);
    // res.status(500).json({ error: e.toString() });
  }

  async function approveOrder(order) {
    order.paid = true;
  }
});

userRouter.get('/cart/sync/:userId', async (req, res) => {
  try {
    const { userId } = req.params;
    let user = await findUserById(userId);
    let userCart = getUserCart(user);
    user = await user.save();
    console.log(userCart);
    res.status(200).json(userCart);

  } catch (e) {
    console.log(`Failed to get user cart ${e}`);
    res.status(500).json(`Failed to get user cart ${e}`);
  }

  async function findUserById(id) {
    let user = await User.findById(id);

    if (!user) {
      throw new Error(`User not found`);
    }
    return user
  }

  function getUserCart(user) {
    userCart = user.cart;
    return userCart;
  }
});


module.exports = userRouter;
