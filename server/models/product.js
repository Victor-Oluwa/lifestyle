const mongoose = require("mongoose");
const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  createdAt: {
    type: String,
    default: "",
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  models: [
    {
      type: String,
      default: "",
    },
  ],
  inStock: {
    type: Number,
    required: true,
  },
  inCart: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    // required: true,
  },
  // Ratings s
});
//Changed 'product' to "Product"

const Product = mongoose.model("product", productSchema);
module.exports = { Product, productSchema };
