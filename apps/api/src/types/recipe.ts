import { z } from "zod";

export const IngredientSchema = z.object({
  name: z.string().min(1),
  quantity: z.string().min(1)
});

export const StepSchema = z.object({
  order: z.number().int().positive(),
  instruction: z.string().min(1)
});

export const RecipeSchema = z.object({
  title: z.string().min(1),
  servings: z.number().int().positive().optional(),
  ingredients: z.array(IngredientSchema).min(1),
  steps: z.array(StepSchema).min(1),
  notes: z.array(z.string()).optional()
});

export type Ingredient = z.infer<typeof IngredientSchema>;
export type Step = z.infer<typeof StepSchema>;
export type Recipe = z.infer<typeof RecipeSchema>;

export const validateRecipe = (candidate: unknown): Recipe => {
  return RecipeSchema.parse(candidate);
};
