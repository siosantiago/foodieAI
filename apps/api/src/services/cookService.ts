import { ObjectId } from "mongodb";
import { cookSessionsCollection, recipesCollection } from "../db/collections";
import { getTranscriptById } from "./videoIngest";
import { RecipeAgent } from "../agents/recipeAgent";

export const startCookSession = async (recipeId: string, userId?: string) => {
  const result = await cookSessionsCollection().insertOne({
    recipeId: new ObjectId(recipeId),
    userId,
    startedAt: new Date()
  });

  return {
    sessionId: result.insertedId.toHexString(),
    recipeId,
    userId
  };
};

export const answerCookQuestion = async (sessionId: string, question: string) => {
  const session = await cookSessionsCollection().findOne({
    _id: new ObjectId(sessionId)
  });
  if (!session) {
    throw new Error("Cook session not found");
  }

  const recipe = await recipesCollection().findOne({
    _id: session.recipeId
  });
  if (!recipe) {
    throw new Error("Recipe not found");
  }

  const transcript = await getTranscriptById(recipe.transcriptId.toHexString());
  if (!transcript) {
    throw new Error("Transcript not found");
  }

  const agent = new RecipeAgent();
  const answer = await agent.answerQuestion({
    transcript: transcript.transcript,
    question,
    steps: recipe.steps.map((step) => step.instruction)
  });

  return {
    sessionId,
    answer
  };
};
