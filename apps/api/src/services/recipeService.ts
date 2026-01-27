import { RecipeAgent } from "../agents/recipeAgent";
import { recipesCollection } from "../db/collections";
import { ingestVideo, getTranscriptById } from "./videoIngest";

export const createRecipeFromTranscript = async (params: {
  transcriptId?: string;
  videoUrl?: string;
}) => {
  let transcriptRecord = null;
  let transcriptId = params.transcriptId;
  let videoUrl = params.videoUrl ?? "";

  if (!transcriptId) {
    if (!videoUrl) {
      throw new Error("transcriptId or videoUrl is required");
    }
    const ingest = await ingestVideo(videoUrl);
    transcriptId = ingest.transcriptId;
  }

  transcriptRecord = await getTranscriptById(transcriptId);
  if (!transcriptRecord) {
    throw new Error("Transcript not found");
  }
  videoUrl = transcriptRecord.videoUrl;

  const agent = new RecipeAgent();
  const recipe = await agent.createRecipe(transcriptRecord.transcript);

  const result = await recipesCollection().insertOne({
    transcriptId: transcriptRecord._id,
    videoUrl,
    title: recipe.title,
    servings: recipe.servings,
    ingredients: recipe.ingredients,
    steps: recipe.steps,
    notes: recipe.notes,
    createdAt: new Date()
  });

  return {
    recipeId: result.insertedId.toHexString(),
    transcriptId: transcriptRecord._id.toHexString(),
    recipe
  };
};
