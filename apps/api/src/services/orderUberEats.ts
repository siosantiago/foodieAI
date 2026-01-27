import { ObjectId } from "mongodb";
import { recipesCollection } from "../db/collections";

const buildUberEatsLink = (ingredients: string[]) => {
  const query = encodeURIComponent(ingredients.join(", "));
  return `https://www.ubereats.com/search?q=${query}`;
};

export const createUberEatsOrderLink = async (
  recipeId: string,
  userLocation?: string
) => {
  const recipe = await recipesCollection().findOne({
    _id: new ObjectId(recipeId)
  });
  if (!recipe) {
    throw new Error("Recipe not found");
  }

  const ingredients = recipe.ingredients.map((item) => item.name);
  const link = buildUberEatsLink(ingredients);

  return {
    recipeId,
    provider: "ubereats",
    userLocation: userLocation ?? null,
    orderLink: link,
    items: ingredients
  };
};
