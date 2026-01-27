import { ObjectId } from "mongodb";
import { recipesCollection } from "../db/collections";

export const getGroceryList = async (recipeId: string) => {
  const recipe = await recipesCollection().findOne({
    _id: new ObjectId(recipeId)
  });

  if (!recipe) {
    throw new Error("Recipe not found");
  }

  return {
    recipeId,
    items: recipe.ingredients
  };
};
