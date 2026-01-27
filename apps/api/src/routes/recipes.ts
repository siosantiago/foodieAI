import { Router } from "express";
import { createRecipeFromTranscript } from "../services/recipeService";
import { getGroceryList } from "../services/groceryService";

export const recipeRouter = Router();

recipeRouter.post("/", async (req, res, next) => {
  try {
    const { transcriptId, videoUrl } = req.body as {
      transcriptId?: string;
      videoUrl?: string;
    };
    const recipe = await createRecipeFromTranscript({ transcriptId, videoUrl });
    return res.json(recipe);
  } catch (error) {
    return next(error);
  }
});

recipeRouter.get("/grocery-list/:recipeId", async (req, res, next) => {
  try {
    const { recipeId } = req.params;
    const list = await getGroceryList(recipeId);
    return res.json(list);
  } catch (error) {
    return next(error);
  }
});
