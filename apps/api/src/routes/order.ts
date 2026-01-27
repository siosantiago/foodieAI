import { Router } from "express";
import { createUberEatsOrderLink } from "../services/orderUberEats";

export const orderRouter = Router();

orderRouter.post("/ubereats", async (req, res, next) => {
  try {
    const { recipeId, userLocation } = req.body as {
      recipeId?: string;
      userLocation?: string;
    };
    if (!recipeId) {
      return res.status(400).json({ error: "recipeId is required" });
    }
    const order = await createUberEatsOrderLink(recipeId, userLocation);
    return res.json(order);
  } catch (error) {
    return next(error);
  }
});
