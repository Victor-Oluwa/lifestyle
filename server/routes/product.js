const express = require("express");
const productRouter = express.Router();
const auth = require("../middleweres/auth");
// const admin = require("../middlewares/admin");
const { Product } = require("../models/product");

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    //console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: console.log(e.message) });
  }
});

//get Request for search query
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: console.log(e.message) });
  }
});

productRouter.get('/product/quantity/:productId', auth, async (req, res) => {
  try {
    const { productId } = req.params;

    let product = await findProductById(productId);
    let quantity = getProductQuantity(product);
    res.status(200).json(quantity);

  } catch (e) {
    res.status(500).json(`Failed to get quantity: ${e}`);
  }

  async function findProductById(id) {
    let product = await Product.findById(id);

    if (!product) {
      throw new Error(`Product not found`);
    }
    return product;
  }

  function getProductQuantity(product) {
    try {
      const quantity = product.inStock;
      console.log(`Product quantity: ${quantity}`);

      return quantity;
    } catch (error) {
      throw new Error(`product.quantity failed: ${error}`);
    }

  }
});


module.exports = productRouter;
